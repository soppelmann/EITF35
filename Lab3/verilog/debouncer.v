module debouncer (
                  input  clk,
                  input  rst_n,
                  input  button_in,
                  output wire button_out
                  );

   reg [19:0] count; //Range to count 20ms with 50 MHz clock
   //reg [1:0] count; //For simulation! actually just ignore debouncer for simulation retard!
   reg        button_tmp;
   reg        reg_button_out;


   always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         /*AUTORESET*/
         button_tmp <= 0;
         reg_button_out <= 0;
         count <= 0;
      end
      else begin
         count <= count + 1;
         button_tmp <= button_in;

         if (count == 0) begin
            reg_button_out <= button_tmp;
         end else
           begin
           // do nothing
           end
      end // else: !if(!rst_n)
   end // always @ (posedge clk)

   assign button_out = reg_button_out;


endmodule
