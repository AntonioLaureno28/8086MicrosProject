module Stack (input wire clk, input wire rst, input wire push, input wire pop, input wire [7:0]In,
              output reg [7:0]Out, output reg [7:0]SP, input wire [7:0]SS);
  
  reg [7:0] stack_memory[255:0]
  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      SP <= 8'b11111111;
    end else if (push) begin 
      stack_memory[SP + SS] <= In;
      SP <= SP - 1; // SP é decrementado para apontar para a proxima posição
    end else if (pop) begin
      SP <= SP + 1; // SP é incrementado para apontar para o próximo dado na pilha
      Out <= stack_memory[SP + SS];
    end
  end
endmodule
      