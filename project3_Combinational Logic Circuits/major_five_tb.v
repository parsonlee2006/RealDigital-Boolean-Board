`timescale 1 ns / 100 ps

module major_five_tb;
 reg [4:0] sw;// ABCDE
 wire  Y;
 major_five name(.sw(sw),.led(Y));
initial 
 begin
    $dumpfile("major_five.vcd");
    $dumpvars(0,name);
    #0 sw = 5'd0;
    #2 sw = 5'd1;
    #2 sw = 5'd2;
    #2 sw = 5'd3;
    #2 sw = 5'd4;
    #2 sw = 5'd5;
    #2 sw = 5'd6;
    #2 sw = 5'd7;
    #2 sw = 5'd8;
    #2 sw = 5'd9;
    #2 sw = 5'd10;
    #2 sw = 5'd11;
    #2 sw = 5'd12;
    #2 sw = 5'd13;
    #2 sw = 5'd14;
    #2 sw = 5'd15;
    #2 sw = 5'd16;
    #2 sw = 5'd17;
    #2 sw = 5'd18;
    #2 sw = 5'd19;
    #2 sw = 5'd20;
    #2 sw = 5'd21;
    #2 sw = 5'd22;
    #2 sw = 5'd23;
    #2 sw = 5'd24;
    #2 sw = 5'd25;
    #2 sw = 5'd26;
    #2 sw = 5'd27;
    #2 sw = 5'd28;
    #2 sw = 5'd29;
    #2 sw = 5'd30;
    #2 sw = 5'd31;
    #10 $finish;

 end    


endmodule