module decode_2_4(
    input [1:0] sw,
    input [3:0] btn,
    output [3:0] led
);
reg [3:0] Y ;
always @(*) begin
    case(sw)
     2'd0: Y <= 4'd1;
     2'd1: Y <= 4'd2;
     2'd2: Y <= 4'd4;
     2'd3: Y <= 4'd8;
     default: Y <= 8'd0;
    endcase    
end
assign led = {Y[3]&btn[3],Y[2]&btn[2],Y[1]&btn[1],Y[0]&btn[0]};

endmodule