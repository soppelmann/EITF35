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




      $display("@%0d: TEST PASSED", $time);
      $finish;
   end

endmodule
