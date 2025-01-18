`timescale 1ns/1ps

module CPU_testbench;

    reg clk;                   // Sinal de clock
    reg rst;                   // Sinal de reset
    reg [7:0] Data_w;          // Dados de entrada para a RAM
    reg ram_we;                // Sinal de escrita na RAM
    wire [7:0] alu_out;        // Saída da ALU
    wire [7:0] flags;          // Flags da ALU

    // Instância da CPU
    CPU cpu (
        .clk(clk),
        .rst(rst),
        .Data_w(Data_w),
        .ram_we(ram_we),
        .alu_out(alu_out),
        .flags(flags)
    );

    // Geração do clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock com período de 10ns
    end

    // Sequência de estímulos
    initial begin
        // Inicialização
        $display("Iniciando Testbench...");
        rst = 1;
        Data_w = 8'b0;
        ram_we = 0;

        #10; // Aguarda 10ns
        rst = 0; // Libera o reset

        // Carrega uma instrução na RAM
        #10;
        ram_we = 0;  
        

        // Monitora as saídas da ALU
        $display("Clock Cycle | ALU Output | Flags");
        forever begin
            @(posedge clk); // Espera pelo próximo ciclo de clock
            $display("%d          | %b      | %b", $time, alu_out, flags);
        end
    end

    // Finalização da simulação
    initial begin
        #200; // Define a duração total da simulação
        $display("Fim da simulação.");
        $stop;
    end

endmodule
