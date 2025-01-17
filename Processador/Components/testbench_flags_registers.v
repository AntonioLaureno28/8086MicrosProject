module testbench_flagRegister;
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