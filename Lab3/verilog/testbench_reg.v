// Simulation parameters
`timescale 1ns / 1ps

module tb_reg_updater () ;

   localparam  CLKT  = 10; // 100 MHz, 10ns
   localparam  period  = 40; // 20 MHz, 40ns

    // TODO: INIT after (verilog-auto)!!
    // DUT instance parameters

    // Non-auto signals
   reg       clk      = 1'b0;
   reg       rst_n    = 1'b1;

    // TODO: Init during declaration (before simulation time 0) to avoid race conditions
    /* DUT Inputs */
   reg [1:0] reg_ctrl = 0; // To I_REG_UPDATER of reg_updater.v
   reg [7:0] sw_input = 0; // To I_REG_UPDATER of reg_updater.v

    /* DUT Outputs */
   wire [7:0] A;             // From I_REG_UPDATER of reg_updater.v
   wire [7:0] B;             // From I_REG_UPDATER of reg_updater.v


    // System Clock
    always begin
        #(CLKT/2) clk = ~clk;
    end

    // DUT Instantiation
   reg_updater I_REG_UPDATER (
                              // Outputs
                              .A        (A),
                              .B        (B),
                              // Inputs
                              .clk      (clk),
                              .rst_n    (rst_n),
                              .reg_ctrl (reg_ctrl),
                              .sw_input (sw_input)
                              );
   initial begin

      $dumpfile("test.vcd");
      $dumpvars(0,tb_reg_updater);

      sw_input <= 8'b0000_0011;
      #period;

      reg_ctrl <= 2'b01;
      #period;

      sw_input <= 8'b0000_1100;

      #period;

      reg_ctrl <= 2'b10;

      #period;


      #period;

      $display("@%0d: reg_updater TEST PASSED", $time);
      $finish;
   end

endmodule
