module tb_pkg;

   reg clk = 0;
   reg rst = 0;
   reg kb_data = 1;
   reg kb_clk = 0;
   wire [7:0] sc = 0;
   wire [7:0] num = 0;
   wire [3:0] seg_en = 0;

   keyboard_top DUT (
                     .clk(clk),
                     .rst(rst),
                     .kb_data(kb_data),
                     .sc(sc),
                     .num(num),
                     .seg_en(seg_en),
                     .kb_clk(kb_clk)
                     );


   // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
   localparam period = 40;

   always #5 clk <= !clk;

   always #20 kb_clk <= !kb_clk;

   initial // initial block executes only once
     begin

        $dumpfile("test.vcd");
        $dumpvars(0,kb_data);
        // start sending data
        // values for a and b
        kb_data = 0;

        #period; // wait for period
        kb_data = 1;

        #period;

        kb_data = 0;

        #period;

        kb_data = 0;

        #period;


        $finish();
     end // initial begin
endmodule
