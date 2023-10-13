module mux2_1(
    input [7:0] sw,
    input sel,
    output reg [3:0] data
);

always @(sw,sel)begin
    case (sel)
     1'b0 : data <= sw[7:4];
     1'b1 : data <= sw[3:0];
     default : data <= 4'b0000;
    endcase
end

endmodule