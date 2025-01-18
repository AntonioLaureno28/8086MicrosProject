`timescale 1ns/1ps

module ALU_tb;

  // Entradas
  reg [7:0] A, B, Selector;

  // Saídas
  wire [7:0] X, Flags;

  // Instância da ALU
  ALU uut (
    .A(A),
    .B(B),
    .Selector(Selector),
    .X(X),
    .Flags(Flags)
  );

  // Inicialização e estímulos
  initial begin
    // Monitorar sinais
    $monitor("Time: %0d | A: %b (%d), B: %b (%d), Selector: %b | X: %b (%d), Flags: %b", 
              $time, A, A, B, B, Selector, X, X, Flags);

    // Teste 1: Soma
    A = 8'b00000011; // 3
    B = 8'b00000010; // 2
    Selector = 8'b00000001;
    #10;

    // Teste 2: Subtração
    A = 8'b00000100; // 4
    B = 8'b00000010; // 2
    Selector = 8'b00000010;
    #10;

    // Teste 3: Multiplicação
    A = 8'b00001010; // 3
    B = 8'b00001111; // 2
    Selector = 8'b00000011;
    #10;

    // Teste 4: Divisão (sem erro)
    A = 8'b00001000; // 8
    B = 8'b00000010; // 2
    Selector = 8'b00000100;
    #10;

    // Teste 5: Divisão por Zero
    A = 8'b00001000; // 8
    B = 8'b00000000; // 0
    Selector = 8'b00000100;
    #10;

    // Teste 6: Shift Left
    A = 8'b00000001; // 1
    B = 8'b00000010; // Shift de 2 bits
    Selector = 8'b00001101;
    #10;

    // Teste 7: Shift Right
    A = 8'b00001000; // 8
    B = 8'b00000010; // Shift de 2 bits
    Selector = 8'b00001110;
    #10;

    // Teste 10: Comparação (A e B)
    A = 8'b00000101; // 3
    B = 8'b00000011; // 5
    Selector = 8'b00001111;
    #10;

    // Finalizar simulação
    $stop;
  end
endmodule
