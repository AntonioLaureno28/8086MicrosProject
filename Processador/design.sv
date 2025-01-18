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
   	reg [7:0] IR;              // Registrador de instrução
  	wire [7:0]Op1_ram, Op2_ram;
  	logic [7:0]Op1_dp, Op2_dp;

  	

    // UC - Sinais de Controle
    wire ir_load, reg_load_a, reg_load_b, reg_load_c, mem_write, mem_read;
    wire [7:0] alu_op;

    // Contador de programa
  	wire [5:0] pc;

    // Instanciação dos módulos
  	program_counter Pc (
      	.clock(clk),
      	.reset(rst),
      	.pc_load(PC_LOAD),
      	.opcode(instruction),
      	.pc(pc)
    );
  
    UC control_unit (
        .clock(clk),
        .reset(rst),
        .IR(instruction),      // Código de operação
        .ir_load(ir_load),
      	.reg_load_a(reg_load_a),
      	.reg_load_b(reg_load_b),
      	.reg_load_c(reg_load_c),
      	.pc_load(PC_LOAD),
      	.alu_op(alu_op)
    );
  
  	datapath dataPath(
      .clock(clk),
      .reset(rst),
      .Operando1(Op1_dp),
      .Operando2(Op2_dp),
      .alu_op(alu_op),
      .reg_load_a(reg_load_a),
      .reg_load_b(reg_load_b),
      .reg_load_c(reg_load_c),
      .result(alu_result),
      .flags(alu_flags)
  	);
  
  
  	RAM ram (
      .Data(Data_w),
      .Addr(pc),
      .we(ram_we),
      .clk(clk),
      .Opcode(instruction),
      .Operando1(Op1_ram),
      .Operando2(Op2_ram)
    );
  
  	
	   always @(posedge clk or posedge rst) begin
        if (rst) begin
            IR <= 8'b0; // Reseta o registrador de instrução
        end else if (ir_load) begin
            IR <= instruction; // Carrega a instrução da RAM no registrador IR
          	Op1_dp <= Op1_ram;
            Op2_dp <= Op2_ram;
        end
    end
  	


    // Atualiza o contador de programa

    // Saídas da CPU
    assign alu_out = alu_result;
    assign flags = alu_flags;

endmodule
