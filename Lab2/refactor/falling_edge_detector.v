`timescale 1ns / 1ps


//mitten data stabil

module falling_edge_detector(
    input clk,
    input reset_n,
    input in,
    output edge_found
);

   //detect a falling edge on an input
   reg in_d; //one cc delay
   reg int_edge_found;

   always @(posedge clk)
     if(~reset_n) begin
        in_d <= 0;
        int_edge_found <= 0;
     end else begin
        in_d <= in;
        int_edge_found <= (~in && in_d);
     end

   assign edge_found = int_edge_found;


endmodule
