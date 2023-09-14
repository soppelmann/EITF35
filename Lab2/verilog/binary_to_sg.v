module binary_to_sg
  (input  [3:0] binary_in,
   output reg [7:0] sev_seg);


   always @ (binary_in) begin
      case(binary_in)
        4'b0000 : sev_seg = 8'b11000000; //0

        4'b0001 :  sev_seg = 8'b11111001; //1

        4'b0010:  sev_seg = 8'b10100100; //2

        4'b0011:  sev_seg = 8'b10110000; //...

        4'b0100:  sev_seg = 8'b10011001;

        4'b0101:  sev_seg = 8'b10010010;

        4'b0110: sev_seg = 8'b10000010;

        4'b0111: sev_seg = 8'b11111000;

        4'b1000: sev_seg = 8'b10000000;

        4'b1001: sev_seg = 8'b10010000; //9

        4'b1111 : sev_seg = 8'b11111111; //off

        default : sev_seg = 8'b10000110; //error

      endcase // case (sel)
   end // always @ (binary_in)


endmodule
