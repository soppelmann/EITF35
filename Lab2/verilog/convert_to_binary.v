module convert_to_binary
  (input  [7:0] scan_code_in,
   output [3:0] binary_out);
  wire n4_o;
  wire n6_o;
  wire n8_o;
  wire n10_o;
  wire n12_o;
  wire n14_o;
  wire n16_o;
  wire n18_o;
  wire n20_o;
  wire n22_o;
  wire n24_o;
  wire [10:0] n25_o;
  reg [3:0] n38_o;
  assign binary_out = n38_o;
  /* convert_to_binary.vhd:17:25  */
  assign n4_o = scan_code_in == 8'b01000101;
  /* convert_to_binary.vhd:19:25  */
  assign n6_o = scan_code_in == 8'b00010110;
  /* convert_to_binary.vhd:21:25  */
  assign n8_o = scan_code_in == 8'b00011110;
  /* convert_to_binary.vhd:23:25  */
  assign n10_o = scan_code_in == 8'b00100110;
  /* convert_to_binary.vhd:25:25  */
  assign n12_o = scan_code_in == 8'b00100101;
  /* convert_to_binary.vhd:27:25  */
  assign n14_o = scan_code_in == 8'b00101110;
  /* convert_to_binary.vhd:29:25  */
  assign n16_o = scan_code_in == 8'b00110110;
  /* convert_to_binary.vhd:31:25  */
  assign n18_o = scan_code_in == 8'b00111101;
  /* convert_to_binary.vhd:33:25  */
  assign n20_o = scan_code_in == 8'b00111110;
  /* convert_to_binary.vhd:35:25  */
  assign n22_o = scan_code_in == 8'b01000110;
  /* convert_to_binary.vhd:37:25  */
  assign n24_o = scan_code_in == 8'b00000000;
  assign n25_o = {n24_o, n22_o, n20_o, n18_o, n16_o, n14_o, n12_o, n10_o, n8_o, n6_o, n4_o};
  /* convert_to_binary.vhd:16:17  */
  always @*
    case (n25_o)
      11'b10000000000: n38_o = 4'b1111;
      11'b01000000000: n38_o = 4'b1001;
      11'b00100000000: n38_o = 4'b1000;
      11'b00010000000: n38_o = 4'b0111;
      11'b00001000000: n38_o = 4'b0110;
      11'b00000100000: n38_o = 4'b0101;
      11'b00000010000: n38_o = 4'b0100;
      11'b00000001000: n38_o = 4'b0011;
      11'b00000000100: n38_o = 4'b0010;
      11'b00000000010: n38_o = 4'b0001;
      11'b00000000001: n38_o = 4'b0000;
      default: n38_o = 4'b1010;
    endcase
endmodule

