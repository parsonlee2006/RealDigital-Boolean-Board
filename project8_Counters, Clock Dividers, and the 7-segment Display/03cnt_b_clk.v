`timescale 1ns / 1ps
module cnt_b_clk
#(parameter DIVIDER1=  100000,
  parameter DIVIDER2=  1000)
(
    input clk,rst,
    output  [15:0] led
);
/// First-divider//////////////////////
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


// Second divider////////////////
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
/////////////////////////
assign led[0] = clk_div;
endmodule
