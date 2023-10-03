`timescale 1ns / 1ps
module seven_segment_driver (
                             input        clk,
                             input        rst_n,
                             input [9:0]  BCD_digit, //this is basically 3 digits
                             input        sign,
                             input        overflow,
                             output [7:0] digit_anode, //segment enable
                             output [7:0] segment //number to show
                             );

    reg [7:0]      segment_state;
    reg [31:0]     segment_counter;
    reg [3:0]     routed_vals;
    wire [7:0]     led_out;

    sc_to_seven_seg my_converter ( .BCD_digit(routed_vals), .led_out(led_out));
    assign segment = led_out; //siffran som ska lysa
    assign digit_anode = ~segment_state; //segment to enable


    always @* begin
        case(segment_state)
            8'b0000_0001:   routed_vals = BCD_digit[3:0]; //ental
            8'b0000_0010:   routed_vals = BCD_digit[7:4]; //tiotal
            8'b0000_0100:   routed_vals = {2'b00 , BCD_digit[9:8]}; //hundratal
            default:        routed_vals = BCD_digit[7:0];
        endcase
    end

    always @(posedge clk)begin
        if (~rst_n)begin
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


module sc_to_seven_seg ( input [3:0] BCD_digit, output wire [7:0] led_out);

    reg [7:0] int_seven_segment_number;

    //shift this in every clk
    always @* begin
          case(BCD_digit)
            //create mapping here for BCD_digits to numbers

            default : int_seven_segment_number = 8'b10000110; //error


    endcase
    end

    assign led_out = int_seven_segment_number;

endmodule // sc_to_seven_seg
