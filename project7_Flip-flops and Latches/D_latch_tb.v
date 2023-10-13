`timescale 1ns / 1ps
module d_latch_tb;
    reg D,G;
    wire Q,Qn;
d_latch name(D,G,Q,Qn);

initial begin
    $dumpfile("D_latch.vcd");
    $dumpvars;
   #100 G = 0;
    #100 G = 1;
    #100 G = 0;
    #100 G = 1;
    #100 G = 0;
         D = 0;
    #100 G = 1;
         D = 1;
    #100 D = 0;
         G = 0;
    #100 ;


end
    endmodule

