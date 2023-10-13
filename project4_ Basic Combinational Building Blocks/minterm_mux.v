module minterm_mux(
   input [3:0] sw,
   output reg led
  
);

always @(sw) begin
    case(sw)
    4'd3: led <= 1;
    4'd4: led <= 1;
    4'd6: led <= 1;
    4'd8: led <= 1;
    4'd9: led <= 1;
    4'd10: led <= 1;
    4'd13: led <= 1;
    default: led <= 1'd0;
    endcase    
end

endmodule