module edge_detector
  (input  clk,
   input  rst,
   input  kb_clk_sync,
   output reg edge_found);

  reg kb_clk_in;

  always @(posedge clk)
  if(~rst) begin
    kb_clk_in <= 0;
  end else begin
    kb_clk_in <= kb_clk_sync;
    edge_found <= (~kb_clk_sync & kb_clk_in);
  end

endmodule
