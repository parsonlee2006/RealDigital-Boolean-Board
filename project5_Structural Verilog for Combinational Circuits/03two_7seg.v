module two_7seg(
    input [7:0] sw,
    input btn,
    output [3:0]D0_AN,
    output [6:0] D0_SEG
);

wire [3:0]data;
mux_2_1 m1(.sw(sw), .sel(btn), .data(data));
bin2seg b1(.sw(data), .seg7(D0_SEG));
bin2seg b2(.sw(data), .seg7(D0_SEG));
assign D0_AN[0] = ~btn;
assign D0_AN[1] = btn;

endmodule

module mux_2_1(
    input [7:0]sw,
    input sel,
    output reg[3:0]data
);
always@(*)begin
    case(sel)
    1'b0: data = sw[3:0];
    1'b1: data = sw[7:4];
    endcase
end

endmodule

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