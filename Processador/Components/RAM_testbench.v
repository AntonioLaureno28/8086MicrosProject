`timescale 1ns / 1ps

module RAM_tb;
    reg [5:0] Addr;
    reg we;
    reg clk;
    wire [7:0] X;

    // Instância do módulo RAM
    RAM uut (
      	.Data(8'b0), // Não testa escrita
        .Addr(Addr),
        .we(we),
        .clk(clk),
        .X(X)
    );

    // Gerador de clock
    always #5 clk = ~clk;

    initial begin
        // Inicialização
        clk = 0;
        we = 0;
        Addr = 6'b0;

        // Aguarde para garantir o carregamento
        #10;

        // Verificar os dados carregados
        Addr = 6'd0; #10;
      	$display("Endereco 0: %b", X);

        Addr = 6'd1; #10;
      	$display("Endereco 1: %b", X);

        Addr = 6'd2; #10;
      	$display("Endereco 2: %b", X);

        Addr = 6'd3; #10;
      	$display("Endereco 3: %b", X);

        // Finalizar simulação
        #20;
        $finish;
    end
endmodule
