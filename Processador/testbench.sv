`timescale 1ns / 1ps

module CPU_testbench;

    reg clk, rst;
    wire [7:0] pc_out, alu_out, flags;

    // Instanciar a CPU
    CPU uut (
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out),
        .alu_out(alu_out),
        .flags(flags)
    );

    // Geração de clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;

        // Teste para a instrução ADD
        // Carregar os valores nos registradores
        uut.registers.registers[0] = 8'd10; // AX = 10
        uut.registers.registers[1] = 8'd20; // BX = 20

        // Carregar instrução ADD (ADD AX, BX, CX)
      	uut.rom.mem[0] = 8'b00000001000110; // ADD AX, BX -> CX

        #20;
        $display("Resultado da soma (CX): %d", uut.registers.registers[2]); // Exibir CX

        $finish;
    end
endmodule