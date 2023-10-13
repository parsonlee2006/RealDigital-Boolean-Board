module mux_demux(
    input clk,
    input [7:0] sw,
    output reg[7:0] led
);
///////////mux/////////
reg En;

always @(*)begin
    case(Y)
    3'd0: En = sw[0];
    3'd1: En = sw[1];
    3'd2: En = sw[2];
    3'd3: En = sw[3];
    3'd4: En = sw[4];
    3'd5: En = sw[5];
    3'd6: En = sw[6];
    3'd7: En = sw[7];
    default: En = 1'bx;
    endcase
end
/////////demux/////////
always @(*)begin
    if (!En) led = 8'b0000_0000;
    else
    case(Y)
    3'd0: led = 8'b0000_0001;
    3'd1: led = 8'b0000_0010;
    3'd2: led = 8'b0000_0100;
    3'd3: led = 8'b0000_1000;
    3'd4: led = 8'b0001_0000;
    3'd5: led = 8'b0010_0000;
    3'd6: led = 8'b0100_0000;
    3'd7: led = 8'b1000_0000;
    default: led = 8'b0000_0000;
    endcase
end
/////////counter/////////////
wire [2:0] Y;
reg [27:0] counter;
always @ (posedge clk)
begin
	counter <= counter + 1;
end
assign Y[2] = counter[27];
assign Y[1] = counter[26];
assign Y[0]= counter[25];
////////////////////////
endmodule