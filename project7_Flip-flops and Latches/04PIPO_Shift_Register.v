module PIPO_shift_register(
input [7:0] sw,
input [1:0]btn,
input clk,
output reg[7:0]led
);
reg[7:0] Q;
always @(posedge clk)begin
    if(btn[0]) Q<=sw;
    else Q <= sw;
end
always @(*)begin
    case(btn[0])
    1'b0: led =sw;
    1'b1: led =Q;
    endcase
end



endmodule