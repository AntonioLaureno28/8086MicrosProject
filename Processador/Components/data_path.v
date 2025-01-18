`include "ALU.v"
`include "general_registers.v"


module datapath (
    input wire clock,
    input wire reset,
    input logic [7:0]Operando1, Operando2,        
    input wire [7:0] alu_op,
    input wire reg_load_a,           // Sinal para carregar o registrador A
    input wire reg_load_b,           // Sinal para carregar o registrador B
    input wire reg_load_c,           // Sinal para armazenar o resultado no registrador C
    output wire [7:0] result,        // Resultado final da operação
    output wire [7:0] flags          // Flags
);

    wire [7:0] reg_operando1, reg_operando2, reg_result;  // Dados lidos dos registradores
    wire [7:0] alu_out;              // Saída da ALU
    wire we1, we2, we3;              // Habilitação de escrita nos registradores


    // Banco de Registradores
    x86_register_file reg_file (
        .clk(clock),
        .rst(reset),
        .write_data1(Operando1), // Dados para o registrador A
        .write_data2(Operando2), // Dados para o registrador B
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
        .A(reg_operando1),  // Operando 1 tentar usar operandos dos registradores
        .B(reg_operando2),  // Operando 2
        .Selector(alu_op),  // Código da operação
        .X(alu_out),        // Resultado da operação
        .Flags(flags)       // Flags
    );

    // Resultado final
    assign result = reg_result;
endmodule