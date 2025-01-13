`include "adder.v"

module subtractor ( input wire [7:0]A, input wire [7:0]B,
                   output wire [7:0]X, output wire Cout );
  
  wire [7:0]C_Comp;
  assign C_Comp = ~B + 1;
  
  adder A ( .A(A), .B(C_Comp), .Cin(1'b0), .Sum(X) );
endmodule