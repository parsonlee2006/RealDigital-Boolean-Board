`timescale 1ns / 1ps
module BCD_cnt

#(parameter DIVIDER1=  100000,
  parameter DIVIDER2=  1000)
(
   input clk,rst,
    output reg [6:0] D0_SEG,
    output [3:0]D0_AN
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
reg clk_div;
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
    if (rst) clk_div <= 0;
    else if (tc2) clk_div = ~clk_div;	
end
/////////////////////output 1Hz clk;/////
//////////////////////////  
// comparator
localparam numofbcd = 9;
reg [3:0] count3;
wire bcd;
assign bcd = (count3==numofbcd);
//bcd counter//////////////////////
always @ (posedge clk_div,posedge rst)
begin
    if (rst) count3 <= 0;
    else if (bcd) count3 <= 0;		
    else count3 <= count3 + 1;
end
always @ (*)
begin
    case(count3)
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
//////////////////////
assign D0_AN = 4'b1110;
endmodule


