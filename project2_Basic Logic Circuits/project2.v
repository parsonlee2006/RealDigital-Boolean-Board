module project2(
    input [7:0] sw,
    output [2:0] led
);

assign led[0] = (sw[1] & ~sw[0])|//10
                (~sw[1] & sw[0]);//01

assign led[1] = (~sw[3] & ~sw[2] & ~sw[1])|//000
                (~sw[3] &  sw[2] &  sw[1])|//011
                ( sw[3] & ~sw[2] &  sw[1]);//101


assign led[2] = (~sw[7] & ~sw[6] & ~sw[5] &  sw[4])|//0001
                (~sw[7] & ~sw[6] &  sw[5] &  sw[4])|//0011
                (~sw[7] &  sw[6] & ~sw[5] & ~sw[4])|//0100
                ( sw[7] &  sw[6] &  sw[5] &  sw[4]);//1111
                

endmodule