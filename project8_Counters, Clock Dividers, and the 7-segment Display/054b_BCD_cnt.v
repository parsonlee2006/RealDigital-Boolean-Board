`timescale 1ns / 1ps
module bcd_4b_cnt
#(parameter DIVIDER1=  100000,
  parameter DIVIDER2=  100)
(
   input clk,rst,
    input [7:0] sw,//enable
    output reg[6:0] D0_SEG, 
    output reg [3:0] D0_AN
);
/// First-divider//////////////////////
/// First-divider////////////////////// 100MHZ-1kHz
reg [$clog2(DIVIDER1):0] count;
wire tc1;
reg clk_div_1;
// comparator
assign tc1 = (count ==  DIVIDER1-1);	

always @ (posedge clk,posedge rst)
begin
    if (rst) count <= 0;
    else if (tc1) count <= 0;		
    else count <= count + 1;
end
// clk_div_28
always @ (posedge clk,posedge rst)
begin
    if (rst) clk_div_1 <= 0;
    else if (tc1) clk_div_1 = ~clk_div_1;	
end
/////////////////////////////////


// Second divider//////////////// 1kHZ-1Hz
wire tc2;
reg clk_div2;
reg [$clog2(DIVIDER2):0] count2;

assign tc2 = (count2 ==  DIVIDER2-1);

always @ (posedge (clk_div_1),posedge rst)
begin
    if (rst) count2 <= 0;
    else if (tc2) count2 <= 0;		
    else count2 <= count2 + 1;
end
always @ (posedge (clk_div_1),posedge rst)
begin
    if (rst) clk_div2 <= 0;
    else if (tc2) clk_div2 = ~clk_div2;	
end
/////////////////////output 1Hz clk;/////
////////////////////////// trash:/project8_Counters, Clock Dividers, and the 7-segment Display
/////////////////DATA Source////////////////////////////1kHz
wire [3:1] TC;
wire [3:0] B[3:0];
BCD_1b BCD0(.clk(clk_div2) ,.rst(rst) ,.CEN(sw[0]) ,.B(B[0]) ,.TC(TC[1]));
BCD_1b BCD1(.clk(clk_div2) ,.rst(rst) ,.CEN(sw[0]&TC[1]) ,.B(B[1]) ,.TC(TC[2]));
BCD_1b BCD2(.clk(clk_div2) ,.rst(rst) ,.CEN(sw[0]&TC[1]&TC[2]) ,.B(B[2]) ,.TC(TC[3]));
BCD_1b BCD3(.clk(clk_div2) ,.rst(rst) ,.CEN(sw[0]&TC[1]&TC[2]&TC[3]) ,.B(B[3]) );
/////////////////////////////////////////////////////
/////////////////Display System////////////////////////////
////////////2-bit counter///////////////
reg [1:0]cnt;
always @(posedge clk_div_1, posedge rst)begin
    if(rst)cnt<=0;
    else cnt = cnt+1;
end
////////////2-bit counter///////////////
wire [1:0] S;
reg [3:0]data;
assign S = cnt;
always @(*)begin
    case(S)
    2'b00: begin data = B[0];D0_AN= 4'b1110;end
    2'b01: begin data = B[1];D0_AN= 4'b1101;end
    2'b10: begin data = B[2];D0_AN= 4'b1011;end
    2'b11: begin data = B[3];D0_AN= 4'b0111;end
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

endmodule


module BCD_1b(
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
