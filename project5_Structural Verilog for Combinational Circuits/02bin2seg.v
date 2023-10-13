module bin2seg(
    input [3:0] sw,
    output reg [6:0] seg7
);
always @(*) begin
 case (sw)
   4'h0  :  seg7 <= 7'b1111_110;
   4'h1  :  seg7 <= 7'b0110_000;
   4'h2  :  seg7 <= 7'b1101_101;
   4'h3  :  seg7 <= 7'b1111_001;
   4'h4  :  seg7 <= 7'b0110_011;
   4'h5  :  seg7 <= 7'b1011_011;
   4'h6  :  seg7 <= 7'b1011_111;
   4'h7  :  seg7 <= 7'b1110_000;
   4'h8  :  seg7 <= 7'b1111_111;
   4'h9  :  seg7 <= 7'b1111_011;
   4'hA  :  seg7 <= 7'b1110_111;
   4'hB  :  seg7 <= 7'b0011_111;
   4'hC  :  seg7 <= 7'b1001_110;
   4'hD  :  seg7 <= 7'b0111_101;
   4'hE  :  seg7 <= 7'b1001_111;
   4'hF  :  seg7 <= 7'b1000_111;
   default :  seg7 <= 7'b0000_000;
 endcase
end


endmodule