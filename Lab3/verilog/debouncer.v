module debouncer (
                  input  clk,
                  input  rst_n,
                  input  button_in,
                  output button_out
                  );

   reg [19:0] count; //Range to count 20ms with 50 MHz clock
   reg        button_tmp;

   always @(posedge clk) begin
      if (!rst_n) begin
         /*AUTORESET*/
         count <= 0;
      end
      else begin
         count <= count + 1;
         button_tmp <= button_in;

         if (count == 0) begin
            button_out <= button_tmp;
         end else
           begin
           // do nothing
           end
      end // else: !if(!rst_n)
   end // always @ (posedge clk)


endmodule
