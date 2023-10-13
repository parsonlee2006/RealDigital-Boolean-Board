module wrapper(
    input [3:0]sw,
    input  clk,
    output  [3:0]led
);

wire sdata;
wire [1:0] btn;
counter input_clk(
    .clk(clk),
    .Y1(btn[1]),
    .Y0(btn[0])
);
mux input_mux(
    .I(sw),
    .S(btn),
    .Y(sdata)
);
demux output_demux(
    .EN(sdata),
    .I(btn),
    .Y(led)
);

endmodule