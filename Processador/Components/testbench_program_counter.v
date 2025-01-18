`timescale 1ns / 1ps

module tb_program_counter;

    // Entradas do módulo
    reg clock;
    reg reset;
    reg pc_load;
    reg [7:0] opcode;

    // Saída do módulo
    wire [5:0] pc;

    // Instanciando o módulo a ser testado
    program_counter uut (
        .clock(clock),
        .reset(reset),
        .pc_load(pc_load),
        .opcode(opcode),
        .pc(pc)
    );

    // Geração do clock (período de 10 ns)
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    // Estímulos de teste
    initial begin
        // Ativando monitoramento para exibir os valores a cada alteração
      	$monitor("Time: %0t | reset: %b | pc_load: %b | opcode: %b | pc: %d",
                 $time, reset, pc_load, opcode, pc);

        // Inicialização das entradas
        reset = 1;
        pc_load = 0;
        opcode = 8'b0;

        // Aguarda 20 ns para garantir reset
        #20;
        reset = 0;

        // Teste 1: Instrução com 1 operando (opcode = 8'b01111000)
        pc_load = 1;
        opcode = 8'b01111000;
        #10;  // Aguarda 1 ciclo de clock

        // Teste 2: Instrução com 0 operandos (opcode = 8'b10000011)
        opcode = 8'b10000011;
        #10;

        // Teste 3: Instrução com 2 operandos (opcode = 8'b11111111)
        opcode = 8'b11111111;
        #10;

        // Teste 4: Reset durante operação
        reset = 1;
        #10;
        reset = 0;

        // Teste 5: Instrução com 1 operando após reset (opcode = 8'b10000001)
        pc_load = 1;
        opcode = 8'b10000001;
        #10;

        // Finalizando a simulação
        pc_load = 0;
        #50;
        $stop;
    end

endmodule
