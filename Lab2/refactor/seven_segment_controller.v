`timescale 1ns / 1ps


module seven_segment_controller(input               clk,
                            input               reset_n,
                            input [31:0]        val_in,
                            output wire[7:0]   cat_out,
                            output wire[7:0]   an_out
    );
  
    reg [7:0]      segment_state;
    reg [31:0]     segment_counter;
    reg [7:0]     routed_vals;
    wire [7:0]     led_out;
    
    sc_to_seven_seg my_converter ( .val_in(routed_vals), .led_out(led_out));
    assign cat_out = led_out; //siffran som ska lysa
    assign an_out = ~segment_state; //segment to enable

    
    always @* begin
        case(segment_state)
            8'b0000_0001:   routed_vals = val_in[7:0];
            8'b0000_0010:   routed_vals = val_in[15:8];
            8'b0000_0100:   routed_vals = val_in[23:16];
            8'b0000_1000:   routed_vals = val_in[31:24];
            default:        routed_vals = val_in[7:0];       
        endcase
    end
    
    always @(posedge clk)begin
        if (~reset_n)begin
            segment_state <= 8'b0000_0001;
            segment_counter <= 32'b0;
        end else begin
            if (segment_counter == 32'd100_000)begin
                segment_counter <= 32'd0;
                segment_state <= {segment_state[7:4],segment_state[2:0],segment_state[3]};
            end else begin
                segment_counter <= segment_counter +1;
            end
        end
    end
        
endmodule //seven_seg_controller


//feel free to either include binary_to_seven_seg module here or in its own file!
module sc_to_seven_seg ( input [7:0] val_in, output wire [7:0] led_out);
    //
    //  your previously written function
    //
    
    reg [7:0] int_seven_segment_number;
    
    //shift this in every clk
    always @* begin
          case(val_in)
            8'h45 : int_seven_segment_number = 8'b11000000; //0
    
            8'h16 :  int_seven_segment_number = 8'b11111001; //1
    
            8'h1e:  int_seven_segment_number = 8'b10100100; //2
    
            8'h26:  int_seven_segment_number = 8'b10110000; //...
    
            8'h25:  int_seven_segment_number = 8'b10011001;
    
            8'h2e:  int_seven_segment_number = 8'b10010010;
    
            8'h36: int_seven_segment_number = 8'b10000010;
    
            8'h3d: int_seven_segment_number = 8'b11111000;
    
            8'h3e: int_seven_segment_number = 8'b10000000;
    
            8'h46: int_seven_segment_number = 8'b10010000; //9

            8'h1C: int_seven_segment_number = 8'b10001000; //A
            
            8'h32: int_seven_segment_number = 8'b10000011; //B
                        
            8'h21: int_seven_segment_number = 8'b11000110; //C
                                    
            8'h33: int_seven_segment_number = 8'b10001001; //H
    
            8'h44: int_seven_segment_number = 8'b11000000; //O
                
            8'h0 : int_seven_segment_number = 8'b11111111; //off
    
            default : int_seven_segment_number = 8'b10000110; //error
    
    
    endcase
    end
    
    assign led_out = int_seven_segment_number;
    
endmodule // binary_to_seven