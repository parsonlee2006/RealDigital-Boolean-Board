module two_7seg_tb;
reg[7:0] sw;
reg btn;
wire [6:0] seg;

two_7seg name(
    .sw(sw),
    .btn(btn),
    .seg(seg)
);

always begin
   #5 btn = ~btn;
end
initial begin
    $dumpfile("two_7seg.vcd");
    $dumpvars(0,name); 
    btn = 0;
    sw = 0;
    #10 sw = 8'b1111_0001 ; //F1
    #10 sw = 8'b1110_0010; // E2
    #10 sw = 8'b1110_0011; // D3
    #10 sw = 8'b1101_0100; // C4
    #10 sw = 8'b1100_0101; // B5
    #10 $stop;
end

 endmodule 