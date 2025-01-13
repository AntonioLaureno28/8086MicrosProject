module NotGate ( input wire [7:0]A, output [7:0]X );
  assign #1 X = ~A;
endmodule