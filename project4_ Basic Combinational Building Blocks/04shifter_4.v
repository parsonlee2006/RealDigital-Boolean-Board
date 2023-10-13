module shifter (
    input [7:0] sw,
    input [3:0] btn,
    output reg [7:0] led
);

always @ (*)
begin
    case(btn)
    // shift left
    4'd0: led = sw;
    4'd1: led = {sw[6:0],1'd0};
    4'd2: led = {sw[5:0],2'd0};
    4'd3: led = {sw[4:0],3'd0};
    // shift right
    4'd4: led = sw;
    4'd5: led = {1'd0,sw[7:1]};
    4'd6: led = {2'd0,sw[7:2]};
    4'd7: led = {3'd0,sw[7:3]};
    // rotate left
    4'd8: led = sw;
    4'd9: led =  {sw[6:0],sw[7]};
    4'd10: led = {sw[5:0],sw[7:6]};
    4'd11: led = {sw[4:0],sw[7:5]};
    //rotate right
    4'd12: led = sw;
    4'd13: led = {sw[0],sw[7:1]};
    4'd14: led = {sw[1:0],sw[7:2]};
    4'd15: led = {sw[2:0],sw[7:3]};
    default: led = sw;
    endcase
end
endmodule