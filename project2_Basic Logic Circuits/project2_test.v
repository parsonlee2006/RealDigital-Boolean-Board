`timescale 1 ns / 100 ps
// `include "top.v" 



module project2_test;
 reg  [7:0] sw = 8'b10000001;
 wire [2:0] led;

 initial
   begin
    $dumpfile("project2.vcd");
    $dumpvars(0,s);
    #0  sw[0] = 0;
    #10 sw = 8'd10;
    #20 sw = 8'b01001100;
    #50 $finish;

   end
   project2 s(.sw(sw),.led(led));
endmodule  