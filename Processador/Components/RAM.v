`timescale 1ns / 1ps
module RAM (
    input wire [7:0] Data, 
    input wire [5:0] Addr, 
    input wire we, 
    input wire clk, 
    output reg [7:0] X
);
  	reg [7:0] Ram [0:63];  // Define 64x8 RAM

    // Carrega os dados no início da simulação
    initial begin
      $readmemb("memoria.bin", Ram, 0, 7); 
    end

    always @(posedge clk) begin
        if (we)
            Ram[Addr] <= Data;   // Operação de escrita
        else
            X <= Ram[Addr];      // Operação de leitura
    end
endmodule
