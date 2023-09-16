module synchronizer(
    input clk,
    input reset_n,
    input unsynched,
    output reg synched
);

reg in_buffed;

//maybe add kb_clk, chatgpt suggested
  always @ (posedge clk)
  begin
    in_buffed <= unsynched;
    synched <= in_buffed;
  end




endmodule
