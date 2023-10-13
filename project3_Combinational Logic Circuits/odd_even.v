module odd_even(input [7:0]sw, output [1:0]led); //odd even
  
assign led[0] = ((sw[7]^sw[6])^(sw[5]^sw[4]))^((sw[3]^sw[2])^(sw[1]^sw[0]));
assign led[1] = ~(((sw[7]^sw[6])^(sw[5]^sw[4]))^((sw[3]^sw[2])^(sw[1]^sw[0])));

endmodule