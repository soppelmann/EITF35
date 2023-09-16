module keyboard_controller(
    input clk,
    input reset_n,
    input valid_scan_code,
    input [7:0] scan_code,
    output reg [31:0] scan_codes
);


   reg [1:0] state, next_state;

   // Debug variables
   reg [8:0]  TEST_CTRL_1 = 0;
   reg [8:0]  TEST_CTRL_2 = 0;
   reg [8:0]  TEST_CTRL_3 = 0;
   reg [8:0]  TEST_CTRL_4 = 0;

   // Immediately after negedge valid_scan_code the valid scan code appears on input
   // so it looks like following

   // negedge valid_scan_code
   // scan_code == 16
   // negedge valid_scan_code
   // scan_code == F0
   // negedge valid_scan_code
   // scan_code == 16

   always @(posedge clk, negedge reset_n)
     // Setup if reset
     if (~reset_n) begin
        state <= 0;
        next_state <= 0;  //not popular
        scan_codes <= 0;


     end else begin
        //update state on every clock cycle
        state   <= next_state;
     end

   // valid code looks at something,
   always @(posedge valid_scan_code or negedge valid_scan_code or valid_scan_code) begin

      if (valid_scan_code) begin
         case (state)

           2'b00: begin // we dont enter this state because we reach it one clk cycle too early
              if (scan_code == 8'h0F) begin //next scan code will be a make code and sent to the display
                 next_state <= 1;

              end else begin

              end
           end

           2'b01: begin //only enter here if prev scan code was 240 == break
              scan_codes[7:0] <= scan_codes;
              next_state <= 0;
           end

         endcase  // case (state)
      end  // if (valid_code)

end

endmodule
