`timescale 1ns / 1ps
module RAM (
    input wire [7:0] Data, 
    input wire [5:0] Addr, 
    input wire we, 
    input wire clk, 
    output reg [7:0] Opcode,     // Saída do opcode (8 bits)
    output reg [7:0] Operando1,  // Primeiro operando (8 bits)
    output reg [7:0] Operando2   // Segundo operando (8 bits)
);
  	reg [7:0] Ram [0:63];  // Define 64x8 RAM

    // Carrega os dados no início da simulação
    initial begin
      $readmemb("memoria.bin", Ram, 0, 7); 
    end

    always @(posedge clk) begin
        if (we)begin
            Ram[Addr] <= Data;   // Operação de escrita
        end else begin
            Opcode <= Ram[Addr];         // Opcode na posição Addr
            Operando1 <= Ram[Addr + 1];  // Primeiro operando na posição Addr+1
            Operando2 <= Ram[Addr + 2];
        end
    end
endmodule