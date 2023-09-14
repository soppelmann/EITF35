module convert_to_binary
  (input  [7:0] scan_code_in,
   output [3:0] binary_out);

  wire [7:0] scan_code_in;
  reg [3:0] binary_out;

  /* convert_to_binary.vhd:16:17  */
  always @ (scan_code_in) begin
    case (scan_code_in)
      8'h00: binary_out = 4'b1111;
      8'h46: binary_out = 4'b1001;
      8'h3E: binary_out = 4'b1000;
      8'h3D: binary_out = 4'b0111;
      8'h36: binary_out = 4'b0110;
      8'h2E: binary_out = 4'b0101;
      8'h25: binary_out = 4'b0100;
      8'h26: binary_out = 4'b0011;
      8'h1E: binary_out = 4'b0010;
      8'h16: binary_out = 4'b0001;
      8'h45: binary_out = 4'b0000;
      default: binary_out = 4'b1010;
    endcase // case (n25_o)
  end // always @ (scan_code_in)

endmodule
