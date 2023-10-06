// Simulation parameters
`timescale 1ns / 1ps


module tb_ALU () ;


   localparam  CLKT  = 10; // 100 MHz, 10ns
   localparam  period  = 40; // 20 MHz, 40ns

   // DUT instance parameters

   // Non-auto signals
   reg         clk   = 1'b0;

   // TODO: Init during declaration (before simulation time 0) to avoid race conditions
   /* DUT Inputs */
   reg [7:0]   A     = 0; // To I_ALU of ALU.v
   reg [7:0]   B     = 0; // To I_ALU of ALU.v
   reg [3:0]   FN    = 0; // To I_ALU of ALU.v

   /* DUT Outputs */
   wire         overflow;   // From I_ALU of ALU.v
   wire [7:0]   result;     // From I_ALU of ALU.v
   wire         sign;       // From I_ALU of ALU.v

   // System Clock
   always begin
      #(CLKT/2) clk = ~clk;
   end

   // DUT Instantiation
   ALU I_ALU (
              // Inputs
              .A        (A),
              .B        (B),
              .FN       (FN),
              // Outputs
              .result   (result),
              .overflow (overflow),
              .sign     (sign)
              );


   initial begin
      $dumpfile("test.vcd");
      $dumpvars(0,tb_ALU);

      // *************************
      // User test data pattern
      // *************************
      A <= 8'b00000101; //5
      B <= 8'b00000011; //3
      FN <= 4'b0000;
      #period;
      A <= 8'b00001001; //9
      B <= 8'b00000011; //3
      FN <= 4'b0001;
      #period;
      A <= 8'b00010001; //17
      B <= 8'b10010001; //145
      FN <= 4'b0010;
      #period;
      A <= 8'b10010001; //145
      B <= 8'b01111100; //124
      FN <= 4'b0011;
      #period;
      A <= 8'b10010100; //148
      B <= 8'b11111001; //249
      FN <= 4'b1010;
      #period;
      A <= 8'b11010101; //213
      B <= 8'b01101001; //105
      FN <= 4'b1011;
      #period;
      A <= 8'b00100011; //35
      B <= 8'b01100011; //35
      FN <= 4'b0010;
      #period;
      A <= 8'b11110010; //242
      B <= 8'b01101000; //104
      FN <= 4'b0100;
      #period;
      A <= 8'b00110001; //49
      B <= 8'b00101101; //45
      FN <= 4'b0100;
      #period;
      A <= 8'b01010101; //85
      B <= 8'b00100100; //36
      FN <= 4'b0100;
      #period;
      A <= 8'b00000000; // Invalid input command
      B <= 8'b00000000; // Invalid input command
      FN <= 4'b1111;    // Invalid input command
      #period;

      // The following operations are performed
      // Pass A
      // Pass B
      // Pass A
      // Pass B
      // Pass unsigned A + B
      // Pass unsigned A - B
      // Pass unsigned A - B
      // Pass unsigned A + B
      // Pass unsigned A - B
      // Pass unsigned max(A,
      // Pass signed A + B
      // Pass signed A - B
      // Pass signed max(A, B)
      // Invalid input command

      $display("@%0d: ALU TEST PASSED", $time);
      //$finish;
   end // initial begin

endmodule
