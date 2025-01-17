`timescale 1ns / 1ps

module RAM_tb;
    // Parâmetros do módulo RAM
    reg [7:0] Data;          // Entrada de dados
    reg [5:0] Addr;          // Endereço
    reg we;                  // Sinal de escrita
    reg clk;                 // Sinal de clock
    wire [7:0] X;            // Saída de dados

    // Instância do módulo RAM
    RAM uut (
        .Data(Data),
        .Addr(Addr),
        .we(we),
        .clk(clk),
        .X(X)
    );

    // Gerador de clock
    always #5 clk = ~clk;    // Clock com período de 10 ns

    initial begin
        // Inicialização
        clk = 0;
        we = 0;
        Data = 8'b0;
        Addr = 6'b0;

        // Teste 1: Escrever no endereço 5
        #10;
        we = 1;             // Habilita escrita
        Addr = 6'd5;        // Endereço 5
        Data = 8'hA5;       // Valor 0xA5
        #10;
        we = 0;             // Desabilita escrita

        // Teste 2: Ler do endereço 5
        #10;
        Addr = 6'd5;        // Endereço 5
        #10;
        $display("Endereço: %d, Leitura: %h", Addr, X);

        // Teste 3: Escrever no endereço 10 e ler
        #10;
        we = 1;             // Habilita escrita
        Addr = 6'd10;       // Endereço 10
        Data = 8'h3C;       // Valor 0x3C
        #10;
        we = 0;             // Desabilita escrita
        Addr = 6'd10;       // Endereço 10
        #10;
        $display("Endereço: %d, Leitura: %h", Addr, X);

        // Finaliza a simulação
        #20;
        $finish;
    end
endmodule
