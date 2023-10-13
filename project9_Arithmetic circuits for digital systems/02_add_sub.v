module add_sub
#(parameter DIVIDER=  100000)
(
    input clk,rst,
    input [15:0] sw, 
    input [2:0]btn,
    output reg [3:0] led,
    output [2:0]RGB0,
    output reg[6:0] D1_SEG, 
    output reg [3:0] D1_AN
    );

///////////8 bit operater part/////////////////
reg [7:0] op1, op2;

always @ (posedge(clk)) begin
if (rst) begin  op1<= 0; 
                op2<= 0;
         end
else     begin
    if (btn[0]) op1 <= sw;
    if (btn[1]) op2 <= sw;
         end
end
//////////////add/ subtractor////////////////////
reg [7:0] bin_data;
wire op2_2;
assign op2_2 = (op2^{8{btn[2]}} );
always @(*)begin
     bin_data = op1 + op2_2 + btn[2];
end
///////////overflow underflow detect//////////////////////
wire [7:0]G,P;
wire [1:0]Cout;
wire Cin;
assign P = op1 | op2_2;
assign G = op1 & op2_2;
assign Cin = btn[2];

assign Cout[0] = G[6]|(P[6]&G[5])|(P[6]&P[5]&G[4])|(P[6]&P[5]&P[4]&G[3])|(P[6]&P[5]&P[4]&P[3]&G[2])|
                     (P[6]&P[5]&P[4]&P[3]&P[2]&G[1])| (P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&G[0])| 
                     (P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&Cin);

assign Cout[1]   = G[7]|(P[7]&G[6])|(P[7]&P[6]&G[5])|(P[7]&P[6]&P[5]&G[4])|(P[7]&P[6]&P[5]&P[4]&G[3])|
                     (P[7]&P[6]&P[5]&P[4]&P[3]&G[2])| (P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&G[1])| 
                     (P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&G[0])|(P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&Cin);

assign RGB0[0] = Cout[0] ^ Cout[1] ; //when overflow or underflow, red light turn on.
///////////////negetive result show up/////////////////
reg [7:0]result ;
always @(*)begin
   if(!bin_data[7])begin result = bin_data;         led[0] = 1'b1 ;end
   else            begin result = ~bin_data + 1'b1; led[0] = 1'b0 ;end
end
/////////////// bin_data to BCD/////////////////
reg [11:0]bcd;
integer i;
always @(*)begin
  bcd=0;		 	
    for (i=0;i<8;i=i+1) begin					//Iterate once for each bit in input number
        if (bcd[3:0] >= 5)  bcd[3:0]  = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
	    if (bcd[7:4] >= 5)  bcd[7:4]  = bcd[7:4] + 3;
	    if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	    bcd = {bcd[10:0],result[7-i]};				//Shift one bit, and shift in proper bit from input 
    end
end

//////////////////////////////////////////////////
////////////////// 7-seg display/////////////////
////////////2-bit counter///////////////
reg [$clog2(DIVIDER):0]cnt;
always @(posedge clk, posedge rst)begin
    if(rst)cnt <= 0;
    else cnt = cnt + 1;
end
////////////2-bit counter///////////////
wire [1:0] S;
reg [3:0]data;
assign S = cnt[$clog2(DIVIDER):$clog2(DIVIDER)-1];
always @(*)begin
    case(S)
    2'b00: begin data = bcd[3:0];  D1_AN= 4'b1110;end
    2'b01: begin data = bcd[7:4];  D1_AN= 4'b1101;end
    2'b10: begin data = bcd[11:8]; D1_AN= 4'b1011;end
    2'b11: begin data = 4'd0;      D1_AN= 4'b0111;end
    endcase
end
always @ (*)
begin
    case(data)
    0: D1_SEG = 7'b100_0000;	
    1: D1_SEG = 7'b111_1001;
    2: D1_SEG = 7'b010_0100;
    3: D1_SEG = 7'b011_0000;
    4: D1_SEG = 7'b001_1001;
    5: D1_SEG = 7'b001_0010;
    6: D1_SEG = 7'b000_0010;
    7: D1_SEG = 7'b111_1000;
    8: D1_SEG = 7'b000_0000;
    9: D1_SEG = 7'b001_0000;
    default: D1_SEG = 7'b100_0000;	
    endcase
end
endmodule
