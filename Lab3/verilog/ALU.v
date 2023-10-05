module ALU (
            input [7:0]  A,
            input [7:0]  B,
            input [3:0]  FN,
            output [7:0] result,
            output       overflow,
            output       sign
            );


   reg [8:0] ALU_Result;
   wire [8:0] tmp;
   reg        pn;
   wire [7:0] A_mod3;
   reg [8:0]  A_sign;

   // Sign comes from cases, now we want to check sign of A, i.e.  bit 7 if signed
   // We can perform this check inside mod3 module by check bit 7 when its a signed operation
   mod3_alg my_mod3 ( .mod_in(A), .sign_in(FN[3]), .mod_out(A_mod3));

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
            ALU_Result = A_mod3;
          // maybe the sign output is just to say if positive or negative for the signed case
          4'b1010: begin
             // Signed A + B
             A_sign = A + B;
             if(A_sign[7] == 1) begin
                ALU_Result = ~(A + B) + 1;
                pn <= 1;
             end else begin
                ALU_Result = A + B;
                pn <= 0;
             end
          end
          4'b1011: begin
             // Signed A - B
             A_sign = A - B;
             if(A_sign[7] == 1) begin
                ALU_Result = ~(A - B) + 1; //we conv to unsigned before bcd and save p/n in pn.
                pn <= 1;
             end else begin
                ALU_Result = A - B;
                pn <= 0;
             end
          end
          4'b1100: begin
             // A mod3
                ALU_Result = A_mod3;
          end
          default: ALU_Result = A + B ;
        endcase // case (FN)

        if (!(FN[3] == 1)) begin
           pn <= 0;
        end else if (FN == 4'b1010) begin
           if((A[7] == 1 && B[7] == 1 && ALU_Result[8] == 0) || (A[7] == 0 && B[7] == 0 && ALU_Result[8] == 1)) begin
              ALU_Result[8] = 1;
           end else begin
              ALU_Result[8] = 0;
           end
        end else if (FN == 4'b1011) begin
           if((A[7] == 1 && B[7] == 0 && ALU_Result[8] == 0) || (A[7] == 0 && B[7] == 1 && ALU_Result[8] == 1)) begin
              ALU_Result[8] = 1;
           end else begin
              ALU_Result[8] = 0;
           end
        end
     end

   assign result = ALU_Result[7:0];
   assign tmp = {1'b0,A} + {1'b0,B};
   assign overflow = ALU_Result[8]; // Carryout flag
   assign sign = pn;

endmodule

//write embedded module here as in sevensegmentdriver

module mod3_alg (
   input wire [7:0] mod_in,
   input wire sign_in,
   output wire [7:0] mod_out
);

reg [7:0] mod3 = 14;
reg [3:0]  i;


   assign mod_out = mod3;


endmodule
