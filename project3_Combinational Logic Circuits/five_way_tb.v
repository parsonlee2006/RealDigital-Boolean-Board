`timescale 1 ns / 100 ps
module five_way_tb();
reg [4:0]sw;
wire led;
five_way name(.sw(sw),.led(led));
initial 
 begin
    $dumpfile("five_way.vcd");
    $dumpvars(0,name);
    #0 sw = 5'b00000;
    #2 sw = 5'b10000;
    #2 sw = 5'b10100;
    #2 sw = 5'b00100;
    #2 sw = 5'b01100;
    #2 sw = 5'b01101;
    #2 sw = 5'b00101;
    #2 sw = 5'b11001;
    #10 $finish;

 end    
endmodule