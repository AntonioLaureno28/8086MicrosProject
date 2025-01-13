`include "adder.v"
`include "fullsubtractor.v"
`include "shifter.v"

module ALU ( input wire [7:0]A, input wire [7:0]B, input wire [3:0]Selector,
            output reg [7:0]X, output wire Cout, output wire Oflow );
  wire [7:0] add_X, sub_X, shift_left_X, shift_right_X;
  wire add_cout, sub_cout;
  wire add_oflow, sub_oflow;
  
  adder A1 ( .Sum(add_X), .Cout(add_cout), Oflow(add_oflow), .A(A), .B(B) );
  subtractor S1 ( .A(A), .B(B), .Diff(sub_X), .Cout(sub_cout), .Oflow(sub_oflow) );
  
  always @(*) begin
    case (Selector)
      4'b0000: result = add_X;
      4'b0001: result = sub_X;
      4'b0010: result = A and B;
      4'b0011: result = A or B;
      4'b0100: result = A xor B;
      4'b0101: result = not A;
    endcase
  end
  
  if (Selector == 4'b0000){
    Cout = add_cout;
  }else if (Selector == 4'b0001){
    Cout = sub_cout;
  }else{
    Cout = 1'b0;
  } 
   
  
  if (Selector == 4'b0000){
    Oflow = add_oflow;
  }else if (Selector == 4'b0001){
    Oflow = sub_oflow;
  }else{
    Oflow = 1'b0;
  }
endmodule