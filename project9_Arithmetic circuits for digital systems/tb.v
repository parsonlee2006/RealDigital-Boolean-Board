`timescale 1ns/1ps
module tb;
reg clk,rst,op;
reg [7:0]A,B;
reg [3:1] data;
wire[7:0] result;
add_sub c1(clk,rst,{B,A},data,result);

//always #5clk=~clk;
initial 
    begin
        $dumpfile("02.vcd");
        $dumpvars;
        clk=0;
        rst =0;
        A = 0;
        #3 rst=1;
        #10 rst=0;
        data = 0010;
        #10 A = 3; B = 4;data = 3'b000; 
        #10 A = 6; B = 7;data = 3'b111; 
        #10 A = 5; B = 8;data = 3'b110; 
        #10 A = 2; B = 6;data = 3'b111; 
        #10 A = 0; B = 10;data = 3'b110; 
        #10 A = 9; B = 3;data = 3'b111; 

      
        //#20 $stop;
end
endmodule