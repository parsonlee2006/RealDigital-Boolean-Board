`timescale 1ns / 1ps
module CombCirc_tb;
   reg A,B,C;
   wire X,Q;
integer k=0;
CombCirc name(A,B,C,X,Q);
initial begin
    A = 0;
    B = 0;
    C = 0;

    $dumpfile("01CombCirc.vcd");
    $dumpvars;
    for(k = 0; k < 10; k=k+1)
    begin
        {A,C} = k;
        #5 B = 1;
        #5 B = 0;
        #5 ;
    end
end

endmodule