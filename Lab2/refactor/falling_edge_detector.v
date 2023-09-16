module falling_edge_detector(
    input clk,
    input reset_n,
    input in,
    output reg edge_found
);

   //detect a falling edge on an input
   reg in_d; //one cc delay


   always @(posedge clk or negedge reset_n)
     if(~reset_n) begin
        in_d <= 0;
     end else begin
        in_d <= in;
        edge_found <= (~in && in_d);
     end


endmodule
