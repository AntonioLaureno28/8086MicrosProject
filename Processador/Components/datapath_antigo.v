`include "RAM.v"
`include "program_counter_register"
`include "ALU.v"
`include "general_registers.v"


module datapath (
    input wire clock,
    input wire reset,
    input wire [7:0] dataIn,         // Entrada de dados externa (para escrita na RAM)
    input wire pc_load,              // Sinal para atualizar o PC
    input wire reg_load_a,           // Sinal para carregar o registrador A
    input wire reg_load_b,           // Sinal para carregar o registrador B
    input wire reg_load_c,           // Sinal para armazenar o resultado no registrador C
    input wire ram_we,               // Controle de escrita na RAM
    output wire [7:0] result,        // Resultado final da operação
    output wire [7:0] flags          // Flags
);

    // Sinais intermediários
    wire [5:0] pc;                   // Program Counter (endereço atual)
    wire [7:0] opcode;               // Opcode atual (RAM -> saída)
    wire [7:0] ram_operando1, ram_operando2;  // Operandos lidos da RAM
    wire [7:0] reg_operando1, reg_operando2, reg_result;  // Dados lidos dos registradores
    wire [7:0] alu_out;              // Saída da ALU
    wire we1, we2, we3;              // Habilitação de escrita nos registradores

    // Program Counter
    program_counter pc_module (
        .clock(clock),
        .reset(reset),
        .pc_load(pc_load),
        .opcode(opcode),
        .pc(pc)
    );

    // RAM
    RAM ram (
        .Data(dataIn),               // Entrada de dados para escrita
        .Addr(pc),                   // Endereço fornecido pelo PC
        .we(ram_we),                 // Controle de escrita na RAM
        .clk(clock),
        .Opcode(opcode),             // Opcode atual (endereço PC)
        .Operando1(ram_operando1),   // Primeiro operando (endereço PC + 1)
        .Operando2(ram_operando2)    // Segundo operando (endereço PC + 2)
    );

    // Banco de Registradores
    x86_register_file reg_file (
        .clk(clock),
        .rst(reset),
        .write_data1(ram_operando1), // Dados para o registrador A
        .write_data2(ram_operando2), // Dados para o registrador B
        .write_data3(alu_out),       // Resultado da ALU para o registrador C
        .we1(reg_load_a),            // Habilitação de escrita no registrador A
        .we2(reg_load_b),            // Habilitação de escrita no registrador B
        .we3(reg_load_c),            // Habilitação de escrita no registrador C
        .read_addr1(3'b000),         // Registrador A
        .read_addr2(3'b001),         // Registrador B
        .read_addr3(3'b010),         // Registrador C
        .read_data1(reg_operando1),  // Dados lidos do registrador A
        .read_data2(reg_operando2),  // Dados lidos do registrador B
        .read_data3(reg_result)      // Dados lidos do registrador C
    );

    // ALU
    ALU alu_unit (
        .A(reg_operando1),  // Operando 1
        .B(reg_operando2),  // Operando 2
        .Selector(opcode),  // Código da operação
        .clk(clock),
        .X(alu_out),        // Resultado da operação
        .Flags(flags)       // Flags
    );

    // Resultado final
    assign result = alu_out;

endmodule
