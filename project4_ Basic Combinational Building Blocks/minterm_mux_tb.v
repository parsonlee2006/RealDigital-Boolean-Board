`timescale 1ns / 1ps
module minterm_mux_tb;
reg [3:0] sw;
wire led;

minterm_mux name(
    .sw(sw),
    .led(led)
);
integer k;
initial begin
    $dumpfile("minterm_mux.vcd");
    $dumpvars(0,name);
    for(k=0; k < 16; k=k+1) begin
        sw = k;
        #10; // wait 10ns
    end
end
endmodule