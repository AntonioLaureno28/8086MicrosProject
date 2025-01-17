`include "shift_left.v"
`include "shift_right.v"

module Comparator (
    input wire [7:0] A, 
    input wire [7:0] B, 
    input wire clk, 
    output reg bigger, 
    output reg equal, 
    output reg smallest
);

  integer i;
  wire [7:0]shift_left; 
  wire [7:0]shift_right;
  
  shiftLeft SL (.A(A), .shift(3'b001), .X(shift_left));
  shiftLeft SR (.A(A), .shift(3'b001), .X(shift_right)); 
	
  

  reg stop; // Variável de controle para sair do loop

  always @(posedge clk) begin
     equal <= 1;
     bigger <= 0;
     smallest <= 0;
     stop = 0;

     for (i = 7; i >= 0 && !stop; i = i - 1) begin
         if (A[i] > B[i]) begin
             bigger <= 1;
             equal <= 0;
             smallest <= 0;
             stop = 1; // Sinaliza para sair do loop
         end else if (A[i] < B[i]) begin
             smallest <= 1;
             equal <= 0;
             bigger <= 0;
             stop = 1; // Sinaliza para sair do loop
         end
     end
 end


endmodule
      

  