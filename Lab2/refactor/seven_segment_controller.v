
module seven_segment_controller(
                                input            clk,
                                input            reset_n,
                                input [31:0]     scan_codes,
                                output [7:0] seven_segment_number,
                                output [7:0] seven_segment_enable
                                );

   reg [1:0] seg_counter;
   reg [7:0] single_scan_code;
   localparam shifter = 8;
   reg [7:0]  int_seven_segment_number;
   reg [7:0]  int_seven_segment_enable;

   always @(posedge clk, negedge reset_n) begin

      if(~reset_n) begin
         seg_counter <= 0;


      end else begin
         seg_counter <= seg_counter + 1;
         if (seg_counter == 2'b11) begin
            seg_counter <= 2'b00;

         end

      end // else: !if(~reset_n)


   end

   // make a loop for cycling through which letter to flash
   // make a loop to match scan code to seven segment
   always @ (clk) begin

      //shift this in every clk
      single_scan_code = scan_codes[7:0];

      case(single_scan_code)
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

        8'h0 : int_seven_segment_number = 8'b11111111; //off

        default : int_seven_segment_number = 8'b10000110; //error

      endcase // case (sel)
   end // always @ (binary_in)


   // Block to send a scancode and flash one of the lights
   // then flash next light
   //reduce states and just shift and add 1 instead.
   always @(clk) begin
      case (seg_counter)
        2'b00: begin
           int_seven_segment_enable <= 4'b1110;
           //           int_seven_segment_number <= scan_codes[31:24]; //convert follow mapping below
        end
        2'b01: begin
           int_seven_segment_enable <= 4'b1101;
           //           int_seven_segment_number <= scan_codes[23:16];
        end
        2'b10: begin
           int_seven_segment_enable <= 4'b1011;
           //           int_seven_segment_number <= scan_codes[15:8];
        end
        2'b11: begin
           int_seven_segment_enable <= 4'b0111;
           //           int_seven_segment_number <= scan_codes[7:0];
        end
        default: begin
           int_seven_segment_enable <= 4'b0000;
           //           int_seven_segment_number <= scan_codes[7:0];
        end

      endcase  // case (seg_counter)
   end

   assign seven_segment_number = int_seven_segment_number;

   assign seven_segment_enable = int_seven_segment_enable;

   localparam SCAN_CODE_0 = 8'h45;

   localparam SCAN_CODE_1 = 8'h16;

   localparam SCAN_CODE_2 = 8'h1e;

   localparam SCAN_CODE_3 = 8'h26;

   localparam SCAN_CODE_4 = 8'h25;

   localparam SCAN_CODE_5 = 8'h2e;

   localparam SCAN_CODE_6 = 8'h36;

   localparam SCAN_CODE_7 = 8'h3d;

   localparam SCAN_CODE_8 = 8'h3e;

   localparam SCAN_CODE_9 = 8'h46;

   localparam SCAN_CODE_RESET = 8'h0;

   localparam SEVEN_SEGMENT_0 = 8'b1100_0000;
   localparam SEVEN_SEGMENT_1 = 8'b1111_1001;
   localparam SEVEN_SEGMENT_2 = 8'b1010_0100;
   localparam SEVEN_SEGMENT_3 = 8'b1011_0000;
   localparam SEVEN_SEGMENT_4 = 8'b1001_1001;
   localparam SEVEN_SEGMENT_5 = 8'b1001_0010;
   localparam SEVEN_SEGMENT_6 = 8'b1000_0010;
   localparam SEVEN_SEGMENT_7 = 8'b1111_1000;
   localparam SEVEN_SEGMENT_8 = 8'b1000_0000;
   localparam SEVEN_SEGMENT_9 = 8'b1001_0000;
   localparam SEVEN_SEGMENT_F = 8'b1000_1110;
   localparam SEVEN_SEGMENT_EMPTY = 8'b1111_1111;



endmodule
