module ALU_top(
               input        clk,
               input        rst_n,
               input        b_enter,
               input        b_sign,
               input [7:0]  sw_in,
               output [6:0] sev_seg,
               output [3:0] anode
               );


   // .modport(topport)
   debouncer enter_debouncer(
                             .clk(clk),
                             .rst_n(rst_n),
                             .button_in(b_enter),
                             .button_out(sev_seg)
                             );

   debouncer sign_debouncer(
                             .clk(clk),
                             .rst_n(rst_n),
                             .button_in(b_sign),
                             .button_out(anode)
                             );









endmodule
