`timescale 1ns / 1ps
module tb;
    // Inputs
    reg clk;
    reg rst;
    // Outputs
    wire led;
    // Instantiate the Unit Under Test (UUT)
    clk_divider uut (
        .clk(clk),
        .rst(rst),
        .led(led)
    );
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;

        #10 rst = 0;

        // Wait 100 ns for global reset to finish
        #100;
    end
endmodule

module clk_divider(
    input clk,
    input rst,
    output led
    );

wire [26:0] din;
wire [26:0] clkdiv;

FDCE dff_inst0 (
    .C(clk),
    .CE(1),
    .CLR(rst),
    .D(din[0]),
    .Q(clkdiv[0])
);

genvar i;
generate
for (i = 1; i < 27; i=i+1)
begin : dff_gen_label
    FDCE dff_inst (
        .C(clkdiv[i-1]),
        .CE(1),
        .CLR(rst),
        .D(din[i]),
        .Q(clkdiv[i])
    );
    end
endgenerate

assign din = ~clkdiv;

assign led = clkdiv[26];

endmodule

