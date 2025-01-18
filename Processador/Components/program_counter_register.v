module program_counter (
    input wire clock,
    input wire reset,
    input wire pc_load,         // Novo sinal para carregamento do PC
    input wire [7:0] opcode,    // Opcode atual
    output reg [5:0] pc         // Contador de programa (6 bits para 64 endereços)
);

    // Função para determinar o tamanho da instrução
    function [1:0] instruction_size;  // Retorna o tamanho da instrução (1, 2 ou 3 palavras)
        input [7:0] opcode;           // Recebe o opcode
        begin
            case (opcode)
                8'b01111000: instruction_size = 2;  // Exemplo: Opcode para instrução com 1 operando
                8'b10000000: instruction_size = 2;
                8'b10000001: instruction_size = 2;
                8'b10000010: instruction_size = 2;
                8'b10000100: instruction_size = 2;
                8'b10000101: instruction_size = 2;
                8'b10000111: instruction_size = 2;
                8'b10000011: instruction_size = 1; // Exemplo: Opcode para instrução com 0 operandos
                default:      instruction_size = 3;  // Instruções com 2 operandos
            endcase
        end
    endfunction

    // Atualização do Program Counter
    always @(posedge clock or posedge reset) begin
      $display("opcode: %b, pcload:%d, pc:%b",opcode, pc_load, pc);
        if (reset)
            pc <= 6'b0;  // Reseta o contador para 0
        else if (pc_load)
          	pc <= pc + instruction_size(opcode); 
    end
endmodule