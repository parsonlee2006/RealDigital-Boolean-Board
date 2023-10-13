`timescale 1ns / 1ps
module sr_latch_tb;
   reg S;
   reg R;
   wire Q;
   wire Qn;

sr_latch name(S,R,Q,Qn);

initial begin
    $dumpfile("SR_latch_NOR.vcd");
    $dumpvars;
    // Initialize Inputs
//     S = 1;
//     R = 1;

//     // Add stimulus here NAND
//     #100 S = 0;
//     #100 S = 1;
//     #100 R = 0;
//     #100 R = 1;
//     #100 S = 0;
//          R = 0;
//     #100 S = 1;
//          R = 1;
//     #100 S = 0;
//          R = 0;
//     #100 ;

    // Add stimulus here NOR
     S = 0;
     R = 0;
    #100 S = 1;
    #100 S = 0;
    #100 R = 1;
    #100 R = 0;
    #100 S = 1;
         R = 1;
    #100 S = 0;
         R = 0;
    #100 S = 1;
         R = 1;
    #100 ;
end
endmodule