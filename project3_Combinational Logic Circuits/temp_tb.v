`timescale 1 ns / 100 ps
module temp_tb();
reg [7:0]sw;
wire led;
temp name(.sw(sw),.led(led));
initial 
 begin
    $dumpfile("temp.vcd");
    $dumpvars(0,name);
    #0 sw = 8'd0;
    #2 sw = 8'd10;
    #2 sw = 8'd160;
    #2 sw = 8'd161;
    #2 sw = 8'd186;
    #2 sw = 8'd185;
    #2 sw = 8'd200;
    #2 sw = 8'd170;
    #10 $finish;

 end    
endmodule