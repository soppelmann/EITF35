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
   reg [3:0]      routed_vals;
   wire [7:0]     led_out;

   sc_to_seven_seg my_converter ( .BCD_digit(routed_vals), .led_out(led_out));
   assign segment = led_out; //siffran som ska lysa
   assign digit_anode = ~segment_state; //segment to enable

   //Also add sign for sign and overflow led
   always @* begin
      case(segment_state)
        8'b0000_0001:   routed_vals = BCD_digit[3:0]; //ental
        8'b0000_0010:   routed_vals = BCD_digit[7:4]; //tiotal
        8'b0000_0100:   routed_vals = {2'b00 , BCD_digit[9:8]}; //hundratal
        8'b0000_1000:   begin
            if(sign) begin
                routed_vals = 4'b1011;
            end else begin
                routed_vals = 4'b1111;
            end
        end
        8'b0001_0000:   begin
                    if(overflow) begin
                        routed_vals = 4'b1100;
                    end else begin
                        routed_vals = 4'b1111;
                    end
                end
        default:        routed_vals = BCD_digit[7:0];
      endcase
   end

   always @(posedge clk or negedge rst_n)begin
      if (~rst_n)begin
         segment_state <= 8'b0000_0001;
         segment_counter <= 32'b0;
      end else begin
         if (segment_counter == 32'd100_000)begin
            segment_counter <= 32'd0;
            segment_state <= {segment_state[7:5],segment_state[3:0],segment_state[4]};
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
        4'b0000 : int_seven_segment_number = 8'b11000000; //0

        4'b0001 :  int_seven_segment_number = 8'b11111001; //1

        4'b0010:  int_seven_segment_number = 8'b10100100; //2

        4'b0011:  int_seven_segment_number = 8'b10110000; //...

        4'b0100:  int_seven_segment_number = 8'b10011001;

        4'b0101:  int_seven_segment_number = 8'b10010010;

        4'b0110: int_seven_segment_number = 8'b10000010;

        4'b0111: int_seven_segment_number = 8'b11111000;

        4'b1000: int_seven_segment_number = 8'b10000000;

        4'b1001: int_seven_segment_number = 8'b10010000; //9
        
        4'b1011: int_seven_segment_number = 8'b10111111; //-

        4'b1111 : int_seven_segment_number = 8'b11111111; //off

        default : int_seven_segment_number = 8'b10001110; //overflow


      endcase
   end

    assign led_out = int_seven_segment_number;

endmodule // sc_to_seven_seg