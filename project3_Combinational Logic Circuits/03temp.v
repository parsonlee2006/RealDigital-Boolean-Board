module temp(input [7:0] sw, output  led); //ABCDE

// reg led
// always @(sw)
// begin
//  if (sw >= 8'd161 && sw <= 8'd185)
//     led = 1;
//  else
//     led = 0;   
// end
assign led = (sw[7] & ~sw[6] & sw[5] & ~sw[4])&(sw[3]|sw[2]|sw[1]|sw[0])|
             (sw[7] & ~sw[6] & sw[5] & sw[4])&(~sw[3]| (sw[3]&~sw[2]&~sw[1]));

endmodule