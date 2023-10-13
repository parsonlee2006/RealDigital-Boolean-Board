module mux_4_1(
   input [3:0] data,
   input [1:0] sel,
   output [3:0]led
);
reg tmp;
always @(data,sel) begin
    case(sel)
    2'b00: tmp <= data[0];
    2'b01: tmp <= data[1];
    2'b10: tmp <= data[2];
    2'b11: tmp <= data[3];
    default: tmp <= 1'b0;
    endcase    
end
assign led[0] = tmp;
endmodule