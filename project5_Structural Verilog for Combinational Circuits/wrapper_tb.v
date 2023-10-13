`timescale 1ns / 100ps
module wrapper_tb;
reg [3:0] sw;
reg  clk = 0;
wire [3:0] led;

wrapper name(
     .sw(sw),
     .clk(clk),
     .led(led)
);

always begin
#2 clk = ~clk;
end
initial begin
    $dumpfile("wrapper.vcd");
    $dumpvars(0,name);
    sw = 4'b0000;
    #10 sw = 4'b1101; 
    
    #10 sw = 4'b0010;
   
    #10 sw = 4'b0100;
   
    #10 sw = 4'b1000;
    #100 $stop;
end

endmodule