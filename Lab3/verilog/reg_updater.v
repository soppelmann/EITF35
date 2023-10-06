module reg_updater (
                   input        clk,
                   input        rst_n,
                   input [1:0]  reg_ctrl, //2'b01 for A 2'b10 for B
                   input [7:0]  sw_input,
                   output [7:0] A,
                   output [7:0] B
                    );

   reg [7:0] r_A,r_B;


   // If changed to clk we can change the value of B during computations, cool?
   // Unsure about this
   always @(reg_ctrl or rst_n or sw_input) begin
      if (!rst_n) begin
         r_A <= 8'b0;
         r_B <= 8'b0;
      end else begin
         case (reg_ctrl)
           2'b00: r_A <= sw_input;
           2'b01: r_B <= sw_input;
           default: // Handle any other values of reg_ctrl, maybe add in alu_ctrl to use this
             begin
                r_A <= r_A;
                r_B <= r_B;
             end
         endcase

      end
   end

   assign A = r_A;
   assign B = r_B;



endmodule
