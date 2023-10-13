module PISO_shift_register(
input [7:0] sw,
input [1:0]btn,
input clk,
output reg[15:0]led
);
////////clk_div///////////
reg [25:0] cnt = 0;
reg clk_div =1 ;
parameter CLK_DIVDER = 5;
always @(posedge clk)begin
    if (cnt==CLK_DIVDER-1) cnt <=0;
    else cnt <= cnt+1;
end
always @(posedge clk)begin
   if(cnt==CLK_DIVDER-1) clk_div <= ~clk_div;
   else  clk_div <= clk_div;
end
/////////////////////////
////////PISO//////////
reg[7:0] Q;
always @(posedge clk_div)begin
    if(btn[0]) led[7:0]<=sw;
    else led <= {led[14:0],1'b0};
end

always @(posedge clk_div)begin
    if(btn[1]) led[15:8]<= sw;
    else led <= {led[14:0],1'b0};
end


endmodule