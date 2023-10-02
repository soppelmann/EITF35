module binary_to_bcd (
                      input [7:0]  binary_in,
                      output wire [9:0] bcd_out
                      );

   //Internal variables
   reg [11:0] reg_bcd_out;
   reg [3:0]  i;

   //Implement the Double Dabble algorithm
   always @(binary_in)
     begin
        reg_bcd_out = 0; //initialize reg_bcd_out to zero.
        for (i = 0; i < 8; i = i+1) //run for 8 iterations
          begin
             reg_bcd_out = {reg_bcd_out[10:0],binary_in[7-i]}; //concatenation

             //if a hex digit of 'reg_bcd_out' is more than 4, add 3 to it.
             if(i < 7 && reg_bcd_out[3:0] > 4)
               reg_bcd_out[3:0] = reg_bcd_out[3:0] + 3;
             if(i < 7 && reg_bcd_out[7:4] > 4)
               reg_bcd_out[7:4] = reg_bcd_out[7:4] + 3;
             if(i < 7 && reg_bcd_out[11:8] > 4)
               reg_bcd_out[11:8] = reg_bcd_out[11:8] + 3;
          end
     end


   //to obtain max 255 we can remove 2 bits :)
   assign bcd_out = reg_bcd_out[9:0];


endmodule
