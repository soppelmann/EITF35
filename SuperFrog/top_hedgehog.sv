// Project F: Hardware Sprites - Hedgehog (Arty Pmod VGA)
// (C)2023 Will Green, open source hardware released under the MIT License
// Learn more at https://projectf.io/posts/hardware-sprites/

//`default_nettype none
`timescale 1ns / 1ps

module top_hedgehog (
    input  wire logic clk_100m,     // 100 MHz clock
    input  wire logic btn_rst_n,    // reset button
    input wire logic btn_right,
    input wire logic btn_left,
    input wire logic btn_up,
    output      logic vga_hsync,    // horizontal sync
    output      logic vga_vsync,    // vertical sync
    output      logic [3:0] vga_r,  // 4-bit VGA red
    output      logic [3:0] vga_g,  // 4-bit VGA green
    output      logic [3:0] vga_b   // 4-bit VGA blue
    );

    // generate pixel clock
    logic clk_pix;
    logic clk_pix_locked;
    logic rst_pix;
    clock_480p clock_pix_inst (
       .clk_100m,
       .rst(!btn_rst_n),  // reset button is active low
       .clk_pix,
       /* verilator lint_off PINCONNECTEMPTY */
       .clk_pix_5x(),  // not used for VGA output
       /* verilator lint_on PINCONNECTEMPTY */
       .clk_pix_locked
    );
    always_ff @(posedge clk_pix) rst_pix <= !clk_pix_locked;  // wait for clock lock

    // display sync signals and coordinates
    localparam CORDW = 16;  // signed coordinate width (bits)
    logic signed [CORDW-1:0] sx, sy;
    logic hsync, vsync;
    logic de, frame, line;
    display_480p #(.CORDW(CORDW)) display_inst (
        .clk_pix,
        .rst_pix,
        .sx,
        .sy,
        .hsync,
        .vsync,
        .de,
        .frame,
        .line
    );



    // Setup LFSR (Linear-Feedback Shift Register)

    reg [7:0] sreg;
    always_ff @(posedge clk_pix) begin
    sreg <= {1'b0, sreg[7:1]} ^ (sreg[0] ? 8'b10111000 : 8'b0);
    end


    localparam F_CORDW = 16;  // signed coordinate width (bits)

    // screen dimensions (must match display_inst)
    localparam F_H_RES = 640;

    // colour parameters
    localparam F_CHANW = 4;         // colour channel width (bits)
    localparam F_COLRW = 3*F_CHANW;   // colour width: three channels (bits)
    localparam F_CIDXW = 4;         // colour index width (bits)
    localparam F_TRANS_INDX = 'h9;  // transparant colour index
    localparam F_PAL_FILE = "meteor_palette.mem";  // palette file

    // sprite parameters
    localparam F_SX_OFFS    =  3;  // horizontal screen offset (pixels): +1 for CLUT
    localparam F_SPR_WIDTH  = 32;  // bitmap width in pixels
    localparam F_SPR_HEIGHT = 32;  // bitmap height in pixels
    localparam F_SPR_SCALE  =  2;  // 2^2 = 4x scale
    localparam F_SPR_DRAWW  = SPR_WIDTH * 2**SPR_SCALE;  // draw width
    localparam F_SPR_SPX    =  2;  // horizontal speed (pixels/frame)
    localparam F_SPR_FILE   = "meteor.mem";  // bitmap file




   logic signed [F_CORDW-1:0] f_sprx, f_spry;  // draw sprite at position (sprx,spry)





    // sprites
    localparam SPR_CNT = 5;      // number of sprites
    // horizontal and vertical screen position of letters
    logic signed [F_CORDW-1:0] f_spr_x [SPR_CNT];
    logic signed [F_CORDW-1:0] f_spr_y [SPR_CNT];
    initial begin
        f_spr_x[0] = 158;
        f_spr_x[1] = 222;
        f_spr_x[2] = 286;
        f_spr_x[3] = 350;
        f_spr_x[4] = 414;
        f_spr_y[0] = -300;
        f_spr_y[1] = -200;
        f_spr_y[2] = -400;
        f_spr_y[3] = -500;
        f_spr_y[4] = -250;
    end

   logic f_drawing[SPR_CNT];  // drawing at (sx,sy)

    // sprite instances
    logic [SPR_CNT-1:0] f_spr_pix[SPR_CNT];  // sprite pixels
   logic [F_CIDXW-1:0] f_spr_pix_indx[SPR_CNT];  // pixel colour index

    logic [F_COLRW-1:0] f_spr_pix_colr[SPR_CNT];
    
    
    genvar m;  // for looping over sprite instances (5)
    generate for (m = 0; m < SPR_CNT; m = m + 1) begin : sprite_gen
    sprite #(
        .CORDW(F_CORDW),
        .H_RES(F_H_RES),
        .SX_OFFS(F_SX_OFFS),
        .SPR_FILE(F_SPR_FILE),
        .SPR_WIDTH(F_SPR_WIDTH),
        .SPR_HEIGHT(F_SPR_HEIGHT),
        .SPR_SCALE(F_SPR_SCALE),
        .SPR_DATAW(F_CIDXW)
        ) sprite_fall (
        .clk(clk_pix),
        .rst(rst_pix),
        .line,
        .sx,
        .sy,
        .sprx(f_spr_x[m]),
        .spry(f_spr_y[m]),
        .pix(f_spr_pix_indx[m]),
        .drawing(f_drawing[m])
    );

    clut_simple #(
        .COLRW(F_COLRW),
        .CIDXW(F_CIDXW),
        .F_PAL(F_PAL_FILE)
        ) f_clut_instance (
        .clk_write(clk_pix),
        .clk_read(clk_pix),
        .we(0),
        .cidx_write(0),
        .cidx_read(f_spr_pix_indx[m]),
        .colr_in(0),
        .colr_out(f_spr_pix_colr[m])
    );

        end endgenerate

    
    
    
    // Create for loop here maybe, try to avoid
    // falling sprites logic
   
  for (m = 0; m < SPR_CNT; m = m + 1) begin : fall_gen
    always_ff @(posedge clk_pix) begin
     if (frame) begin
        if (f_spr_y[m] > 230) f_spr_y[m] <= -300;  // move back to top of screen
        else f_spr_y[m] <= f_spr_y[m] + F_SPR_SPX;  // otherwise keep moving down
    end
    if (rst_pix) begin 
        f_sprx <= 320; //H_RES / 2
        f_spry <= -300;
    end
   end
end


    // screen dimensions (must match display_inst)
    localparam H_RES = 640;

    // colour parameters
    localparam CHANW = 4;         // colour channel width (bits)
    localparam COLRW = 3*CHANW;   // colour width: three channels (bits)
    localparam CIDXW = 4;         // colour index width (bits)
    localparam TRANS_INDX = 'hB;  // transparant colour index
    localparam PAL_FILE = "superfrog_palette.mem";  // palette file

    // sprite parameters
    localparam SX_OFFS    =  3;  // horizontal screen offset (pixels): +1 for CLUT
    localparam SPR_WIDTH  = 40;  // bitmap width in pixels
    localparam SPR_HEIGHT = 40;  // bitmap height in pixels
    localparam SPR_SCALE  =  1;  // 2^2 = 4x scale
    localparam SPR_DRAWW  = SPR_WIDTH * 2**SPR_SCALE;  // draw width
    localparam SPR_SPX    =  4;  // horizontal speed (pixels/frame)
    localparam SPR_FILE   = "superfrog.mem";  // bitmap file

    logic signed [CORDW-1:0] sprx, spry;  // draw sprite at position (sprx,spry)



    // Movement handling

    // debounce buttons
    logic sig_right, sig_left, sig_up;
    debouncer deb_right (.clk(clk_pix), .in(btn_right), .out(sig_right), .ondn(), .onup());
    debouncer deb_left (.clk(clk_pix), .in(btn_left), .out(sig_left), .ondn(), .onup());
    debouncer deb_up (.clk(clk_pix), .in(btn_up), .out(sig_up), .ondn(), .onup());



    reg flying;
    reg dead;

    always_ff @(posedge clk_pix) begin 
    
    if(sig_up && spry == 245) begin
        flying = 1;
    end else if (spry < 200) begin 
        flying = 0;
    end else flying <= flying;
    end

    // update sprite position once per frame
    always_ff @(posedge clk_pix) begin
        if (frame) begin
            if (dead == 1) spry <= spry + 1;   
            else if (sprx < -SPR_DRAWW) sprx <= H_RES;  // move back to right of screen
            else if (sprx > H_RES) sprx <= -SPR_DRAWW;  // move back to right of screen
            else if(sig_right) sprx <= sprx + SPR_SPX;
            else if(sig_left) sprx <= sprx - SPR_SPX;
            else sprx <= sprx;  // otherwise keep moving left
            
            if(flying == 1) begin 
              spry <= spry - 1;
              end
              else if (spry < 245 && !flying) begin 
                  spry <= spry + 1;
              end
            
        end
        if (rst_pix) begin  // start off screen and level with grass
            sprx <= 158; //H_RES / 2
            spry <= 245;
        end
    end


    // Hit detection
    // THIS IS BAD WE SHOULD USE f_drawing stuff!!!
//    always_ff @(posedge clk_pix) begin
//        if (frame) begin
//            if (f_spr_y[0] == 220 && (sprx - f_spr_x[0] < 20)) begin 
//               dead <= 1;
//            end else if (dead == 1) dead <= 1;
//            else dead <= 0;
//        end
//        if (rst_pix) begin
//            dead <= 0;
//        end
//    end
    logic drawing;  // drawing at (sx,sy)
    
    
    always_comb begin
    if (frame || line) begin
            if ((~f_drawing[0]) && (drawing)) begin 
               dead = 1;
            end else if (dead == 1) dead = 1;
            else dead = 0;
    end
           if (rst_pix) begin
                dead = 0;
            end
    end


    logic [CIDXW-1:0] spr_pix_indx;  // pixel colour index
    sprite #(
        .CORDW(CORDW),
        .H_RES(H_RES),
        .SX_OFFS(SX_OFFS),
        .SPR_FILE(SPR_FILE),
        .SPR_WIDTH(SPR_WIDTH),
        .SPR_HEIGHT(SPR_HEIGHT),
        .SPR_SCALE(SPR_SCALE),
        .SPR_DATAW(CIDXW)
        ) sprite_hedgehog (
        .clk(clk_pix),
        .rst(rst_pix),
        .line,
        .sx,
        .sy,
        .sprx,
        .spry,
        .pix(spr_pix_indx),
        .drawing
    );

    // colour lookup table
    logic [COLRW-1:0] spr_pix_colr;
    clut_simple #(
        .COLRW(COLRW),
        .CIDXW(CIDXW),
        .F_PAL(PAL_FILE)
        ) clut_instance (
        .clk_write(clk_pix),
        .clk_read(clk_pix),
        .we(0),
        .cidx_write(0),
        .cidx_read(spr_pix_indx),
        .colr_in(0),
        .colr_out(spr_pix_colr)
    );




    // account for transparency and delay drawing signal to match CLUT delay (1 cycle)
    logic drawing_t1; 
    always_ff @(posedge clk_pix) drawing_t1 <= drawing && (spr_pix_indx != TRANS_INDX);
    
    logic f_drawing_t1[SPR_CNT];
    for (m = 0; m < SPR_CNT; m = m + 1) begin : draw_gen
    always_ff @(posedge clk_pix) f_drawing_t1[m] <= f_drawing[m] && (f_spr_pix_indx[m] != F_TRANS_INDX);
    end



    // background colour
    logic [COLRW-1:0] bg_colr;
    always_ff @(posedge clk_pix) begin
        if (line) begin
            if      (sy == 0)   bg_colr <= 'h239;
            else if (sy == 80)  bg_colr <= 'h24A;
            else if (sy == 140) bg_colr <= 'h25B;
            else if (sy == 190) bg_colr <= 'h26C;
            else if (sy == 230) bg_colr <= 'h27D;
            else if (sy == 265) bg_colr <= 'h29E;
            else if (sy == 295) bg_colr <= 'h2BF;
            else if (sy == 320) bg_colr <= 'h260;
        end
    end

    // paint colour: sprite or background
    logic [CHANW-1:0] paint_r, paint_g, paint_b;
    //always_comb {paint_r, paint_g, paint_b} = (drawing_t1 || f_drawing_t1) ? f_spr_pix_colr : bg_colr;
//    always_comb {paint_r, paint_g, paint_b} = (f_drawing_t1) ? f_spr_pix_colr : bg_colr;



        //Draw multiple sprites and avoid overlapping issues
        // Rewrite this one to use a for loop and a single drawing booleag like for the falling blocks
        always_comb begin
        if (drawing_t1) {paint_r, paint_g, paint_b} = spr_pix_colr;
        else if (f_drawing_t1[0]) {paint_r, paint_g, paint_b} = f_spr_pix_colr[0];
        else if (f_drawing_t1[1]) {paint_r, paint_g, paint_b} = f_spr_pix_colr[1];
        else if (f_drawing_t1[2]) {paint_r, paint_g, paint_b} = f_spr_pix_colr[2];
        else if (f_drawing_t1[3]) {paint_r, paint_g, paint_b} = f_spr_pix_colr[3];
        else if (f_drawing_t1[4]) {paint_r, paint_g, paint_b} = f_spr_pix_colr[4];
        else {paint_r, paint_g, paint_b} = bg_colr;
        
        end


    // display colour: paint colour but black in blanking interval
    logic [CHANW-1:0] display_r, display_g, display_b;
    always_comb {display_r, display_g, display_b} = (de) ? {paint_r, paint_g, paint_b} : 0;

    // VGA Pmod output
    always_ff @(posedge clk_pix) begin
        vga_hsync <= hsync;
        vga_vsync <= vsync;
        vga_r <= display_r;
        vga_g <= display_g;
        vga_b <= display_b;
    end
endmodule