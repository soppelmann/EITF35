module tb_ALU
;
  wire [7:0] a;
  wire [7:0] b;
  wire [3:0] fn;
  wire [7:0] dut_result;
  wire dut_overflow;
  wire dut_sign;
  /* tb_ALU.vhd:19:11  */
  assign a = 8'b00000101; // (signal)
  /* tb_ALU.vhd:20:11  */
  assign b = 8'b00000011; // (signal)
  /* tb_ALU.vhd:21:11  */
  assign fn = 4'b0000; // (signal)
  /* tb_ALU.vhd:30:4  */
  ALU dut (
    .A(a),
    .B(b),
    .FN(fn),
    .result(),
    .overflow(),
    .sign());
endmodule

