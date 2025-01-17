`ifndef shiftRight
`define shiftRight
module shiftRight (input wire [7:0]A, input wire [2:0]shift, output wire [7:0]X);
  assign X = A >> shift;
endmodule
`endif