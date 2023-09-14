module keyboard_top
  (input        clk,
   input        rst,
   input        kb_data,
   input        kb_clk,
   output [7:0] sc,
   output [7:0] num,
   output [3:0] seg_en);



   wire kb_clk_sync;
   wire kb_data_sync;
   wire edge_found;
   wire [7:0] scan_code;
   wire       valid_scan_code;
   wire [3:0] binary_num;
   wire [7:0] code_to_display;
   wire       sync_keyboard_inst_kb_clk_sync;
   wire       sync_keyboard_inst_kb_data_sync;
   wire       edge_detector_inst_edge_found;
   wire       convert_scancode_inst_valid_scan_code;
   wire [7:0] convert_scancode_inst_scan_code_out;
   wire [7:0] keyboard_ctrl_inst_code_to_display;
   wire [3:0] keyboard_ctrl_inst_seg_en;
   wire [3:0] convert_to_binary_inst_binary_out;
   wire [7:0] binary_to_sg_inst_sev_seg;
   assign sc = scan_code;
   assign num = binary_to_sg_inst_sev_seg;
   assign seg_en = keyboard_ctrl_inst_seg_en;
   /* keyboard_top.vhd:92:12  */
   assign kb_clk_sync = sync_keyboard_inst_kb_clk_sync; // (signal)
   /* keyboard_top.vhd:92:25  */
   assign kb_data_sync = sync_keyboard_inst_kb_data_sync; // (signal)
   /* keyboard_top.vhd:93:12  */
   assign edge_found = edge_detector_inst_edge_found; // (signal)
   /* keyboard_top.vhd:94:12  */
   assign scan_code = convert_scancode_inst_scan_code_out; // (signal)
   /* keyboard_top.vhd:95:12  */
   assign valid_scan_code = convert_scancode_inst_valid_scan_code; // (signal)
   /* keyboard_top.vhd:96:12  */
   assign binary_num = convert_to_binary_inst_binary_out; // (signal)
   /* keyboard_top.vhd:97:12  */
   assign code_to_display = keyboard_ctrl_inst_code_to_display; // (signal)
   /* keyboard_top.vhd:102:5  */
   sync_keyboard sync_keyboard_inst (
                                     .clk(clk),
                                     .kb_clk(kb_clk),
                                     .kb_data(kb_data),
                                     .kb_clk_sync(sync_keyboard_inst_kb_clk_sync),
                                     .kb_data_sync(sync_keyboard_inst_kb_data_sync));
   /* keyboard_top.vhd:113:5  */
   edge_detector edge_detector_inst (
                                     .clk(clk),
                                     .rst(rst),
                                     .kb_clk_sync(kb_clk_sync),
                                     .edge_found(edge_detector_inst_edge_found));
   /* keyboard_top.vhd:124:5  */
   convert_scancode convert_scancode_inst (
                                           .clk(clk),
                                           .rst(rst),
                                           .edge_found(edge_found),
                                           .serial_data(kb_data_sync),
                                           .valid_scan_code(convert_scancode_inst_valid_scan_code),
                                           .scan_code_out(convert_scancode_inst_scan_code_out));
   /* keyboard_top.vhd:138:5  */
   keyboard_ctrl keyboard_ctrl_inst (
                                     .clk(clk),
                                     .rst(rst),
                                     .valid_code(valid_scan_code),
                                     .scan_code_in(scan_code),
                                     .code_to_display(keyboard_ctrl_inst_code_to_display),
                                     .seg_en(keyboard_ctrl_inst_seg_en));
   /* keyboard_top.vhd:148:5  */
   convert_to_binary convert_to_binary_inst (
                                             .scan_code_in(code_to_display),
                                             .binary_out(convert_to_binary_inst_binary_out));
   /* keyboard_top.vhd:155:5  */
   binary_to_sg binary_to_sg_inst (
                                   .binary_in(binary_num),
                                   .sev_seg(binary_to_sg_inst_sev_seg));
endmodule
