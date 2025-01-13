`include "fulladder.v"

module adder ( output wire [7:0] Sum, output wire Cout,
              input wire [7:0] A, input wire [7:0] B );
  
  wire C1, C2, C3, C4, C5, C6, C7;
  
  full_adder f1 (.Sum(Sum[0]), .Cout(C1), .A(A[0]), .B(B[0]),.Cin(1'b0));
  full_adder f2 (.Sum(Sum[1]), .Cout(C2), .A(A[1]), .B(B[1]), .Cin(C1));
  full_adder f3 (.Sum(Sum[2]), .Cout(C3), .A(A[2]), .B(B[2]), .Cin(C2));
  full_adder f4 (.Sum(Sum[3]), .Cout(C4), .A(A[3]), .B(B[3]), .Cin(C3));
  full_adder f5 (.Sum(Sum[4]), .Cout(C5), .A(A[4]), .B(B[4]), .Cin(C4));
  full_adder f6 (.Sum(Sum[5]), .Cout(C6), .A(A[5]), .B(B[5]), .Cin(C5));
  full_adder f7 (.Sum(Sum[6]), .Cout(C7), .A(A[6]), .B(B[6]), .Cin(C6));
  full_adder f8 (.Sum(Sum[7]), .Cout(Cout), .A(A[7]), .B(B[7]),.Cin(C7));
endmodule
