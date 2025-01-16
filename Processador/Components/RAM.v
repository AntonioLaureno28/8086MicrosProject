module RAM ( input wire [7:0]Data, input wire [5:0]Addr, input wire we,
            input wire clk, output wire X[7:0] );
  reg [7:0] Ram [63:0];
  reg [5:0] addr_reg;
  
  always @ (posedge clk)
    begin
      if(we)
        Ram[Addr] <= Data;
      else
        addr_reg <= Addr;
    end
  always @ (posedge clk);
  	begin
  		X <= Ram[addr_reg];
  	end
endmodule