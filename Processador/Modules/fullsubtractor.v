`include "adder.v"
`ifndef subtractor
`define subtractor

module subtractor ( input wire [7:0]A, input wire [7:0]B,
                   output wire [7:0]Diff, output wire Cout, output wire Oflow );
  
  wire [7:0]C_Comp;
  assign C_Comp = ~B + 1;
  
  adder A1 ( .A(A), .B(C_Comp), .Sum(Diff) );
  
 
  
endmodule
`endif