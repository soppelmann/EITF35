module edge_detector
  (input      clk,
   input      rst,
   input      kb_clk_sync,
   output reg edge_found);

   reg kb_clk_sync_d;

   always @(posedge clk or negedge rst)
     if(~rst) begin
        kb_clk_sync_d <= 0;
     end else begin
        kb_clk_sync_d <= kb_clk_sync;
        edge_found <= (~kb_clk_sync && kb_clk_sync_d);
     end

endmodule
