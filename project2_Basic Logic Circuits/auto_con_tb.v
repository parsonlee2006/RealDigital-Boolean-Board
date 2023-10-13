`timescale 1 ns / 100 ps

module auto_con_tb;
 reg [3:0] sensor;
 wire [2:0] RGB;
 auto_con name(.ct(sensor[0]),
          .cl(sensor[1]),
          .ot(sensor[2]),
          .ol(sensor[3]));
initial 
 begin
    $dumpfile("auto_con.vcd");
    $dumpvars(0,name);
    #0  sensor = 4'd0;
    #2 sensor = 4'd1;
    #2 sensor = 4'd2;
    #2 sensor = 4'd3;
    #2 sensor = 4'd4;
    #2 sensor = 4'd5;
    #2 sensor = 4'd6;
    #2 sensor = 4'd7;
    #2 sensor = 4'd8;
    #2 sensor = 4'd9;
    #2 sensor = 4'd10;
    #2 sensor = 4'd11;
    #2 sensor = 4'd12;
    #2 sensor = 4'd13;

    #10 $finish;

 end    


endmodule