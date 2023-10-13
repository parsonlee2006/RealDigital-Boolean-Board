// simulation file
`timescale 1ns / 1ps
module mux_4_1_tb;
// inputs
reg [3:0] data;
reg [1:0] sel;
// outputs
wire Y;
// connect test signals to our mux
mux_4_1 name(
    .data(data),
    .sel(sel),
    .Y(Y)
);
integer k;
initial begin
    $dumpfile("mux_4_1.vcd");
    $dumpvars(0,name);
    sel = 2'b00;
    for(k=0; k < 16; k=k+1) begin
        data = k;
        #10; // wait 10ns
    end
    
    sel = 2'b01;
    for(k=0; k < 16; k=k+1) begin
        data = k;
        #10;
    end
    
    sel = 2'b10;
    for(k=0; k < 16; k=k+1) begin
        data = k;
        #10;
    end
    
    sel = 2'b11;
    for(k=0; k < 16; k=k+1) begin
        data = k;
        #10;
    end
    
    sel = 2'b1z;
    for(k=0; k < 16; k=k+1) begin
        data = k;
        #10;
    end
    
    sel = 2'b1x;
    for(k=0; k < 16; k=k+1) begin
        data = k;
        #10;
    end
    $finish;
end

endmodule