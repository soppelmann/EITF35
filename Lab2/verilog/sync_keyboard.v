module sync_keyboard
  (input  clk,
   input  kb_clk,
   input  kb_data,
   output kb_clk_sync,
   output kb_data_sync);
  localparam n2_o = 1'bZ;
  localparam n3_o = 1'bZ;
  assign kb_clk_sync = n2_o;
  assign kb_data_sync = n3_o;
endmodule

