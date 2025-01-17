/*
module remainder8bits(dividend,divisor,rem);
  
  input [7:0] dividend;
  input [7:0] divisor;
  output [7:0] rem;
  
  reg [7:0] rem = 0;
  reg [7:0] a1, b1;
  reg [7:0] p1;
  integer i;
  
  always@ (dividend or divisor) begin
    a1 = dividend;
    b1 = divisor;
    p1 = 0;
    
    if (a1[7]==1)
    a1=0-a1;
    if (b1[7]==1)
    b1=0-b1;
    if ((b1[7]==1) && (a1[7]==1)) begin
    b1=0-b1;
    a1=0-a1;
  	end
    
  for (i=0; i<8; i++) begin
      p1 = {p1[6:0], a1[7]};
      a1[7:1] = a1[6:0];
      p1 = p1-b1;
      if (p1[7] == 1) begin
        a1[0] = 0;
        p1=p1+b1;
      	end
      else
        a1[0]=1;
    end
    
    if ((dividend[7]==1) && (divisor[7]==0)) begin
      rem = 0-p1;
    end
      
    else if ((dividend[7]==0) && (divisor[7]==1)) begin
      rem = 0;
    end
    
    else if ((dividend[7]==1) && (divisor[7]==1)) begin
      rem = 0-p1;
    end
    
    else begin
    rem = p1;
    end
  end
endmodule
*/

module division;
  reg [7:0] dividend;
  reg [7:0] divisor;
  wire [7:0] rem;

  // Instância do módulo remainder8bits
  remainder8bits uut (
    .dividend(dividend),
    .divisor(divisor),
    .rem(rem)
  );
  
  initial begin
        
        dividend = 8'b01001011; // 75
        divisor = 8'b00011001; // 25
        #10;
        $display("Dividend: %b, Divisor: %b, Remainder: %b", dividend, divisor, rem); 

        dividend = 8'b00001111; // 15
        divisor = 8'b00000100; // 4
        #10;
        $display("Dividend: %b, Divisor: %b, Remainder: %b", dividend, divisor, rem);

        dividend = 8'b11110001; // -15 (como complemento de 2)
        divisor = 8'b00000100; // 4
        #10;
        $display("Dividend: %b, Divisor: %b, Remainder: %b", dividend, divisor, rem); 
    end
endmodule