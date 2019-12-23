module memory( clk, Address, Write_data, Read_data, MemRead, MemWrite);
	input  clk;
	input [63:0] Address, Write_data;
	input MemRead, MemWrite;
	output [63:0] Read_data;
	
	
	reg [63:0] data[99: 0];

	assign Read_data = data[Address];
	
	always @(posedge clk)
		if (MemWrite)
			data[Address] <= Write_data;
			
endmodule;