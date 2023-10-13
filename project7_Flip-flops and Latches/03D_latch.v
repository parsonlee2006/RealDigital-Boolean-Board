`timescale 1ns / 1ps
module d_latch(
    input D,G,
    output Q,Qn
);
wire Q_int,Qn_int;
wire D_n, S,R;
assign #1 D_n =  ~D;
assign #1 S = (D ~& G) ;
assign #1 R = (D_n ~& G) ;

assign #1 Q_int = ~(S & Qn_int) ;
assign #1 Qn_int = ~(R & Q_int) ;

assign Q = Q_int;
assign Qn = Qn_int;

endmodule