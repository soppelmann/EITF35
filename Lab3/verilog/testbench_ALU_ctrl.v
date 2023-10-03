// Simulation parameters
`timescale 1ns / 1ps

module tb_ALU_ctrl () ;


   localparam  CLKT  = 10; // 100 MHz, 10ns
   localparam  period  = 40; // 20 MHz, 40ns

   // DUT instance parameters

   // Non-auto signals
   reg         clk   = 1'b0;
   reg         rst_n = 1'b1;

   // TODO: Init during declaration (before simulation time 0) to avoid race conditions
   /* DUT Inputs */
   reg         enter = 0; // To I_ALU_CTRL of ALU_ctrl.v
   reg         sign  = 0; // To I_ALU_CTRL of ALU_ctrl.v

   /* DUT Outputs */
   wire [3:0]   func;       // From I_ALU_CTRL of ALU_ctrl.v
   wire [1:0]   reg_ctrl;   // From I_ALU_CTRL of ALU_ctrl.v


   // System Clock
   always begin
      #(CLKT/2) clk = ~clk;
   end

   // DUT Instantiation
   ALU_ctrl I_ALU_CTRL (
                        // Inputs
                        .clk      (clk),
                        .rst_n    (rst_n),
                        .enter    (enter),
                        .sign     (sign),
                        // Outputs
                        .func     (func),
                        .reg_ctrl (reg_ctrl)
                        );


   initial begin
      $dumpfile("test.vcd");
      $dumpvars(0,tb_ALU_ctrl);

      // *************************
      // User test data pattern
      // *************************

      rst_n <= 0;
      #period;
      rst_n <= 1;
      #1;
      enter <= 1;
      #period;
      enter <= 0;
      #period;
      enter <= 1;
      #period;
      enter <= 0;
      #period;
      enter <= 1;
      #period;
      enter <= 0;
      #period;
      sign <= 1;
      #period;
      sign <= 0;
      #period;
      enter <= 1;
      #period;
      enter <= 0;
      #period;
      enter <= 1;
      #period;
      enter <= 0;
      #period;
      enter <= 1;
      #period;
      enter <= 0;
      #period;




      $display("@%0d: TEST PASSED", $time);
      //$finish;
   end

endmodule
