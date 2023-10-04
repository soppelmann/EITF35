// Simulation parameters
`timescale 1ns / 1ps

module tb_ALU_top () ;

   localparam  CLKT  = 10; // 100 MHz, 10ns
   //localparam  CLKT  = 2; // 100 MHz, 10ns
   localparam  period  = 40; // 20 MHz, 40ns

    // DUT instance parameters

    // Non-auto signals
   reg       clk     = 1'b0;
   reg       rst_n   = 1'b1;

    /* DUT Inputs */
   reg       b_enter = 0; // To I_ALU_TOP of ALU_top.v
   reg       b_sign  = 0; // To I_ALU_TOP of ALU_top.v
   reg [7:0] sw_in   = 0; // To I_ALU_TOP of ALU_top.v

    /* DUT Outputs */
   wire [7:0] anode;        // From I_ALU_TOP of ALU_top.v
   wire [7:0] sev_seg;      // From I_ALU_TOP of ALU_top.v


    // System Clock
    always begin
        #(CLKT/2) clk = ~clk;
    end

    // DUT Instantiation
   ALU_top I_ALU_TOP (
                      // Inputs
                      .clk     (clk),
                      .rst_n   (rst_n),
                      .b_enter (b_enter),
                      .b_sign  (b_sign),
                      .sw_in   (sw_in),
                      // Outputs
                      .sev_seg (sev_seg),
                      .anode   (anode)
                      );

   initial begin
      $dumpfile("test.vcd");
      $dumpvars(0,tb_ALU_top);

      rst_n <= 0;
      #1;
      rst_n <= 1;
      #period;

      sw_in <= 8'b0000_0011;
      #period;
      b_enter <= 1;
      #period;
      b_enter <= 0;
      #period;
      sw_in <= 8'b0000_0100;
      #period;
      b_enter <= 1;
      #period;
      b_enter <= 0;
      #period;
      b_enter <= 1;
      #period;
      b_enter <= 0;
      #period;
      b_enter <= 1;
      #period;
      b_enter <= 0;
      #period;
      b_enter <= 1;
      #period;
      b_enter <= 0;
      #period;


      $display("@%0d: TOP TEST PASSED", $time);
      $finish;
   end

endmodule
