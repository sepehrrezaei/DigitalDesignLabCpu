module ALU(in1, in2, control);
	input [63:0] in1, in2;
	input [3:0] ALUCtl;
	output reg [63:0] out;
	always @(*)
		case (control)
			4'b0000: out <= in1 & in2;
			4'b0001: out <= in1 | in2;
			4'b0010: out <= in1 + in2;
			4'b0110: out <= in1 - in2;
			default: out <= 64'h00000000;
		endcase
endmodule