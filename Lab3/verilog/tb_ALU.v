`timescale 1ns / 1ps

module tb_ALU_top () ;

   localparam  CLKT    = 10; // 100 MHz

    // TODO: INIT after (verilog-auto)!!
    // DUT instance parameters

    // Non-auto signals
   reg       Clk     = 1'b0;
   reg       Rst_n   = 1'b1;

    // TODO: Init during declaration (before simulation time 0) to avoid race conditions
    /* DUT Inputs */
   reg       b_enter = 0; // To I_ALU_TOP of ALU_top.v
   reg       b_sign  = 0; // To I_ALU_TOP of ALU_top.v
   reg       clk     = 0; // To I_ALU_TOP of ALU_top.v
   reg       rst_n   = 0; // To I_ALU_TOP of ALU_top.v
   reg [7:0] sw_in   = 0; // To I_ALU_TOP of ALU_top.v

    /* DUT Outputs */
   wire [3:0] anode;        // From I_ALU_TOP of ALU_top.v
   wire [6:0] sev_seg;      // From I_ALU_TOP of ALU_top.v


    // System Clock
    always begin
        #(CLKT/2) Clk = ~Clk;
    end

    // TODO: Declare/Connect interfaces
    // axi4_lite_if axil_if_ALU_top (.Clk(Clk), .Rst_n(Rst_n));
    // ...

    // TODO: Ensure SV interfaces connections
    // DUT Instantiation
   ALU_top I_ALU_TOP (
                      // Outputs
                      .sev_seg (sev_seg),
                      .anode   (anode),
                      // Inputs
                      .clk     (clk),
                      .rst_n   (rst_n),
                      .b_enter (b_enter),
                      .b_sign  (b_sign),
                      .sw_in   (sw_in)
                      );


    // TODO: Tasks/functions
    // ...

    // TODO: TB Objects
    // axi4_lite_bfm bfm;

    // TODO: Stimuli
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,tb_ALU_top);
        // bfm = new(axil_if_ALU_top);
        //
        // #10 Rst_n = 0;
        //
        // bfm.read();
        // bfm.write();
        // ...
        // ...
        $display("@%0d: TEST PASSED", $time);
        $finish;
    end

endmodule
