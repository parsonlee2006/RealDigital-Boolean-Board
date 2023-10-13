module auto_con(
    input ct,cl ,ot,ol,// ct cl ot ol
    output [1:0] RGB // RGB[0] = blue, RGB[1] = red
);
assign RGB[0] = (ct & (ot | ol))|
                (ot & ~ol)|
                (~ct & cl & ~ot & ~ol)|
                (~ct & ~cl & ~ot & ol);
assign RGB[1] = (ct & cl )| (ot & ol)| (ct & ot)   ;             

endmodule