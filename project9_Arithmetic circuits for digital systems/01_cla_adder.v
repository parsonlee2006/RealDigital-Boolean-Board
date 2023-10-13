module CLA_4b_adder
#(parameter DIVIDER=  100000)
(
    input clk,rst,
    input [7:0]sw,
  //  output [4:0]data
    output reg[7:0]D0_SEG,
    output reg[3:0]D0_AN
    );


///////////4 bit adder part/////////////////
wire [3:0]Sum;
full_adder f1 (.A(sw[0]),.B(sw[4]),.Cin(Cin[0]),.Sum(Sum[0]),.P(P[0]),.G(G[0]));
full_adder f2 (.A(sw[1]),.B(sw[5]),.Cin(Cin[1]),.Sum(Sum[1]),.P(P[1]),.G(G[1]));
full_adder f3 (.A(sw[2]),.B(sw[6]),.Cin(Cin[2]),.Sum(Sum[2]),.P(P[2]),.G(G[2]));
full_adder f4 (.A(sw[3]),.B(sw[7]),.Cin(Cin[3]),.Sum(Sum[3]),.P(P[3]),.G(G[3]));
//////////////////////////////////
//////////carry look-ahead circuits///////////
wire [3:0]G,P,Cin;
wire Cout;
assign Cin[0] = 1'b0;
assign Cin[1] = G[0]|(P[0]&Cin[0]);
assign Cin[2] = G[1]|(P[1]&G[0])|(P[1]&P[0]&Cin[0]);
assign Cin[3] = G[2]|(P[2]&G[1])|(P[2]&P[1]&G[0])|(P[2]&P[1]&P[0]&Cin[0]);
assign Cout   = G[3]|(P[3]&G[2])|(P[3]&P[2]&G[1])|(P[3]&P[2]&P[1]&G[0])|(P[3]&P[2]&P[1]&P[0]&Cin[0]);
//////////////Display Data///////////////////////////
///////////////7_segment diaplay////////////////////
reg [$clog2(DIVIDER):0]cnt;
always @(posedge clk, posedge rst)begin
    if(rst)cnt<=0;
    else cnt = cnt+1;
end
////////////////////////////////////////
wire Sel;
reg [3:0]data;
assign Sel = cnt[$clog2(DIVIDER)];
always @(*)begin
    case(Sel)
    1'b0: begin data = Sum;D0_AN= 4'b1110;end
    1'b1: begin data = {3'd0,Cout};D0_AN= 4'b1101;end
    endcase
end
//////////7_segment diaplay////////////////
always @ (*)
begin
    case(data)
    0: D0_SEG = 7'b100_0000;	
    1: D0_SEG = 7'b111_1001;
    2: D0_SEG = 7'b010_0100;
    3: D0_SEG = 7'b011_0000;
    4: D0_SEG = 7'b001_1001;
    5: D0_SEG = 7'b001_0010;
    6: D0_SEG = 7'b000_0010;
    7: D0_SEG = 7'b111_1000;
    8: D0_SEG = 7'b000_0000;
    9: D0_SEG = 7'b001_0000;
    ////////////////////////
    10: D0_SEG = 7'b000_1000;
    11: D0_SEG = 7'b000_0011;
    12: D0_SEG = 7'b100_0110;
    13: D0_SEG = 7'b010_0001;
    14: D0_SEG = 7'b000_0110;
    15: D0_SEG = 7'b000_1110;
    default: D0_SEG = 7'b100_0000;	
    endcase
end

endmodule
module full_adder(
    input A,B,Cin,
    output Sum, Cout,P,G
);
assign Sum = (A^B)^Cin;
assign Cout = ((A^B)&Cin)|A&B;
assign P = A|B;
assign G = A&B;
endmodule

