module shifter (input wire [7:0]A, input wire [2:0]shift,
                input wire dirc, output wire [7:0]X);
  assign X = (dirc == 1'b0) ? (A << shift):(A >> shift);
endmodule