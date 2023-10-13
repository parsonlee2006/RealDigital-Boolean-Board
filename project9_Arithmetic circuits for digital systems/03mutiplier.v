module multiplier
#(parameter DIVIDER=  100000)
(
    input rst,clk,
    input [7:0]sw,
    input [2:0]btn,
   output reg[6:0] D0_SEG,D1_SEG ,
   output reg [3:0] D0_AN,D1_AN
);
wire [15:0] bin_data;
assign bin_data = op1*op2;//16 bit result
/////////////////////////////////////////////////
///////////8 bit operater part/////////////////

reg [7:0] op1, op2;

always @ (posedge(clk)) begin
if (rst) begin op1<= 0; op2<= 0;end
else begin
    if (btn[0]) op1 <= sw;
    if (btn[1]) op2 <= sw;
end
end
/////////////// bin to BCD/////////////////
reg [19:0]bcd;
integer i;
always @(*)begin
  bcd=0;		 	
    for (i=0;i<16;i=i+1) begin					//Iterate once for each bit in input number
        if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
	    if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	    if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	    if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;
        if (bcd[19:16] >= 5) bcd[15:12] = bcd[15:12] + 3;
	    bcd = {bcd[18:0],bin_data[15-i]};				//Shift one bit, and shift in proper bit from input 
    end
end
////////////////// 7-seg display/////////////////
////////////2-bit counter///////////////
reg [$clog2(DIVIDER):0]cnt;
always @(posedge clk, posedge rst)begin
    if(rst)cnt<=0;
    else cnt = cnt+1;
end
////////////3-bit counter///////////////
wire [2:0] S;
reg [3:0]data;
assign S = cnt[$clog2(DIVIDER):$clog2(DIVIDER)-2];
always @(*)begin
    case(S)
    0: begin data = bcd[3:0];    D1_AN= 4'b1110; D0_AN= 4'b1111;end
    1: begin data = bcd[7:4];    D1_AN= 4'b1101; D0_AN= 4'b1111;end
    2: begin data = bcd[11:8];   D1_AN= 4'b1011; D0_AN= 4'b1111;end
    3: begin data = bcd[15:12];  D1_AN= 4'b0111; D0_AN= 4'b1111;end
    4: begin data = bcd[19:16];  D1_AN= 4'b1111; D0_AN= 4'b1110;end
    5: begin data = 4'd0;        D1_AN= 4'b1111; D0_AN= 4'b1101;end
    6: begin data = 4'd0;        D1_AN= 4'b1111; D0_AN= 4'b1011;end
    7: begin data = 4'd0;        D1_AN= 4'b1111; D0_AN= 4'b0111;end
    endcase
end
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
    default: D0_SEG = 7'b100_0000;	
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
