module ROM (
    input [7:0] address,  // Endereço da instrução
    output reg [7:0] data_out  // Saída da instrução
);
  reg [7:0] mem [0:255];  // Memória para armazenar as instruções (256 endereços de 8 bits)

    always @(address) begin
        data_out = mem[address];
    end
endmodule
