module edge_detector
  (input  clk,
   input  rst,
   input  kb_clk_sync,
   output edge_found);

  localparam n1_o = 1'bZ;
  assign edge_found = n1_o;

endmodule
