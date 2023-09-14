module keyboard_top
  (input        clk,
   input        rst,
   input        kb_data,
   input        kb_clk,
   output [7:0] sc,
   output [7:0] num,
   output [3:0] seg_en);

   // set up all ports here

   wire [7:0] scan_code_out;
   wire       edge_found;
   wire       kb_data_sync;
   wire       kb_clk_sync;
   wire       valid_scan_code;
   wire [7:0] code_to_display;
   wire [7:0] sev_seg;
   wire [3:0] binary_out;
   wire [3:0] binary_num;


   // connect all ports here
   sync_keyboard sync_keyboard_inst (
                                     .clk(clk),
                                     .kb_clk(kb_clk),
                                     .kb_data(kb_data),
                                     .kb_clk_sync(kb_clk_sync),
                                     .kb_data_sync(kb_data_sync));
   /* keyboard_top.vhd:113:5  */



   // module followed by DUT name
   edge_detector edge_detector_inst (
                                     .clk(clk),
                                     .rst(rst),
                                     .kb_clk_sync(kb_clk_sync),
                                     .edge_found(edge_found));


   /* keyboard_top.vhd:124:5  */
   convert_scancode convert_scancode_inst (
                                           .clk(clk),
                                           .rst(rst),
                                           .edge_found(edge_found),
                                           .serial_data(kb_data_sync),
                                           .valid_scan_code(valid_scan_code),
                                           .scan_code_out(scan_code_out));



   /* keyboard_top.vhd:138:5  */
   keyboard_ctrl keyboard_ctrl_inst (
                                     .clk(clk),
                                     .rst(rst),
                                     .valid_code(valid_scan_code),
                                     .scan_code_in(scan_code_out),
                                     .code_to_display(code_to_display),
                                     .seg_en(seg_en));



   /* keyboard_top.vhd:148:5  */
   convert_to_binary convert_to_binary_inst (
                                             .scan_code_in(code_to_display),
                                             .binary_out(binary_out));



   /* keyboard_top.vhd:155:5  */
   binary_to_sg binary_to_sg_inst (
                                   .binary_in(binary_num),
                                   .sev_seg(sev_seg));
endmodule
