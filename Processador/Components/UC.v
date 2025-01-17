module UC (
    input clock, reset,
    input [31:0] IR,
    output reg ir_load, reg_load_a, reg_load_b, reg_load_c,
    output reg [7:0] alu_op
);
    reg [7:0] current_state, next_state;

    parameter START = 8'd0, FETCH = 8'd1, DECODE = 8'd2,
              ADD = 8'd3, SUB = 8'd4, MUL = 8'd5, DIV = 8'd6, MOD = 8'd7,
              AND = 8'd8, OR = 8'd9, XOR = 8'd10, NOT = 8'd11,
              NAND = 8'd12, NOR = 8'd13, XNOR = 8'd14,
              MOV = 8'd15, MOV_A = 8'd16, MOV_B = 8'd17,
              CMP = 8'd18, JMP = 8'd19, CALL = 8'd20, 
              SHIFT_LEFT = 8'd21, SHIFT_RIGHT = 8'd22,
              RET = 8'd23, GOTO = 8'd24, JZ = 8'd25, JNZ = 8'd26;

    always @(posedge clock or negedge reset) begin
        if (!reset)
            current_state <= START;
        else
            current_state <= next_state;
    end

   
    always @(current_state, IR) begin
        case (current_state)
            START: next_state = FETCH;
            FETCH: next_state = DECODE;

            DECODE:
                case (IR[31:23])
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
                    8'b10000000: next_state = MOV;
                    8'b10000001: next_state = JMP;
                    8'b10000010: next_state = CALL;
                    8'b10000011: next_state = RET;
                    8'b10000100: next_state = GOTO;
                    8'b10000101: next_state = JZ;
                    8'b10000111: next_state = JNZ;
                    default: next_state = START;
                endcase

            MOV: if(IR[22:21] == 2'b00) next_state = MOV_A;
                 else if (IR[22:21] == 2'b01) next_state = MOV_B;

            
            default: next_state = FETCH;
        endcase
    end

 
    always @(current_state) begin
        ir_load = 0;
        reg_load_a = 0;
        reg_load_b = 0;
        reg_load_c = 0;
        alu_op = 8'b0;

        case (current_state)
            FETCH: ir_load = 1;

            ADD, SUB, MUL, DIV, MOD, AND, OR, XOR, NAND, NOR, XNOR, CMP, SHIFT_LEFT, SHIFT_RIGHT: begin
                reg_load_a = 1;  
                reg_load_b = 1; 
                case (current_state)
                    ADD: alu_op = 8'b00000001;
                    SUB: alu_op = 8'b00000010;
                    MUL: alu_op = 8'b00000011;
                    DIV: alu_op = 8'b00000100;
                    MOD: alu_op = 8'b00000101;

                    AND: alu_op = 8'b00000110;
                    OR: alu_op = 8'b00000111;
                    XOR: alu_op = 8'b00001000;
                    NOT: alu_op = 8'b00001100;
                    NAND: alu_op = 8'b00001001;
                    NOR: alu_op = 8'b00001010;
                    XNOR: alu_op = 8'b00001011;

                    CMP: alu_op = 8'b00001111;
                    SHIFT_LEFT: alu_op = 8'b00001101;
                    SHIFT_RIGHT: alu_op = 8'b00001110;
                endcase
            end

            MOV_A: begin
                reg_load_a = 1;
                alu_op = 8'b10000000;
            end

            MOV_B: begin 
                reg_load_b = 1;
                alu_op = 8'b10000000;
            end
        endcase
    end
endmodule
