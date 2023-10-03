module ALU (
            input [7:0]  A,
            input [7:0]  B,
            input [3:0]  FN,
            output [7:0] result,
            output       overflow,
            output       sign
            );


   reg [7:0] ALU_Result;
   wire [8:0] tmp;
   reg        pn;

// mod 3 missing
   always @(*)
     begin
        case(FN)
          4'b0000: // A
            ALU_Result = A;
          4'b0001: // B
            ALU_Result = B;
          4'b0010: // Unsigned A + B
            ALU_Result = A + B;
          4'b0011: // Unsigned A - B
            ALU_Result = A - B;
          4'b0100: // Unsigned A mod 3
            ALU_Result = A << 1;
          // maybe the sign output is just to say if positive or negative for the signed case
          4'b1010: // Signed A + B
            ALU_Result = $signed(A) + $signed(B);
          4'b1011: // Signed A - B
            ALU_Result = $signed(A) - $signed(B);
          4'b1100: // Signed A mod 3
            ALU_Result = A << 1;
          default: ALU_Result = A + B ;
        endcase // case (FN)

        // $signed might not be needed
        if (FN == 4'b1010 || FN == 4'b1011 || FN == 4'b1100 && $signed(ALU_Result) < 0) begin
           pn <= 1;
        end else begin
           pn <= 0;
        end
     end

   assign result = ALU_Result;
   assign tmp = {1'b0,A} + {1'b0,B};
   assign overflow = tmp[8]; // Carryout flag
   assign sign = pn;




endmodule
