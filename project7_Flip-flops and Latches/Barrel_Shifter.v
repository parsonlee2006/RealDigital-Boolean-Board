module barrel_shifter(
    input clk,
    input fill,
    input [7:0] sw,
    input [2:0] btn,// 2 1:direction 0:store
    output reg[7:0] led
);
reg [7:0] Q;

always @(posedge clk)begin
    if(btn[0]) begin 
        Q<=sw;
        led<=Q;
    end
    else begin
        case(btn[2:1]) 
        2'b01: led <= led >> {sw};
        2'b00:  led <= led << {sw};
        2'b10:  led <= {Q[7-sw],Q[1-sw]}; 
        2'b11:  led <= {Q[sw],Q[sw]}; 
        endcase
    end
    
    led[0] <= fill;
end

endmodule