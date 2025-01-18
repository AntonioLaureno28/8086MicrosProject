`include "UC.v"
`include "data_path.v"
`include "program_counter_register.v"
`include "RAM.v"




module CPU (
    input wire clk,            // Clock
    input wire rst,            // Reset
  	input wire [7:0]Data_w,
  	input wire ram_we,
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
  	wire PC_LOAD;
  	wire [7:0]Op1, [7:0]Op2;
  	

    // UC - Sinais de Controle
    wire ir_load, reg_load, mem_write, mem_read;
    wire [7:0] alu_op;

    // Contador de programa
    reg [7:0] pc;

    // Instanciação dos módulos
  	program_counter_register Pc (
      	.clock(clk),
      	.reset(rst),
      	.pc_load(PC_LOAD),
      	.opcode(instruction),
      	.pc(pc),
    );
  
    UC control_unit (
        .clock(clk),
        .reset(rst),
        .IR(instruction),      // Código de operação
        .ir_load(ir_load),
        .reg_load_a(reg_load),
        .reg_load_b(reg_load),
      	.reg_load_c(reg_load),
      	.pc_load(PC_LOAD),
      	.alu_op(alu_op),
    );
  
  	data_path dataPath(
      .clock(clk),
      .reset(rst),
      .Operando1(),
      .Operando2(),
      .alu_op(),
      .reg_load_a(),
      .reg_load_b(),
      .reg_load_c(),
      .result(),
      .flags(),
  	);
  
  
  	RAM ram (
      .Data(Data_w),
      .Addr(pc),
      .we(ram_we),
      .clk(clk),
      .opcode(instruction),
      .Operando1(Op1),
      .Operando2(Op2),
    );
  
  	
	   always @(posedge clk or posedge rst) begin
        if (rst) begin
            IR <= 8'b0; // Reseta o registrador de instrução
        end else if (ir_load) begin
            IR <= instruction; // Carrega a instrução da RAM no registrador IR
        end
    end
  	


    // Atualiza o contador de programa

    // Saídas da CPU
    assign pc_out = pc;
    assign alu_out = alu_result;
    assign flags = alu_flags;

endmodule
