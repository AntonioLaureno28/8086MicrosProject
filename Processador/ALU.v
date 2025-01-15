`include "adder.v"
`include "fullsubtractor.v"
`include "multiplier.v"
`include "shifter.v"

module ALU ( input wire [7:0]A, input wire [7:0]B, input wire [7:0]Selector,
            output reg [7:0]X, output reg [7:0]Flags );
  wire [7:0] add_X, sub_X, shift_left_X, shift_right_X,
  wire [15:0] mult_X;
  wire add_cout, sub_cout;
  reg [7:0] result;
  
  adder A1 ( .Sum(add_X), .Cout(add_cout), .A(A), .B(B) );
  subtractor S1 ( .A(A), .B(B), .Diff(sub_X), .Cout(sub_cout));
  multiplier M1 ( .A(A), .B(B), .Mult(mult_X));
  
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
        result = mult_X;
      	Flags[0] = ( result == 0 ) ? 1 : 0 ;
      	Flags[1] = (result[15:8] != 0) ? 1 : 0;
      	Flags[2] = result[7];
      	Flags[3] = ~^(result);
      	Flags[4] = 0;
      	Flags[5] = 0;
      	Flags[6] = (result[15:8] != 0) ? 1 : 0;
      end
      8'b00000100: begin // Operação AND
        result = A & B;
      	Flags[0] = ( result == 0 ) ? 1 : 0 ;
      	Flags[2] = result[7];
      	Flags[3] = ~^(result);
      end
      8'b00000101: begin // Operação OR
        result = A | B;
      	Flags[0] = ( result == 0 ) ? 1 : 0 ;
      	Flags[2] = result[7];
      	Flags[3] = ~^(result);
      end
      8'b00000110: begin // Operação XOR
        result = A ^ B; 
      	Flags[0] = ( result == 0 ) ? 1 : 0 ;
      	Flags[2] = result[7];
      	Flags[3] = ~^(result);
      end
      8'b00000111: begin // Operação NOT
        result = ~A;
      	Flags[0] = ( result == 0 ) ? 1 : 0 ;
      	Flags[2] = result[7];
      	Flags[3] = ~^(result);
      end
      8'b00001000: begin // Operação NAND
        result = ~(A & B); 
      	Flags[0] = ( result == 0 ) ? 1 : 0 ;
      	Flags[2] = result[7];
      	Flags[3] = ~^(result);
      end
      8'b00001001: begin // Operação NOR
        result = ~(A | B);
      	Flags[0] = ( result == 0 ) ? 1 : 0 ;
      	Flags[2] = result[7];
      	Flags[3] = ~^(result);
      end
      8'b00001010: begin // Operação XNOR
        result = ~(A ^ B); 
      	Flags[0] = ( result == 0 ) ? 1 : 0 ;
      	Flags[2] = result[7];
      	Flags[3] = ~^(result);
      end
      
      default: begin
        result = 8'b00000000;
    	Flags = 8'b00000000;
      end
    endcase
    
    X = result;
    
  end
endmodule  