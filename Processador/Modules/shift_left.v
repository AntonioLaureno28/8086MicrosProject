module shiftLeft (input wire [7:0]A, input wire [2:0]shift, output wire [7:0]X);
  assign X = A << shift;
endmodule