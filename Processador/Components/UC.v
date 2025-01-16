module UC (
    input clock, reset,
    input [7:0] IR,
    output reg ir_load, reg_load
    output reg alu_op
);
    reg[7:0] current_state, next_state;
    parameter START = 8'd0,
              FETCH = 8'd1,
              DECODE = 8'd2,
              LOAD = 8'd3, STORE = 8'd4,
              ADD = 8'd5, SUB = 8'd6, MULT = 8'd7, DIV = 8'd8,
              MOD = 8'd9,
              CMP = 8'd10,
              AND = 8'd11, OR = 8'd12, NOT = 8'd13, XOR = 8'd14,
              NAND = 8'd15, NOR = 8'd16, XNOR = 8'd17,
              MOV = 8'd18,
              SHIFT_LEFT = 8'd19, SHIFT_RIGHT = 8'd20,
              

     always @ (posedge clock or negedge reset) begin: state_memory
        if (!reset)
            current_state <= START;
        else
            current_state <= next_state;
     end

     always @ (current_state, IR) begin: logica_next_state
        case(current_state)
            START: next_state = FETCH;
            FETCH: next_state = DECODE;

            DECODE: if (IR == LOAD) next_state = LOAD;
                    else if (IR == STORE) next_state = STORE;
                    else if (IR == ADD) next_state = ADD;
                    else if (IR == SUB) next_state = SUB;
                    else if (IR == MULT) next_state = MULT;
                    else if (IR == DIV) next_state = DIV;
                    else if (IR == MOD) next_state = MOD;
                    else if (IR == CMP) next_state = CMP;
                    else if (IR == AND) next_state = AND;
                    else if (IR == OR) next_state = OR;
                    else if (IR == NOT) next_state = NOT;
                    else if (IR == XOR) next_state = XOR;
                    else if (IR == NAND) next_state = NAND;
                    else if (IR == NOR) next_state = NOR;
                    else if (IR == XNOR) next_state = XNOR;
                    else if (IR == MOV) next_state = MOV;
                    else if (IR == SHIFT_LEFT) next_state = SHIFT_LEFT;
                    else if (IR == SHIFT_RIGHT) next_state = SHIFT_RIGHT;
                
            
            LOAD: next_state = FETCH; 
            STORE: next_state = FETCH;
            ADD: next_state = FETCH;
            SUB: next_state = FETCH;
            MULT: next_state = FETCH;
            DIV: next_state = FETCH;
            MOD: next_state = FETCH;
            CMP: next_state = FETCH;
            AND: next_state = FETCH;
            OR: next_state = FETCH;
            NOT: next_state = FETCH;
            XOR: next_state = FETCH;
            NAND: next_state = FETCH;
            NOR: next_state = FETCH;
            XNOR: next_state = FETCH;
            SHIFT_LEFT: next_state = FETCH;
            SHIFT_RIGHT: next_state = FETCH;
            MOV: next_state = FETCH;

            default: next_state = START;


        endcase
     end

    always @(current_state) begin: logica_saida
        case (current_state)
            START: begin
                ir_load = 0;
                reg_load = 0;
                alu_op = 8'b0;
            end

            FETCH: begin
                ir_load = 1;
                reg_load = 0; 
                alu_op = 8'b0;
            end

            DECODE: begin
                ir_load = 0;
                reg_load = 0;
                alu_op = 8'b0;
            end

            LOAD: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = 8'b0;
            end

            STORE: begin
                ir_load = 0;
                reg_load = 0;
                alu_op = 8'b0;
            end

            ADD: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = 8'b00000001; 
            end

            SUB: begin
                ir_load = 0;
                reg_load = 1;
                alu_op =  8'b00000010; 
            end

            MULT: begin
                ir_load = 0;
                reg_load = 1;
                alu_op =  8'b00000011; 
            end

            DIV: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = //; 
            end

            MOD: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = //; 
            end

            CMP: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = //; 
            end

            AND: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = 8'b00000100; 
            end

            OR: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = 8'b00000101; 
            end

            XOR: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = 8'b00000110; 
            end

            NOT: begin
                ir_load = 0;
                reg_load = 1;
                alu_op =  8'b00000111; 
            end

            NAND: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = 8'b00001000; 
            end

            NOR: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = 8'b00001001; 
            end

            XNOR: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = 8'b00001010; 
            end

            MOV: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = 8'b0;
                
            end

            SHIFT_LEFT: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = //; 
            end

            SHIFT_RIGHT: begin
                ir_load = 0;
                reg_load = 1;
                alu_op = //; 
            end


        endcase
     end

endmodule