module mux(
    input [3:0] I,
    input [1:0] S,
    output  Y
);
reg temp;
always @(I,S ) begin
    case (S)
     2'b00 : temp <= I[0];
     2'b01 : temp <= I[1];
     2'b10 : temp <= I[2];
     2'b11 : temp <= I[3];
     default: temp <= 1'b0;
    endcase
    
end
assign Y = temp;
endmodule