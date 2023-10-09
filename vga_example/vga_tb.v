// Simulation parameters
`timescale 1ns / 1ps

module tb_vga () ;

    // Simulation parameters

   localparam   CLKT  = 10; // 100 MHz

    // TODO: INIT after (verilog-auto)!!
    // DUT instance parameters

    // Non-auto signals
   reg        clk   = 1'b0;
   reg        rst_n = 1'b1;

    // TODO: Init during declaration (before simulation time 0) to avoid race conditions
    /* DUT Inputs */
  // reg        clk = 0;         // To I_VGA of vga.v
  // reg        rst_n = 0;         // To I_VGA of vga.v

    /* DUT Outputs */
   wire        io_horizontal_sync; // From I_VGA of vga.v
   wire [11:0] io_rgb_color;       // From I_VGA of vga.v
   wire        io_vertical_sync;   // From I_VGA of vga.v


    // System Clk
    always begin
        #(CLKT/2) clk = ~clk;
    end

    // TODO: Declare/Connect interfaces
    // axi4_lite_if axil_if_vga (.clk(clk), .rst_n(rst_n));
    // ...

    // TODO: Ensure SV interfaces connections
    // DUT Instantiation
   vga I_VGA (
              // Outputs
              .io_horizontal_sync (io_horizontal_sync),
              .io_vertical_sync   (io_vertical_sync),
              .io_rgb_color       (io_rgb_color),
              // Inputs
              .clock              (clk),
              .reset              (rst_n)
              );


    // TODO: Tasks/functions
    // ...

    // TODO: TB Objects
    // axi4_lite_bfm bfm;

    // TODO: Stimuli
    initial begin
      $dumpfile("test.vcd");
      $dumpvars(0,tb_vga);
        // bfm = new(axil_if_vga);
        //
        #10 rst_n = 0;


       #100;


       $display("@%0d: TEST PASSED", $time);
        $finish;
    end

endmodule
