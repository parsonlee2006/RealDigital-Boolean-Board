`timescale 1ns / 1ps
module clk_div_sr
#( 
   parameter Bit_count = 28
)
(
    input clk,rst,
    output [3:0] led
);
/////////////////////////////////
// 28-bitcounter///////////////////
reg [Bit_count-1:0] count;

always @ (posedge(clk), posedge(rst))
begin
    if (rst) count <= 0;	
    else count <= count + 1;
end
/////////////////////////////////
// 4-bit counter//////////////
reg  [3:0] count_4b;

always @ (posedge(count[Bit_count-1]), posedge(rst))
begin
    if (rst) count_4b <= 0;		
    else count_4b <= count_4b + 1;
end
/////////////////////////
assign led = count_4b;

    

endmodule

