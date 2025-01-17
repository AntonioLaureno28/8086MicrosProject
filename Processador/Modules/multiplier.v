module multiplier (
    input [7:0] A,      
    input [7:0] B,     
  	output reg [15:0] Mult 
);

    integer i; 

    always @(*) begin
        Mult = 16'b0; 
        for (i = 0; i < 8; i = i + 1) begin
            if (B[i] & 1'b1) 
                Mult = Mult + (A << i);
        end
    end

endmodule