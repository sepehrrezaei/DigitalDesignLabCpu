module aluCon (ALUOp0, ALUOp1, instruction_part, operation_code);

    input ALUOp0, ALUOp1;
    input [9:0] instruction_part;
    output reg [3:0] operation_code;

    wire [1:0] ALUOp = {ALUOp1, ALUOp0};

    always @ (ALUOp0, ALUOp1, instruction_part) begin
        casex(ALUOp)
            2'b00: operation_code = 4'b0010;
            2'bx1: operation_code = 4'b0111;
            2'b1x: begin
                casex(instruction_part)
                    10'b00000000000: operation_code = 4'b0010;
                    10'b01000000000: operation_code = 4'b0110;
                    10'b00000000111: operation_code = 4'b0000;
                    10'b00000000110: operation_code = 4'b0001;
                    default: operation_code = 4'bz;
                
                endcase
            end
            default: operation_code = 4'bz;

        endcase

    end

endmodule