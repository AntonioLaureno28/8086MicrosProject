`ifndef full_adder
`define full_adder

module half_adder (output wire Sum, Cout,
                   input wire A, B);
  xor U1(Sum, A, B);
  and U2(Cout, A, B);
endmodule
`endif

`ifndef full_adder
`define full_adder

module full_adder (output wire Sum, Cout,
                   input wire A, B, Cin);
  wire HA1_sum, HA1_Cout, HA2_Cout;

  half_adder U1 (.Sum(HA1_sum), .Cout(HA1_Cout), .A(A), .B(B));
  half_adder U2 (.Sum(Sum), .Cout(HA2_Cout), .A(HA1_sum), .B(Cin));

  or U3 (Cout, HA2_Cout, HA1_Cout);
endmodule
`endif