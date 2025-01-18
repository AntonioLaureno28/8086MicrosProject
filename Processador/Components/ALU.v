// Code your design here
`include "adder.v"
`include "fullsubtractor.v"
`include "multiplier.v"
`include "division.v"
`include "shift_left.v"
`include "shift_right.v"
`include "comparator.v"


module ALU ( input wire [7:0]A, input wire [7:0]B, input wire [7:0]Selector,
            output reg [7:0]X, output reg [7:0]Flags );
  wire [7:0] add_X, sub_X, shift_left_X, shift_right_X;
  wire [15:0] mult_X;
  wire [7:0] div_quo, div_rem;
  wire add_cout, sub_cout;
  wire cmp_bigger, cmp_equal, cmp_smallest;
  reg [7:0] result;
  
  
  adder A1 ( .Sum(add_X), .Cout(add_cout), .A(A), .B(B) );
  subtractor S1 ( .A(A), .B(B), .Diff(sub_X), .Cout(sub_cout));
  multiplier M1 ( .A(A), .B(B), .Mult(mult_X));
  divider8bits D1 (.dividend(A), .divisor(B), .quo(div_quo), .rem(div_rem));
  shiftLeft SL1 (.A(A), .shift(B[2:0]), .X(shift_left_X));  
  shiftRight SR1 (.A(A), .shift(B[2:0]), .X(shift_right_X));
  Comparator CMP1 (.A(A), .B(B), .bigger(cmp_bigger), .equal(cmp_equal), .smallest(cmp_smallest));

  
  always @(*) begin
    
  
    result = 8'b00000000;
    Flags = 8'b00000000;
    case (Selector)
      8'b00000001: begin // Operação de Soma;
        result = add_X;
        Flags[0] = ( result == 0 ) ? 1:0 ;
        Flags[1] = add_cout;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
        Flags[4] = 0;
        Flags[5] = 0;
        Flags[6] = ((A[7] == B[7]) && (A[7] != result[7]));
      end
      8'b00000010: begin // Operação de Subtração
        result = sub_X;
        Flags[0] = ( result == 0 ) ? 1:0 ;
        Flags[1] = sub_cout;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
        Flags[4] = 0;
        Flags[5] = 0;
        Flags[6] = ((A[7] != B[7]) && (A[7] == result[7]));
      end
      8'b00000011: begin // Operação de Multiplicação
        result = mult_X[7:0];
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[1] = (mult_X[15:8] != 0) ? 1 : 0;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
        Flags[4] = 0;
        Flags[5] = 0;
        Flags[6] = (mult_X[15:8] != 0) ? 1 : 0; 
      end

      8'b00000100: begin // Operação de Divisão
        result = div_quo;
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[1] = 0;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
        Flags[4] = 0;
        Flags[5] = 0;
        Flags[6] = 0;
      end
      8'b00000101: begin // Resto da Divisão
        result = div_rem;
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[1] = 0;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
        Flags[4] = 0;
        Flags[5] = 0;
        Flags[6] = 0;
      end
      8'b00000110: begin // Operação AND
        result = A & B;
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
      end
      8'b00000111: begin // Operação OR
        result = A | B;
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
      end
      8'b00001000: begin // Operação XOR
        result = A ^ B; 
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
      end
      8'b00001001: begin // Operação NAND
        result = ~(A & B); 
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
      end
      8'b00001010: begin // Operação NOR
        result = ~(A | B);
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
      end
      8'b00001011: begin // Operação XNOR
        result = ~(A ^ B); 
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
      end
      8'b00001100: begin // Operação NOT
        result = ~A;
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[2] = result[7];
        Flags[3] = ~^(result);
      end
       8'b00001101: begin // Deslocamento de bit a esquerda
        result = shift_left_X; 
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[1] = A[7];
        Flags[2] = result[7];
        Flags[3] = ~^(result);
      end
      8'b00001110: begin // Deslocamento de bit a direita
        result = shift_right_X; 
        Flags[0] = ( result == 0 ) ? 1 : 0 ;
        Flags[1] = A[0];
        Flags[2] = result[7];
        Flags[3] = ~^(result);
      end
       8'b00001111: begin // Comparador de Bits
        result[0] = cmp_equal;   
        result[1] = cmp_bigger; 
        result[2] = cmp_smallest; 
        Flags[0] = cmp_equal;   
        Flags[1] = cmp_bigger;
        Flags[2] = cmp_smallest;
      end
      default: begin
        result = 8'b00000000;
    	Flags = 8'b00000000;
      end
    endcase
   
    X = result;
   
    

  end
endmodule  