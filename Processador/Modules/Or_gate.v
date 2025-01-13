module OrGate ( input wire [7:0]A, input wire [7:0]B, output [7:0]X );
  assign X = A | B;
endmodule