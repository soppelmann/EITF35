module ALU_ctrl (
                 input        clk,
                 input        rst_n,
                 input        enter,
                 input        sign,
                 output wire [3:0] func,
                 output wire [1:0] reg_ctrl
                 );

    reg [3:0] state, next_state;
    reg [1:0] i_reg, next_i_reg;
    reg last_enter, last_sign;

   always @(posedge clk or negedge rst_n) begin
      if(~rst_n) begin
         state <= 0;
         i_reg <= 2'b00;
      end else begin
         state <= next_state;
         i_reg <= next_i_reg;
      end
   end

   //yosys really doesnt like posedge enter due to async reset on next_state?
   always @(enter or sign) begin
      next_state = state;
      next_i_reg = i_reg;
      

      if (enter /*&& ~last_enter*/) begin

         case (state)
           //Input to reg A
           4'b0000: begin
              next_state = 4'b0001;
              next_i_reg = 2'b01;
           end
           //Input to reg B
           4'b0001: begin
              next_state = 4'b0010;
              next_i_reg = 2'b11;
           end
           //cycle through states, staying in same sign
           4'b0010: next_state = 4'b0011; 
           4'b0011: next_state = 4'b0100;
           4'b0100: next_state = 4'b0010;
           4'b1010: next_state = 4'b1011;
           4'b1011: next_state = 4'b1100;
           4'b1100: next_state = 4'b1010;
           default: next_state = 4'b0000;
         endcase

      end else if (sign /*&& ~last_sign*/) begin

         case (state)
            //In the input states, do nothing
           4'b0000: next_state = 4'b0000;
           4'b0001: next_state = 4'b0001;
           //Switch between signstates
           4'b0010: next_state = 4'b1010;
           4'b0011: next_state = 4'b1011;
           4'b0100: next_state = 4'b1100;
           4'b1010: next_state = 4'b0010;
           4'b1011: next_state = 4'b0011;
           4'b1100: next_state = 4'b0100;
           default: next_state = 4'b0000;
         endcase

      end else begin
         next_state = state;
         next_i_reg = i_reg;
      end
      
      last_enter = enter;
      last_sign = sign;
   end

    assign func = state;
    assign reg_ctrl = i_reg;

endmodule
