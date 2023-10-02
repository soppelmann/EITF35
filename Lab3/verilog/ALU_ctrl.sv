module ALU_ctrl (
                 input        clk,
                 input        rst_n,
                 input        enter,
                 input        sign,
                 output logic [3:0] func,
                 output logic [1:0] reg_ctrl
                 );

    logic [3:0] state, next_state;
    logic [1:0] i_reg, next_i_reg;
    

    always_ff @(posedge clk) begin
        if(~rst_n) begin
            state <= 0;
            i_reg <= 0;
        end else begin
            state <= next_state;
            i_reg <= next_i_reg;

        end

    end

    always_comb begin
        next_state = state;
        next_i_reg = i_reg;
        if (enter) begin
            case (state)
                4'b0000: begin 
                    next_state = 4'b0001;
                    next_i_reg = 2'b01;
                end
                4'b0001: begin 
                    next_state = 4'b0010;
                    next_i_reg = 2'b10;
                end
                4'b0010: next_state = 4'b0011;
                4'b0011: next_state = 4'b0100;
                4'b0100: next_state = 4'b0010;
                4'b1010: next_state = 4'b1011;
                4'b1011: next_state = 4'b1100;
                4'b1100: next_state = 4'b1010;
                default: next_state = 4'b0000;
            endcase
        end else if (sign) begin
            case (state)
                4'b0000: next_state = 4'b0000;
                4'b0001: next_state = 4'b0001;
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
    end

    assign func = state;
    assign reg_ctrl = i_reg;

endmodule
