module ImmGen(instruction, output_data);

	input [31:0] instruction;
	output reg [63:0] output_data;

	always@(instruction)
    begin 
        output_data <= $signed(instruction);
    end
    endmodule

endmodule