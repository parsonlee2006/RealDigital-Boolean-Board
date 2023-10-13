module ALU
#(parameter DIVIDER = 100000)
(  input clk,rst,
   input [10:0]sw,
   input [2:0] btn,
   output reg [7:0] D1_SEG, D0_SEG,
   output reg [3:0] D1_AN,D0_AN
);
localparam ADD = 3'b000,
           INC = 3'b001,
           SUB = 3'b010,
           BIT_XOR = 3'b011,
           BIT_OR  = 3'b100,
           BIT_AND = 3'b101;           
////////////Data load//////////////////
reg [7:0]A,B;
always @(posedge clk)begin
    if(rst)begin A <= 0; 
                 B <= 0;
            end
    else begin
        A <=(btn[0])? sw[7:0]:A;
        B <=(btn[1])? sw[7:0]:B;
    end
end
////////////ALU////////////////////////
reg [7:0]bin_data;
always @(*)begin
    case(sw[10:8])
    ADD: bin_data = A + B ;
    INC: bin_data = A + 1 ;
    SUB: bin_data = A - B ;
    BIT_XOR: bin_data = A ^ B ;
    BIT_OR:  bin_data = A | B ;
    BIT_AND: bin_data = A & B ;
    default: bin_data = bin_data;
    endcase
end
///////////binary to BCD///////////////
reg [11:0]bcd;
integer i;
always @(*)begin
  bcd=0;		 	
    for (i=0;i<8;i=i+1) begin					//Iterate once for each bit in input number
        if (bcd[3:0] >= 5)  bcd[3:0]  = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
	    if (bcd[7:4] >= 5)  bcd[7:4]  = bcd[7:4] + 3;
	    if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	    bcd = {bcd[10:0],bin_data[7-i]};				//Shift one bit, and shift in proper bit from input 
    end
end
///////////Display statement/////////////////////
reg [$clog2(DIVIDER):0]cnt;
always @(posedge clk, posedge rst)begin
    if(rst)cnt <= 0;
    else cnt = cnt + 1;
end
////////////2-bit counter///////////////
wire [1:0] S;
reg [3:0] data;
assign S = cnt[$clog2(DIVIDER):$clog2(DIVIDER)-1];
always @(*)begin
    case(S)
    2'b00: begin data = bcd[3:0];  D1_AN= 4'b1110;end
    2'b01: begin data = bcd[7:4];  D1_AN= 4'b1101;end
    2'b10: begin data = bcd[11:8]; D1_AN= 4'b1011;end
    2'b11: begin data = 4'd0;      D1_AN= 4'b0111;end
    endcase
end
always @ (*)
begin
    case(data)
    0: D1_SEG = 7'b100_0000;	
    1: D1_SEG = 7'b111_1001;
    2: D1_SEG = 7'b010_0100;
    3: D1_SEG = 7'b011_0000;
    4: D1_SEG = 7'b001_1001;
    5: D1_SEG = 7'b001_0010;
    6: D1_SEG = 7'b000_0010;
    7: D1_SEG = 7'b111_1000;
    8: D1_SEG = 7'b000_0000;
    9: D1_SEG = 7'b001_0000;
    default: D1_SEG = 7'b100_0000;	
    endcase
end
endmodule
