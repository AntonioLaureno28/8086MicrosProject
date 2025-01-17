`include "UC.v"
`include "ROM.v"
`include "ALU.v"
`include "Registers_x86.v"


module CPU (
    input wire clk,            // Clock
    input wire rst,            // Reset
    output wire [7:0] pc_out,  // Contador de programa
    output wire [7:0] alu_out, // Saída da ALU
    output wire [7:0] flags    // Flags da ALU
);

    // Fios para interconexão
    wire [7:0] instruction;    // Instrução da ROM
    wire [7:0] alu_result;     // Resultado da ALU
    wire [7:0] alu_flags;      // Flags da ALU
    wire [7:0] reg_out1, reg_out2; // Dados dos registradores
    wire [7:0] mem_data;       // Dados da memória

    // UC - Sinais de Controle
    wire ir_load, reg_load_a, reg_load_b;
    wire [7:0] alu_op;

    // Contador de programa
    reg [7:0] pc;

    // Instanciação dos módulos
    UC control_unit (
        .clock(clk),
        .reset(rst),
        .IR(instruction),      // Código de operação
        .ir_load(ir_load),
      	.reg_load_a(reg_load_a),
      	.reg_load_b(reg_load_b),
        .alu_op(alu_op)
    );

    ALU alu (
        .A(reg_out1),
        .B(reg_out2),
        .Selector(alu_op),
        .clk(clk),
        .X(alu_result),
        .Flags(alu_flags)
    );

    ROM rom (
        .address(pc),
        .data_out(instruction)
    );

    x86_register_file registers (
        .clk(clk),
        .rst(rst),
        .read_addr1(instruction[3:2]),
        .read_addr2(instruction[1:0]),
        .write_addr(instruction[5:4]),
        .write_data(alu_result),
        .write_enable(reg_load),
        .read_data1(reg_out1),
        .read_data2(reg_out2)
    );

    // Atualiza o contador de programa
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 8'b0;
        end else if (ir_load) begin
            pc <= pc + 1;
        end
    end

    // Saídas da CPU
    assign pc_out = pc;
    assign alu_out = alu_result;
    assign flags = alu_flags;

endmodule
