module SIPO_shift_register(
input [1:0]sw,
input [3:0] btn,
input clk,
output reg[7:0]led
);
////////clk_div///////////
// reg [25:0] cnt = 0;
// reg clk_div =1 ;
// parameter CLK_DIVDER = 5;
// always @(posedge clk)begin
//     if (cnt==CLK_DIVDER-1) cnt <=0;
//     else cnt <= cnt+1;
// end
// always @(posedge clk)begin
//    if(cnt==CLK_DIVDER-1) clk_div <= ~clk_div;
//    else  clk_div <= clk_div;
// end
/////////////////////////
reg[7:0] Q;
always @(posedge clk)begin
    if(!btn[0]) led<=led;
    else led[7:0] <= {led[6:0],sw[0]};
end

endmodule