module segmentRegisters ( input wire clk, input wire rst, input wire [1:0]Seg_selector, input wire [1:0]Seg_data, input Seg_write_enable,
                         output reg [7:0]CS, output reg [7:0]DS, output reg [7:0]SS, output reg [7:0]ES);
  
  
  always @(posedge clk or posedge rst) begin
    is (rst) begin
      CS <= 8'b0; 
      DS <= 8'b0; 
      SS <= 8'b0; 
      ES <= 8'b0;
    end else if (Seg_write_enable) begin 
      case (Seg_selector) 
        2'b00: CS <= Seg_data;
        2'b01: DS <= Seg_data;
        2'b10: SS <= Seg_data;
        2'b11: ES <= Seg_data;
      endcase
    end
  end
endmodule