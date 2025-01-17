module test_ALU();
  reg [7:0] A, B, Selector;
  reg clk;
  wire [7:0] X, Flags;

  // Instanciação da ALU
  ALU uut (
    .A(A),
    .B(B),
    .Selector(Selector),
    .clk(clk),
    .X(X),
    .Flags(Flags)
  );

  // Processo inicial
  initial begin
    // Teste de Soma
    A = 8'b00000101; // 5
    B = 8'b00000011; // 3
    Selector = 8'b00000001; // Soma
    clk = 0;

    #10; // Aguarde a propagação dos sinais
    clk = 1;

    #10; // Aguarde mais tempo antes de verificar
    $display("%d + %d = %d, Flags: %b", A, B, X, Flags);

    // Teste de Subtração
    A = 8'b00000101; // 5
    B = 8'b00000011; // 3
    Selector = 8'b00000010; // Subtração
    clk = 0;

    #10;
    clk = 1;

    #10;
    $display("%d - %d = %d, Flags: %b", A, B, X, Flags);

    // Teste de Multiplicação
    A = 8'b00000010; // 2
    B = 8'b00000100; // 4
    Selector = 8'b00000011; // Multiplicação
    clk = 0;

    #10;
    clk = 1;

    #10;
    $display("%d x %d = %d, Flags: %b", A, B, X, Flags);

    // Teste de Divisão
    A = 8'b00000110; // 6
    B = 8'b00000010; // 2
    Selector = 8'b00000100; // Divisão
    clk = 0;

    #10;
    clk = 1;

    #10;
    $display("%d / %d = %d, Flags: %b", A, B, X, Flags);
    
    // Teste de Divisão
    A = 8'b00000110; // 6
    B = 8'b00000010; // 2
    Selector = 8'b00000101; // Resto
    clk = 0;

    #10;
    clk = 1;

    #10;
    $display("%d %% %d = %d, Flags: %b", A, B, X, Flags);


    // Teste de AND
    A = 8'b11001100; // 204
    B = 8'b10101010; // 170
    Selector = 8'b00000110; // AND
    clk = 0;

    #10;
    clk = 1;

    #10;
    $display("%b AND %b = %b, Flags: %b", A, B, X, Flags);

    // Teste de OR
    A = 8'b11001100; // 204
    B = 8'b10101010; // 170
    Selector = 8'b00000111; // OR
    clk = 0;

    #10;
    clk = 1;

    #10;
    $display("%b OR %b = %b, Flags: %b", A, B, X, Flags);

    // Teste de XOR
    A = 8'b11001100; // 204
    B = 8'b10101010; // 170
    Selector = 8'b00001000; // XOR
    clk = 0;

    #10;
    clk = 1;

    #10;
    $display("%b XOR %b = %b, Flags: %b", A, B, X, Flags);

    // Finalizar simulação
    $stop;
  end

endmodule
