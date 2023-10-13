module counter (
	input clk,
	output  Y1, Y0
);

reg [1:0] counter = 2'b00;

always @ (posedge clk)
begin
	counter <= counter + 1;
end


assign Y1 = counter[1];
assign Y0 = counter[0];


endmodule