module tb_pkg;

   reg clk = 0;
   reg rst = 0;
   reg kb_data = 1;
   reg kb_clk = 0;
   wire [7:0] sc = 0;
   wire [7:0] num = 0;
   wire [3:0] seg_en = 0;

   // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
   localparam period = 40;

   always #5 clk <= !clk;

   always #20 kb_clk <= !kb_clk;



   initial // initial block executes only once
     begin
        // values for a and b
        a = 0;
        b = 0;
        #period; // wait for period

        a = 0;
        b = 1;
        #period;

        a = 1;
        b = 0;
        #period;

        a = 1;
        b = 1;
        #period;
     end // initial begin
endmodule
