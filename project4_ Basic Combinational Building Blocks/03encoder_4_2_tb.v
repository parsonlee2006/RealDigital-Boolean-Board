`timescale 1ns / 1ps
module encoder_4_2_tb;

reg [3:0] I;
reg Ein;
wire  [1:0] Y;
wire GS,Eout;

encoder_4_2 name(I,Ein,Y,GS,Eout);

integer k;
initial begin
    $dumpfile("encoder_4_2.vcd");
    $dumpvars(0,name);
    Ein = 0; I = 0000;
    #5 I = 0010;
    #5 Ein =1;
    for(k=0; k < 16; k=k+1) begin
        I = k;
        #5; // wait 10ns
    end
end
endmodule