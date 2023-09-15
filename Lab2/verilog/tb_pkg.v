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


   // schem = 1 to generate schematics
   localparam schem = 0;


   // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
   localparam period = 40;

   always #5 clk <= !clk;

   always #20 kb_clk <= !kb_clk;

   initial // initial block executes only once
     begin


        // these need to be commented out for schematics
        if (schem == 0) begin
           $dumpfile("test.vcd");
           $dumpvars(0,tb_pkg);
        end

        // start sending data
        // values for a and b

        #period; // wait for period
        rst <= 1;

        //0xF0, 11 bit long
        #period;

        //SB
        kb_data = 0;
        #period;

        //payload for BC
        kb_data = 1;
        #period;


        kb_data = 1;
        #period;

        kb_data = 1;



        #period
          kb_data = 1;

        #period;

        kb_data = 0;

        #period;

        kb_data = 0;


        #period;
        kb_data = 0;

        #period;

        kb_data = 0;

        #period;

        //parity and stop
        kb_data = 0;
        #period;

        kb_data = 0;


        // 0x16, 11 bit long
        #period;

        //SB
        kb_data = 0;
        #period;

        //payload
        kb_data = 0;
        #period;


        kb_data = 0;
        #period;

        kb_data = 0;



        #period
          kb_data = 1;

        #period;

        kb_data = 0;

        #period;

        kb_data = 1;


        #period;
        kb_data = 1;

        #period;

        kb_data = 0;

        #period;
        //parity and stop
        kb_data = 0;
        #period;

        kb_data = 0;


        //0xF0, 11 bit long
        #period;

        kb_data = 0;
        #period;
        //payload
        kb_data = 1;
        #period;


        kb_data = 1;
        #period;

        kb_data = 1;



        #period
          kb_data = 1;

        #period;

        kb_data = 0;

        #period;

        kb_data = 0;


        #period;
        kb_data = 0;

        #period;

        kb_data = 0;

        #period;
        //parity and stop
        kb_data = 0;
        #period;

        kb_data = 0;

        //0x1E
        #period;

        kb_data = 0;
        #period;

        kb_data = 0;
        #period;

        kb_data = 0;
        #period;

        kb_data = 0;
        #period;

        kb_data = 0;
        #period;

        kb_data = 0;

        #period
          //payload

          kb_data = 1;

        #period

          kb_data = 1;

        #period;

        kb_data = 1;

        #period;

        kb_data = 1;

        #period;
        kb_data = 0;

        #period;

        kb_data = 0;

        if (schem == 0) begin
           $finish();
        end




     end // initial begin
endmodule
