`timescale 1ps/1ps
module odd_even_tb();
reg [7:0]sw;
wire [1:0]led;
odd_even name(.sw(sw),.led(led));
initial 
 begin
    $dumpfile("odd_even.vcd");
    $dumpvars(0,name);
    #0 sw = 8'b00000000;
    #2 sw = 8'b01100000;
    #2 sw = 8'b00011100;
    #2 sw = 8'b01010101;
    #2 sw = 8'b01011110;
    #2 sw = 8'b01111011;
    #2 sw = 8'b10111111;
    #2 sw = 8'b11111111;
    #10 $finish;

 end    
endmodule