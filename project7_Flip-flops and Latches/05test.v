`timescale 1ns / 1ps
module test_tb;
reg [7:0] sw;
reg [1:0]btn;
reg clk;
wire[15:0]led;
PISO_shift_register name(sw,btn,clk,led);

always #1 clk = ~clk;

initial begin
    $dumpfile("05test.vcd");
    $dumpvars;
    clk = 0;
    sw = 8'b01010011;
    #30 btn = 2'b11;
    #20 btn = 2'b00;
    
  
    #100 ;
    $finish;
end
    endmodule


