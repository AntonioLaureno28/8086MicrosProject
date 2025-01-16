/*
// Design - Register 8bits
// registrador 8 bits

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
*/

module testbench;
    logic clk, rst;
  	logic [2:0] read_addr1, read_addr2, read_addr3;
  	logic [7:0] write_data;
  	logic [2:0] write_addr;
    logic write_enable;
  	logic [7:0] read_data1, read_data2, read_data3;

    x86_register_file reg_file (
        .clk(clk),
        .rst(rst),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
      	.read_addr3(read_addr3),
        .write_addr(write_addr),
        .write_data(write_data),
        .write_enable(write_enable),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .read_data3(read_data3)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Inicialização
        clk = 0;
        rst = 1;
        #10 rst = 0;

        // Escreve no registrador AX 
        write_addr = 2'b00;  // AX
        write_data = 8'b00000001;   // Escreve 1 
        write_enable = 1;
        #10 write_enable = 0;

        // Escreve no registrador BX
        write_addr = 2'b01;  // BX
        write_data = 8'b00000100;   // Escreve 4
        write_enable = 1;
        #10 write_enable = 0;

        // Escreve no registrador CX
        write_addr = 2'b10;  // CX
        write_data = 8'b00000101;   // Escreve 5
        write_enable = 1;
        #10 write_enable = 0;

        // Lê os valores do registrador AX
        read_addr1 = 2'b00; // AX
        read_addr2 = 2'b01; // BX
      	read_addr3 = 2'b10; // CX
        #10;

        // Mostra os valores
      $display("AX: %b, BX: %b, CX: %b", read_data1, read_data2, read_data3);

        $finish;
    end
endmodule