module two_7seg(
    input [7:0] sw,
    input btn,
    output [6:0] seg
);  
wire [3:0] sdata;
mux2_1 input_mux(
    .sw(sw),
    .sel(btn),
    .data(sdata)
);

bin2seg output_seg(
    .B(sdata),
    .seg7(seg)
);

endmodule
    