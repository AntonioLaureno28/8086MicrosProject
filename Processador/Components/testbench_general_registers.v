module testbench_x86_register_file;
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