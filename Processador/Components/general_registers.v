// Design - Register 8bits

module x86_register_file (
    input logic clk,               // Clock
    input logic rst,               // Reset ativo em nível alto
    input logic [2:0] read_addr1,  // Endereço do primeiro registrador para leitura
    input logic [2:0] read_addr2,  // Endereço do segundo registrador para leitura
  	input logic [2:0] read_addr3,  // Endereço do terceiro registrador para leitura
  	input logic [2:0] write_addr,  // Endereço do registrador para escrita
    input logic [7:0] write_data,  // Dados a serem escritos
    input logic write_enable,      // Habilitação de escrita
    output logic [7:0] read_data1, // Dados lidos do registrador 1
  	output logic [7:0] read_data2,  // Dados lidos do registrador 2
  	output logic [7:0] read_data3  // Dados lidos do registrador 3
);

    // Registradores (8 bits cada: AX, BX, CX, DX)
    logic [7:0] registers [0:3];

    // Inicialização dos registradores no reset
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            registers[0] <= 8'b0; // AX
            registers[1] <= 8'b0; // BX
            registers[2] <= 8'b0; // CX
            registers[3] <= 8'b0; // DX
        end 
      	else if (write_enable) begin   
          registers[write_addr] <= write_data;
        end
    end

    // Leitura
    assign read_data1 = registers[read_addr1];
    assign read_data2 = registers[read_addr2];
  	assign read_data3 = registers[read_addr3];

endmodule