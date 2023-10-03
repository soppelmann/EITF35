module reg_updater (
                   input        clk,
                   input        rst_n,
                   input [1:0]  reg_ctrl, //2'b01 for A 2'b10 for B
                   input [7:0]  sw_input,
                   output [7:0] A,
                   output [7:0] B
                    );

   reg [7:0] r_A,r_B;


   always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         r_A <= 8'b0;
         r_B <= 8'b0;
      end else begin
         case (reg_ctrl)
           2'b01: r_A <= sw_input;
           2'b10: r_B <= sw_input;
           default: // Handle any other values of reg_ctrl
             begin
                r_A <= 8'b0;
                r_B <= 8'b0;
             end
         endcase

      end
   end

   assign A = r_A;
   assign B = r_B;



endmodule
