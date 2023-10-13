module stop_watch
#(parameter CLK_DIVIDER = 100000)
(
    input rst, clk,
    input [2:0] btn,
    output reg [7:0]D1_SEG,
    output reg [3:0]D1_AN
);

//////////clk_divider//////////////////////////////////// 100 MHZ --> 1 kHZ
reg clk_div;
reg [$clog2(CLK_DIVIDER):0] cnt;

always@(posedge clk, posedge rst) begin
    if (rst) cnt <= 0;
    else if (cnt == CLK_DIVIDER-1) cnt <= 0;		
    else cnt <= cnt + 1;
end

always@(posedge clk, posedge rst) begin
    if (rst) clk_div <= 0;
    else if (cnt == CLK_DIVIDER-1) clk_div <= ~clk_div;		
    else clk_div <= clk_div;
end
//////////state machine/////////////////////////////////////////////////
localparam STOP = 2'b00 ;
localparam START = 2'b01 ;
localparam INCR  = 2'b10 ;
wire Cen;
reg [1:0] cs,ns;

always @(posedge clk_div, posedge rst)begin
    if(rst) cs <= STOP;
    else cs <= ns;
end

always @(*)begin
    case(cs)
    STOP:  ns = (btn[0])? START: (btn[2])? INCR: STOP;
    START: ns = (btn[1])? STOP: START;
    INCR:  ns = STOP;
    default: ns = STOP;
    endcase
end

assign Cen = (cs == START || cs == INCR );

////////// BCD counter//////////////////////////////////////////////////
wire [3:1] TC;
wire [3:0] B[3:0];// to data
BCD_counter BCD0(.clk(clk_div) ,.rst(rst) ,.CEN(Cen) ,.B(B[0]) ,.TC(TC[1]));
BCD_counter BCD1(.clk(clk_div) ,.rst(rst) ,.CEN(Cen & TC[1]) ,.B(B[1]) ,.TC(TC[2]));
BCD_counter BCD2(.clk(clk_div) ,.rst(rst) ,.CEN(Cen & TC[1] & TC[2]) ,.B(B[2]) ,.TC(TC[3]));
BCD_counter BCD3(.clk(clk_div) ,.rst(rst) ,.CEN(Cen & TC[1] & TC[2] & TC[3]) ,.B(B[3]) );

////////// 7seg controller & Display ///////////////////////////////////
reg [1:0] Sel;
reg [3:0]data;

always @(posedge clk_div, posedge rst)begin
    if(rst) Sel <= 0;
    else   Sel <= Sel + 1;
end

always @(*)begin
    case(Sel)
    2'b00: begin data = B[0];D1_AN= 4'b1110;end
    2'b01: begin data = B[1];D1_AN= 4'b1101;end
    2'b10: begin data = B[2];D1_AN= 4'b1011;end
    2'b11: begin data = B[3];D1_AN= 4'b0111;end
    endcase
end
always @ (*)
begin
    case(data)
    0: D1_SEG = (Sel == 2'b11)? 8'b0100_0000: 8'b1100_0000 ;	
    1: D1_SEG = (Sel == 2'b11)? 8'b0111_1001: 8'b1111_1001;
    2: D1_SEG = (Sel == 2'b11)? 8'b0010_0100: 8'b1010_0100;
    3: D1_SEG = (Sel == 2'b11)? 8'b0011_0000: 8'b1011_0000;
    4: D1_SEG = (Sel == 2'b11)? 8'b0001_1001: 8'b1001_1001;
    5: D1_SEG = (Sel == 2'b11)? 8'b0001_0010: 8'b1001_0010;
    6: D1_SEG = (Sel == 2'b11)? 8'b0000_0010: 8'b1000_0010;
    7: D1_SEG = (Sel == 2'b11)? 8'b0111_1000: 8'b1111_1000;
    8: D1_SEG = (Sel == 2'b11)? 8'b0000_0000: 8'b1000_0000;
    9: D1_SEG = (Sel == 2'b11)? 8'b0001_0000: 8'b1001_0000;
    default: D1_SEG = 8'b1100_0000;	
    endcase
end

endmodule

module BCD_counter(
    input clk,rst,CEN,
    output [3:0] B,
    output TC
);
reg [3:0]count;
always @(posedge clk,posedge rst)begin
    if(rst) count <=0;
    else if (!CEN) count <= count;
    else if(TC) count <=0;
    else count <= count+1;
end

assign TC = (count == 4'd9);
assign B = count;

endmodule