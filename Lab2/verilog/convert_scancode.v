module convert_scancode
  (input  clk,
   input  rst,
   input  edge_found,
   input  serial_data,
   output valid_scan_code,
   output [7:0] scan_code_out);
  localparam n2_o = 1'bZ;
  localparam [7:0] n3_o = 8'bZ;
  assign valid_scan_code = n2_o;
  assign scan_code_out = n3_o;
endmodule

