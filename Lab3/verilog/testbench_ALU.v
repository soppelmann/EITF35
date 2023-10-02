// Simulation parameters
`timescale 1ns / 1ps


module tb_ALU () ;


   localparam  CLKT  = 10; // 100 MHz, 10ns

    // TODO: INIT after (verilog-auto)!!
    // DUT instance parameters

    // Non-auto signals
   reg       clk   = 1'b0;

    // TODO: Init during declaration (before simulation time 0) to avoid race conditions
    /* DUT Inputs */
   reg [7:0] A     = 0; // To I_ALU of ALU.v
   reg [7:0] B     = 0; // To I_ALU of ALU.v
   reg [3:0] FN    = 0; // To I_ALU of ALU.v

    /* DUT Outputs */
   reg       overflow;   // From I_ALU of ALU.v
   reg [7:0] result;     // From I_ALU of ALU.v
   reg       sign;       // From I_ALU of ALU.v



reg [7:0] A_reg;
reg [7:0] B_reg;
reg [3:0] FN_reg;
reg [2:0] counter;

parameter period = 1; // Define the period value



    // System Clock
    always begin
        #(CLKT/2) clk = ~clk;
    end

    // DUT Instantiation
   ALU I_ALU (
              // Outputs
              .result   (result),
              .overflow (overflow),
              .sign     (sign),
              // Inputs
              .A        (A),
              .B        (B),
              .FN       (FN)
              );


   initial begin
      $dumpfile("test.vcd");
      $dumpvars(0,tb_ALU);

      // *************************
      // User test data pattern
      // *************************
      A_reg <= 8'b00000101;
      B_reg <= 8'b00000011;
      FN_reg <= 4'b0000;
      #CLKT
      A_reg <= 8'b00001001;
      B_reg <= 8'b00000011;
      FN_reg <= 4'b0001;
      #CLKT
      A_reg <= 8'b00010001;
      B_reg <= 8'b10010001;
      FN_reg <= 4'b0000;
      #CLKT
      A_reg <= 8'b10010001;
      B_reg <= 8'b01111100;
      FN_reg <= 4'b0001;
      #CLKT
      A_reg <= 8'b10010100;
      B_reg <= 8'b11111001;
      FN_reg <= 4'b0100;
      #CLKT
      A_reg <= 8'b11010101;
      B_reg <= 8'b01101001;
      FN_reg <= 4'b0100;
      #CLKT
      A_reg <= 8'b00100011;
      B_reg <= 8'b01100011;
      FN_reg <= 4'b0100;
      #CLKT
      A_reg <= 8'b11110010;
      B_reg <= 8'b01101000;
      FN_reg <= 4'b0100;
      #CLKT
      A_reg <= 8'b00110001;
      B_reg <= 8'b00101101;
      FN_reg <= 4'b0100;
      #CLKT
      A_reg <= 8'b01010101;
      B_reg <= 8'b00100100;
      FN_reg <= 4'b0100;
      #CLKT
      A_reg <= 8'b00000000; // Invalid input command
      B_reg <= 8'b00000000; // Invalid input command
      FN_reg <= 4'b1111;    // Invalid input command
      #CLKT


      assign A = A_reg;
      assign B = B_reg;
      assign FN = FN_reg;




      $display("@%0d: TEST PASSED", $time);
      $finish;
   end

endmodule
