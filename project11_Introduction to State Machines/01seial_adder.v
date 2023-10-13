module serial_adder
#(parameter DIVIDER = 100000)
(  input clk,rst,
   input A,B,
   output  F,Cout
   
);
parameter S0 = 2'b00, S1= 2'b01, S2= 2'b10, S3= 2'b11;
reg [1:0] cs,ns;

always @(posedge clk) begin
    if(rst) cs <= S0;
    else    cs <= ns;  
end
always@(*)begin
    case(cs)
    S0: ns = (A^B) ? S1 : (A&B)? S2 : S0;
    S1: ns = (A^B) ? S1 : (A&B)? S2 : S0;
    S2: ns = (A^B) ? S2 : (A&B)? S3 : S1;
    S3: ns = (A^B) ? S2 : (A&B)? S3 : S1; 
    default : ns = S0;
    endcase
end

assign F = (cs == S1 || cs == S3) ? 1'b1 : 1'b0;
assign Cout = (cs == S2 || cs == S3) ? 1'b1 : 1'b0;

endmodule