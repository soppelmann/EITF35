// Simulation parameters
`timescale 1ns / 1ps



module tb_binary_to_bcd () ;

   localparam  CLKT  = 10; // 100 MHz, 10ns
   localparam  period  = 40; // 20 MHz, 40ns


    // TODO: INIT after (verilog-auto)!!
    // DUT instance parameters

    // Non-auto signals
   reg       Clk       = 1'b0;
   reg       Rst_n     = 1'b1;

    // TODO: Init during declaration (before simulation time 0) to avoid race conditions
    /* DUT Inputs */
   reg [7:0] binary_in = 0; // To I_BINARY_TO_BCD of binary_to_bcd.v

    /* DUT Outputs */
   wire [9:0] bcd_out;        // From I_BINARY_TO_BCD of binary_to_bcd.v


    // System Clock
    always begin
        #(CLKT/2) Clk = ~Clk;
    end

    // TODO: Declare/Connect interfaces
    // axi4_lite_if axil_if_binary_to_bcd (.Clk(Clk), .Rst_n(Rst_n));
    // ...

    // TODO: Ensure SV interfaces connections
    // DUT Instantiation
   binary_to_bcd I_BINARY_TO_BCD (
                                  // Outputs
                                  .bcd_out   (bcd_out),
                                  // Inputs
                                  .binary_in (binary_in)
                                  );


    // TODO: Tasks/functions
    // ...

    // TODO: TB Objects
    // axi4_lite_bfm bfm;

    // TODO: Stimuli
   initial begin
      $dumpfile("test.vcd");
      $dumpvars(0,tb_binary_to_bcd);

      #period;

      binary_in <= 8'b1111_1001;

      #period;



      $display("@%0d: TEST PASSED", $time);
      //$finish;
   end

endmodule
