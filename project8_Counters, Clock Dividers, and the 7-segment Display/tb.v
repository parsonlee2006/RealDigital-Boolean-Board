`timescale 1ns / 1ps
module tb;
    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [6:0]led;

    // Instantiate the Unit Under Test (UUT)
    BCD_cnt uut (
        .clk(clk),
        .rst(rst),
        .led(led)
    );

    always
        #1 clk = ~clk;

    initial begin
        $dumpfile("04.vcd");
        $dumpvars;
        // Initialize Inputs
        clk = 0;
        rst = 1;
        #10 rst = 0;

        // Wait 100 ns for global reset to finish
        #1000;
        $finish;
    end

endmodule
    

