
`timescale 1ns / 1ps

module top_superfrog (
    input  wire logic clk_pix,      // pixel clock
    input  wire logic rst_pix,      // sim reset
    output      logic signed [CORDW-1:0] sdl_sx,  // horizontal SDL position
    output      logic signed [CORDW-1:0] sdl_sy,  // vertical SDL position
    output      logic sdl_de,       // data enable (low in blanking interval)
    output      logic sdl_frame,    // high at start of frame
    output      logic [7:0] sdl_r,  // 8-bit red
    output      logic [7:0] sdl_g,  // 8-bit green
    output      logic [7:0] sdl_b,   // 8-bit blue
    input  wire logic btn_rst_n,    // reset button
    input wire logic btn_right,
    input wire logic btn_left,
    input wire logic btn_up
    );

    // Header file with our localparams
    `include "top_header.vh"


    // display sync signals and coordinates

    logic signed [CORDW-1:0] sx, sy;
    logic de, frame, line;

    display_480p #(.CORDW(CORDW)) display_inst (
        .clk_pix,
        .rst_pix,
        .sx,
        .sy,
        /* verilator lint_off PINCONNECTEMPTY */
        .hsync(),
        .vsync(),
        /* verilator lint_on PINCONNECTEMPTY */
        .de,
        .frame,
        .line
    );


    // 9-bit LFSR
    logic [8:0] sreg = 0;

    lfsr #(
        .LEN(9),
        .TAPS(9'b101110010)
    ) lsfr_sf (
        .clk(clk_pix),
        .rst(rst_pix),
        .en(de),
        .seed(0),  // use default seed
        .sreg(sreg)
    );


    logic signed [CORDW-1:0] h_sprx, h_spry;  // draw sprite at position (sprx,spry)

    // update sprite position once per frame
    always_ff @(posedge clk_pix) begin
        if (frame) begin
            if (h_sprx <= -H_SPR_DRAWW) h_sprx <= H_RES;  // move back to right of screen
            else h_sprx <= h_sprx - H_SPR_SPX;  // otherwise keep moving left
        end
        if (rst_pix) begin  // start off screen and level with grass
            h_sprx <= H_RES;
            h_spry <= 280;
        end
    end

    logic h_drawing;  // drawing at (sx,sy)
    logic [H_CIDXW-1:0] h_spr_pix_indx;  // pixel colour index
    sprite #(
        .CORDW(H_CORDW),
        .H_RES(H_RES),
        .SX_OFFS(H_SX_OFFS),
        .SPR_FILE(H_SPR_FILE),
        .SPR_WIDTH(H_SPR_WIDTH),
        .SPR_HEIGHT(H_SPR_HEIGHT),
        .SPR_SCALE(H_SPR_SCALE),
        .SPR_DATAW(H_CIDXW)
        ) sprite_hedgehog (
        .clk(clk_pix),
        .rst(rst_pix),
        .line,
        .sx,
        .sy,
        .sprx(h_sprx),
        .spry(h_spry),
        .pix(h_spr_pix_indx),
        .drawing(h_drawing)
    );

    // colour lookup table
    logic [H_COLRW-1:0] h_spr_pix_colr;
    clut_simple #(
        .COLRW(H_COLRW),
        .CIDXW(H_CIDXW),
        .F_PAL(H_PAL_FILE)
        ) h_clut_instance (
        .clk_write(clk_pix),
        .clk_read(clk_pix),
        .we(0),
        .cidx_write(0),
        .cidx_read(h_spr_pix_indx),
        .colr_in(0),
        .colr_out(h_spr_pix_colr)
    );

    //END HEDGEHOG

    // BEGIN METEORS

    // # of sprites
    localparam SPR_CNT = 5;      // number of meteors

    logic signed [F_CORDW-1:0] f_spr_x [SPR_CNT];
    logic signed [F_CORDW-1:0] f_spr_y [SPR_CNT];
    logic signed [F_CORDW-1:0] init_f_spr_x [SPR_CNT];
    logic signed [F_CORDW-1:0] init_f_spr_y [SPR_CNT];

    // Initial coordinates for meteors
    initial begin
    init_f_spr_x[0] = 158;
    init_f_spr_x[1] = 222;
    init_f_spr_x[2] = 286;
    init_f_spr_x[3] = 350;
    init_f_spr_x[4] = 414;
    init_f_spr_y[0] = -300;
    init_f_spr_y[1] = -200;
    init_f_spr_y[2] = -400;
    init_f_spr_y[3] = -500;
    init_f_spr_y[4] = -250;
    end


    logic f_drawing[SPR_CNT];  // drawing meteor at (sx,sy)
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


    // In game counters
    logic dead;

    // Send meteors falling, and bounce back up when hitting ground
    for (m = 0; m < SPR_CNT; m = m + 1) begin : fall_gen
    always_ff @(posedge clk_pix) begin
     if (frame) begin
        if (f_spr_y[m] > 230) begin f_spr_y[m] <= -300; f_spr_x[m][8:0] <= sreg; end  // move back to top of screen
        else f_spr_y[m] <= f_spr_y[m] + F_SPR_SPX;  // otherwise keep moving down
    end
    if (rst_pix) begin
        f_spr_x[m] <= init_f_spr_x[m];
        f_spr_y[m] <= init_f_spr_y[m];
    end
   end
end



    reg flying;
    logic signed [CORDW-1:0] sprx, spry;  // draw sprite at position (sprx,spry)


    always_ff @(posedge clk_pix) begin

    if(btn_up && spry == 245) begin
        flying <= 1;
    end else if (spry < 180) begin
        flying <= 0;
    end else flying <= flying;
    end

    // update frog position once per frame based on game logic/inputs
    always_ff @(posedge clk_pix) begin
        if (frame) begin
            if (dead) spry <= spry + 1;
            else if (sprx < -SPR_DRAWW) sprx <= H_RES;  // move back to right of screen
            else if (sprx > H_RES) sprx <= -SPR_DRAWW;  // move back to right of screen
            else if(btn_right) sprx <= sprx + SPR_SPX;
            else if(btn_left) sprx <= sprx - SPR_SPX;
            else sprx <= sprx;  // otherwise keep moving left

            if(flying == 1) begin
                spry <= spry - 2;
                end
                else if (spry < 245 && !flying) begin
                    spry <= spry + 1;
                end

        end
        if (rst_pix) begin  // start off screen and level with grass
            sprx <= 120; //H_RES / 2
            spry <= 245;
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
        ) sprite_superfrog (
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

    // colour lookup table, map numbers to colors
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

    logic drawing;  // drawing frog at (sx,sy)

    // Frog
    // account for transparency and delay drawing signal to match CLUT delay (1 cycle)
    logic drawing_t1;
    always_ff @(posedge clk_pix) drawing_t1 <= drawing && (spr_pix_indx != TRANS_INDX);

    // Meteor
    logic f_drawing_t1[SPR_CNT];
    for (m = 0; m < SPR_CNT; m = m + 1) begin : draw_gen
		always_ff @(posedge clk_pix) f_drawing_t1[m] <= f_drawing[m] && (f_spr_pix_indx[m] != F_TRANS_INDX);
    end

    // Hedgehog
    logic h_drawing_t1;
    always_ff @(posedge clk_pix) h_drawing_t1 <= h_drawing && (h_spr_pix_indx != H_TRANS_INDX);


    // TODO: Figure out how to make this depend on SPR_CNT, avoid large fan in
    always_ff @(posedge clk_pix) begin
    if (drawing) begin
            if ((f_drawing_t1[0] || f_drawing_t1[1] || f_drawing_t1[2] || f_drawing_t1[3] || f_drawing_t1[4] || h_drawing_t1) && (drawing_t1)) begin
               dead <= 1;
            end else if (dead) dead <= 1;
            else dead <= 0;
    end
            if (rst_pix) begin
                dead <= 0;
            end
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


    // Draw multiple sprites and avoid overlapping issues
    // Rewrite this one to use a for loop and a single drawing boolean like for the falling blocks
    // Each if statement refers to new layer, each sprite has its own layer.
    always_comb begin
		if (drawing_t1) {paint_r, paint_g, paint_b} = spr_pix_colr;
		else if (h_drawing_t1) {paint_r, paint_g, paint_b} = h_spr_pix_colr;
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
        sdl_sx <= sx;
        sdl_sy <= sy;
        sdl_de <= de;
        sdl_frame <= frame;
        sdl_r <= {2{display_r}};
        sdl_g <= {2{display_g}};
        sdl_b <= {2{display_b}};
    end




endmodule
