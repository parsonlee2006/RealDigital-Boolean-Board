`timescale 1ns/ 1ps 
module clk_div_tb;
   reg clk,arst;
   wire [6:0]led1,led2,led3,led4;

bcd_4b_cnt name(clk,arst,led1,led2,led3,led4);

always #1 clk = ~clk;
initial begin
    $dumpfile("05.vcd");
    $dumpvars;
    clk = 0;
    #7 arst = 1;
    #5 arst = 0;
    #500;
    #500 ; 
    #500 ;
    #500 
    $finish;
end

endmodule