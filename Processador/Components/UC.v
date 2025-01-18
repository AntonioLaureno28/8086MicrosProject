module UC (
    input clock, reset,
  	input [7:0] IR,
    output reg ir_load, reg_load_a, reg_load_b, reg_load_c, pc_load,
    output reg [7:0] alu_op
);
    reg [7:0] current_state, next_state;

    parameter START = 8'd0, FETCH = 8'd1, DECODE = 8'd2,
              ADD = 8'd3, SUB = 8'd4, MUL = 8'd5, DIV = 8'd6, MOD = 8'd7,
              AND = 8'd8, OR = 8'd9, XOR = 8'd10, NOT = 8'd11,
              NAND = 8'd12, NOR = 8'd13, XNOR = 8'd14,
              CMP = 8'd15, SHIFT_LEFT = 8'd16, SHIFT_RIGHT = 8'd17;
              

  	always @(posedge clock or posedge reset) begin
      	//$display("UC: IR- %b   ALUOP- %b", IR, alu_op);
        if (reset)
            current_state <= START;
        else
            current_state <= next_state;
      		//$display("UC: State Transition - Current State: %d, Next State: %d, IR: %b, alu: %b", current_state, next_state, IR, alu_op);
      $display("UC: State Transition - Current State: %d, pc_load: %b", current_state, pc_load);
    end

   
    always @(current_state, IR) begin
        case (current_state)
            START: next_state = FETCH;
            FETCH: next_state = DECODE;

            DECODE:
                case (IR)
                    8'b00000001: next_state = ADD;
                    8'b00000010: next_state = SUB;
                    8'b00000011: next_state = MUL;
                    8'b00000100: next_state = DIV;
                    8'b00000101: next_state = MOD;
                    8'b01110101: next_state = AND;
                    8'b01110110: next_state = OR;
                    8'b01110111: next_state = XOR;
                    8'b01111000: next_state = NOT;
                    8'b01111001: next_state = NAND;
                    8'b01111010: next_state = NOR;
                    8'b01111011: next_state = XNOR;
                    8'b00111100: next_state = SHIFT_LEFT;
                    8'b00111101: next_state = SHIFT_RIGHT;
                    8'b00011111: next_state = CMP;
                    default: next_state = START;
                endcase

            
            default: next_state = FETCH;
        endcase
    end

 
    always @(current_state) begin
       	ir_load = 0;
        reg_load_a = 0;
        reg_load_b = 0;
        reg_load_c = 0;
      	pc_load = 0;
        alu_op = 8'b0;

        case (current_state)
            FETCH: begin 
              ir_load = 1;
              pc_load = 0;
            end
          
          	DECODE: begin
              reg_load_a = 1;  
              reg_load_b = 1;
            end 

            ADD, SUB, MUL, DIV, MOD, AND, OR, XOR, NAND, NOR, XNOR, CMP, SHIFT_LEFT, SHIFT_RIGHT: begin
              	pc_load = 1;
              	reg_load_c = 1;
                case (current_state)
                    ADD: alu_op = 8'b00000001;
                    SUB: alu_op = 8'b00000010;
                    MUL: alu_op = 8'b00000011;
                    DIV: alu_op = 8'b00000100;
                    MOD: alu_op = 8'b00000101;

                    AND: alu_op = 8'b00000110;
                    OR: alu_op = 8'b00000111;
                    XOR: alu_op = 8'b00001000;
                    NAND: alu_op = 8'b00001001;
                    NOR: alu_op = 8'b00001010;
                    XNOR: alu_op = 8'b00001011;

                    CMP: alu_op = 8'b00001100;
                    SHIFT_LEFT: alu_op = 8'b00001101;
                    SHIFT_RIGHT: alu_op = 8'b00001110;
                endcase
            end

        endcase
    end
endmodule