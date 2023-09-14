module keyboard_ctrl
(input        clk,
 input        rst,
 input        valid_code,
 input [7:0]  scan_code_in,
 output [7:0] code_to_display,
 output [3:0] seg_en);
   //  localparam [7:0] n2_o = 8'bZ;
   //  localparam [3:0] n3_o = 4'bZ;
   //  assign code_to_display = n2_o;
   //  assign seg_en = n3_o;
endmodule
