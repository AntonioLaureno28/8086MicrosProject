`include "And_gate.v"
`include "adder.v" // Já inclui os módulos necessários

`ifndef multiplier
`define multiplier

module adder_multiplier (
    output wire [15:0] Sum, 
    input wire [15:0] A, 
    input wire [15:0] B
);
    wire C[15:0]; 

    full_adder f1 (.Sum(Sum[0]), .Cout(C[0]), .A(A[0]), .B(B[0]), .Cin(1'b0));
    full_adder f2 (.Sum(Sum[1]), .Cout(C[1]), .A(A[1]), .B(B[1]), .Cin(C[0]));
    full_adder f3 (.Sum(Sum[2]), .Cout(C[2]), .A(A[2]), .B(B[2]), .Cin(C[1]));
    full_adder f4 (.Sum(Sum[3]), .Cout(C[3]), .A(A[3]), .B(B[3]), .Cin(C[2]));
    full_adder f5 (.Sum(Sum[4]), .Cout(C[4]), .A(A[4]), .B(B[4]), .Cin(C[3]));
    full_adder f6 (.Sum(Sum[5]), .Cout(C[5]), .A(A[5]), .B(B[5]), .Cin(C[4]));
    full_adder f7 (.Sum(Sum[6]), .Cout(C[6]), .A(A[6]), .B(B[6]), .Cin(C[5]));
    full_adder f8 (.Sum(Sum[7]), .Cout(C[7]), .A(A[7]), .B(B[7]), .Cin(C[6]));
    full_adder f9 (.Sum(Sum[8]), .Cout(C[8]), .A(A[8]), .B(B[8]), .Cin(C[7]));
    full_adder f10 (.Sum(Sum[9]), .Cout(C[9]), .A(A[9]), .B(B[9]), .Cin(C[8]));
    full_adder f11 (.Sum(Sum[10]), .Cout(C[10]), .A(A[10]), .B(B[10]), .Cin(C[9]));
    full_adder f12 (.Sum(Sum[11]), .Cout(C[11]), .A(A[11]), .B(B[11]), .Cin(C[10]));
    full_adder f13 (.Sum(Sum[12]), .Cout(C[12]), .A(A[12]), .B(B[12]), .Cin(C[11]));
    full_adder f14 (.Sum(Sum[13]), .Cout(C[13]), .A(A[13]), .B(B[13]), .Cin(C[12]));
    full_adder f15 (.Sum(Sum[14]), .Cout(C[14]), .A(A[14]), .B(B[14]), .Cin(C[13]));
    full_adder f16 (.Sum(Sum[15]), .Cout(), .A(A[15]), .B(B[15]), .Cin(C[14]));

endmodule


module multiplier (
    input wire [7:0] A, 
    input wire [7:0] B, 
    output wire [15:0] Mult
);
    wire [7:0] product [7:0];     
    wire [15:0] shifted [7:0];     
    wire [15:0] partial_sum [7:0];

    genvar i, j;

    generate
        for (i = 0; i < 8; i = i + 1) begin : product_gen
            for (j = 0; j < 8; j = j + 1) begin : and_gen
                AndGate and_gate (
                    .A(A[i]), 
                    .B(B[j]), 
                    .X(product[i][j])
                );
            end
        end
    endgenerate

    generate
        for (i = 0; i < 8; i = i + 1) begin : shift_gen
            assign shifted[i] = {product[i], {i{1'b0}}}; 
        end
    endgenerate

    assign partial_sum[0] = shifted[0];
    generate
        for (i = 1; i < 8; i = i + 1) begin : sum_gen
            adder_multiplier adder (
                .A(partial_sum[i-1]), 
                .B(shifted[i]), 
                .Sum(partial_sum[i])
            );
        end
    endgenerate

    assign Mult = partial_sum[7];
endmodule
`endif
