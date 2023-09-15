module sync_keyboard
  (input  clk,
   input  kb_clk,
   input  kb_data,
   output reg kb_clk_sync,
   output reg kb_data_sync);

  reg kb_data_sync_1, kb_clk_1;

//maybe add kb_clk, chatgpt suggested
  always @ (posedge clk)
  begin
    kb_data_sync_1 <= kb_data;
    kb_data_sync <= kb_data_sync_1;

    kb_clk_1 <= kb_clk;
    kb_clk_sync <= kb_clk_1;
  end
endmodule
