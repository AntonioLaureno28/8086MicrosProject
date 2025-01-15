/*
// Design - Register 8bits
// registrador 8 bits

module x86_register_file (
    input logic clk,               // Clock
    input logic rst,               // Reset ativo em nível alto
    input logic [2:0] read_addr1,  // Endereço do primeiro registrador para leitura
    input logic [2:0] read_addr2,  // Endereço do segundo registrador para leitura
    input logic [2:0] write_addr,  // Endereço do registrador para escrita
    input logic [7:0] write_data,  // Dados a serem escritos
    input logic write_enable,      // Habilitação de escrita
    input logic high_byte,         // Escreve no byte alto (1) ou baixo (0)
    output logic [7:0] read_data1, // Dados lidos do registrador 1
    output logic [7:0] read_data2  // Dados lidos do registrador 2
);

    // Registradores (AX, BX, CX, DX)
    logic [7:0] registers [0:3];

    // Inicialização dos registradores no reset
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            registers[0] <= 8'b0; // AX
            registers[1] <= 8'b0; // BX
            registers[2] <= 8'b0; // CX
            registers[3] <= 8'b0; // DX
        end else if (write_enable) begin
            if (high_byte) begin
                // Escreve na parte alta (bits 7:4)
                registers[write_addr][7:4] <= write_data[3:0];
            end else begin
                // Escreve na parte baixa (bits 3:0)
                registers[write_addr][3:0] <= write_data[3:0];
            end
        end
    end

    // Leitura
    assign read_data1 = registers[read_addr1];
    assign read_data2 = registers[read_addr2];

endmodule
*/

module generalRegister;
    logic clk, rst;
    logic [2:0] read_addr1, read_addr2, write_addr;
    logic [7:0] write_data;
    logic write_enable, high_byte;
    logic [7:0] read_data1, read_data2;

    x86_register_file reg_file (
        .clk(clk),
        .rst(rst),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_addr(write_addr),
        .write_data(write_data),
        .write_enable(write_enable),
        .high_byte(high_byte),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Geração de Clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;

        // "Writing" register AX (low)
        write_addr = 3'b000;  // AX
        write_data = 8'he;   // Escreve "E" na parte baixa
        high_byte = 0;
        write_enable = 1;
        #10 write_enable = 0;

        // "Writing" register AX (high)
        write_addr = 3'b000;  // AX
        write_data = 8'hf;   // Escreve "f" na parte alta
        high_byte = 1;
        write_enable = 1;
        #10 write_enable = 0;
      
      	// "Writing" register BX (low)
        write_addr = 3'b001;  // BX
        write_data = 8'hA;   // Escreve "a" na parte baixa
        high_byte = 0;
        write_enable = 1;
        #10 write_enable = 0;

        // "Writing" register BX (high)
        write_addr = 3'b001;  // BX
        write_data = 8'hf;   // Escreve "f" na parte alta
        high_byte = 1;
        write_enable = 1;
        #10 write_enable = 0;

        // Lendo os valores do registrador AX e BX
        read_addr1 = 3'b000; // AX
        read_addr2 = 3'b001; // BX
        #10;

        $display("AX: %h, BX: %h", read_data1, read_data2);

        $finish;
    end
endmodule
