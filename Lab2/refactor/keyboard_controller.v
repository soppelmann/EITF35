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

   reg [8:0]  temp_code;

   always @(posedge clk, negedge reset_n)
     // Setup if reset
     if (~reset_n) begin
        state <= 0;
        next_state <= 0;
        scan_codes <= 0;
        //temp_code <= 0;

     end else begin
        //update state on every clock cycle
        state   <= next_state;
     end

   // valid code looks at something,
   always @(negedge valid_scan_code) begin
      if (~valid_scan_code) begin
         case (state)
           2'b00: begin // we dont enter this state because we reach it one clk cycle too early
              scan_codes = scan_codes << 8;
              next_state = 2'b01;
              temp_code = scan_code;
           end

           2'b01: begin
           if (scan_code == 8'hF0)
              scan_codes[7:0] <= temp_code;
             next_state <= 2'b10;
           end

           2'b10: begin
              if (scan_code == temp_code) begin
              next_state <= 2'b00;
              end else begin
                 next_state <= 2'b00;
                 end
           end


         endcase  // case (state)
      end  // if (valid_code)

end

endmodule
