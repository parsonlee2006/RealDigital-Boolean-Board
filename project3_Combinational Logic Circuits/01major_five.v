module major_five(input [7:0] sw, output [2:0]led);

assign led[0] =	(sw[0] & sw[1] & sw[2]) | //ABC
		        (sw[0] & sw[1] & sw[3]) | //ABD
                (sw[0] & sw[1] & sw[4]) | //ABE
                (sw[0] & sw[2] & sw[3]) | //ACD
                (sw[0] & sw[2] & sw[4]) | //ACE
                (sw[0] & sw[3] & sw[4]) | //ADE
                (sw[1] & sw[2] & sw[3]) | //BCD
                (sw[1] & sw[2] & sw[4]) | //BCE
                (sw[1] & sw[3] & sw[4]) | //BDE
                (sw[2] & sw[3] & sw[4]);  //CDE
//02
// assign led[1] = sw[0]&{(sw[4]^sw[3])&(sw[2]^sw[1])|(~(sw[4]^sw[3])& ~(sw[2]^sw[1]))}|
//             ~sw[0]&~{(sw[4]^sw[3])&(sw[2]^sw[1])|(~(sw[4]^sw[3])& ~(sw[2]^sw[1]))} ;

//03     
// assign led[2] = (sw[7] & ~sw[6] & sw[5] & ~sw[4])&(sw[3]|sw[2]|sw[1]|sw[0])|
//              (sw[7] & ~sw[6] & sw[5] & sw[4])&(~sw[3]| (sw[3]&~sw[2]&~sw[1]));
endmodule