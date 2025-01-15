/*
module flags_register (
    input logic clk,                // Clock
    input logic rst,                // Reset ativo em nível alto
    input logic [7:0] alu_result,   // Resultado da operação da ALU
    input logic carry_in,           // Carry gerado pela ALU
    input logic overflow_in,        // Overflow gerado pela ALU
    input logic update_flags,       // Sinal para atualizar os flags
    output logic zero_flag,         // Zero Flag (ZF)
    output logic sign_flag,         // Sign Flag (SF)
    output logic carry_flag,        // Carry Flag (CF)
    output logic overflow_flag,     // Overflow Flag (OF)
    output logic parity_flag        // Parity Flag (PF)
);

    // Atualização dos flags no clock
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            zero_flag <= 1'b0;
            sign_flag <= 1'b0;
            carry_flag <= 1'b0;
            overflow_flag <= 1'b0;
            parity_flag <= 1'b0;
        end else if (update_flags) begin
            // Zero Flag: O resultado da ALU é zero
            zero_flag <= (alu_result == 8'b0);

            // Sign Flag: O bit mais significativo do resultado da ALU
            sign_flag <= alu_result[7];

            // Carry Flag: Valor de carry gerado pela ALU
            carry_flag <= carry_in;

            // Overflow Flag: Overflow gerado pela ALU
            overflow_flag <= overflow_in;

            // Parity Flag: Número de bits '1' no resultado é par
            parity_flag <= ~^alu_result;  // XOR reduzido para paridade
        end
    end
endmodule
*/

module flagRegister;
    logic clk, rst, update_flags;
    logic [7:0] alu_result;
    logic carry_in, overflow_in;
    logic zero_flag, sign_flag, carry_flag, overflow_flag, parity_flag;

    flags_register uut (
        .clk(clk),
        .rst(rst),
        .alu_result(alu_result),
        .carry_in(carry_in),
        .overflow_in(overflow_in),
        .update_flags(update_flags),
        .zero_flag(zero_flag),
        .sign_flag(sign_flag),
        .carry_flag(carry_flag),
        .overflow_flag(overflow_flag),
        .parity_flag(parity_flag)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Inicializa sinais
        clk = 0;
        rst = 1;
        alu_result = 8'b0;
        carry_in = 0;
        overflow_in = 0;
        update_flags = 0;

        // Reset
        #10 rst = 0;

        // Teste 1: Resultado da ALU = 0
        alu_result = 8'b00000000;
        update_flags = 1;
        #10;

        // Teste 2: Resultado da ALU = 128 (bit de sinal ativo)
        alu_result = 8'b10000000;
        #10;

        // Teste 3: Carry e Overflow ativos
        alu_result = 8'b11111111;
        carry_in = 1;
        overflow_in = 1;
        #10;

        // Exibir resultados
        $display("ZF: %b, SF: %b, CF: %b, OF: %b, PF: %b", zero_flag, sign_flag, carry_flag, overflow_flag, parity_flag);

        $finish;
    end
endmodule
