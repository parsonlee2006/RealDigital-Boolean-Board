module five_way(input [4:0] sw, output  led); //ABCDE

assign led = sw[0]&{(sw[4]^sw[3])&(sw[2]^sw[1])|(~(sw[4]^sw[3])& ~(sw[2]^sw[1]))}|
            ~sw[0]&~{(sw[4]^sw[3])&(sw[2]^sw[1])|(~(sw[4]^sw[3])& ~(sw[2]^sw[1]))} ;




endmodule