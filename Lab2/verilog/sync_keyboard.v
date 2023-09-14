module sync_keyboard
  (input  clk,
   input  kb_clk,
   input  kb_data,
   output kb_clk_sync,
   output kb_data_sync);
  

  reg data_1, kb_data_sync, clk_1, kb_clk_sync;

  always @ (posedge clk)
  begin 
    data_1 <= kb_data;
    kb_data_sync <= data_1;

    clk_1 <= kb_clk;
    kb_clk_sync <= clk_1;
  end

endmodule