module comparator
#(parameter DIVIDER=  100000)
(
    input clk,rst,
    input [7:0] sw, 
    input [2:0]btn,
    output [2:0]RGB0
    );
///////////8 bit operater part/////////////////
reg [7:0] op1, op2;

always @ (posedge(clk)) begin
if (rst) begin op1<= 0; op2<= 0;end
else begin
    if (btn[0]) op1 <= sw;
    if (btn[1]) op2 <= sw;
end
end
//////////mutiplier //////////////
wire [15:0] bin_data;
assign bin_data = op1*op2;//16 bit result

/////////registor 16 bit initial data////////
reg [15:0] initial_bin_data;
always@(posedge clk)begin
    if(rst) initial_bin_data <= 0;
    else if (btn[0]) initial_bin_data <= bin_data; ///push btn[0] to load the result;
    else initial_bin_data <= initial_bin_data;
end
/////////comparator//////////////
////compare initial_bin_data and bin_data;

assign RGB0[0] = ( initial_bin_data > bin_data )? 1'b1:1'b0 ; // red :  GT
assign RGB0[1] = ( initial_bin_data == bin_data)? 1'b1:1'b0 ; // green: EQ
assign RGB0[2] = ( initial_bin_data < bin_data )? 1'b1:1'b0 ; // blue:  LT

endmodule