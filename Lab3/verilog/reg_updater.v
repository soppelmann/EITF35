module reg_updater (
                   input        clk,
                   input        rst_n,
                   input [1:0]  reg_ctrl, //2'b01 for A 2'b10 for B
                   input [7:0]  sw_input,
                   output [7:0] A,
                   output [7:0] B
                    );

   reg [7:0] r_A,r_B, next_r_A, next_r_B;


   // If changed to clk we can change the value of B during computations, cool?
   // Unsure about this
   always@(posedge clk) begin
    if (!rst_n) begin
        r_A <= 8'b0;
        r_B <= 8'b0;
     end else begin
        r_A <= next_r_A;
        r_B <= next_r_B;
     end
   end
   
   always @(*) begin
    next_r_A = r_A;
    next_r_B = r_B;
     case (reg_ctrl)
       2'b00: next_r_A <= sw_input;
       2'b01: next_r_B <= sw_input;
       default: // Handle any other values of reg_ctrl, maybe add in alu_ctrl to use this
         begin
            next_r_A <= r_A;
            next_r_B <= r_B;
         end
     endcase
   end

   assign A = r_A;
   assign B = r_B;



endmodule
