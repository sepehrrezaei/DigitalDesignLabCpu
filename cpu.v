module cpu();
wire clk ,RD_Address,Instruction,pcout,Address,Write_data,Read_data,MemRead,MemWrite,input_data_1,input_data_2,input_select,output_data;
wire [31:0] Databus1, Databus2, Databus3;
wire [63:0] Instruction;
integer write=1,reset=0;

clock clock1(.clk(clk));
insMem insMem1(.clk(clk),.RD_Address(RD_Address),.data_out(Instruction));
pc pc1(.clk(clk), .data_out(data_out) , .pcout(pcout) , .reset(reset) ,.write(write));

Reg register_file1(.clk(clk), .RegWrite(RegWrite), 
		.Read_register1(Instruction[19:15]), .Read_register2(Instruction[24:20]), .Write_register(Instruction[11:7]),
		.Write_data(Databus3), .Read_data1(Databus1), .Read_data2(Databus2));

	
multiplexer (.input_data_1(input_data_1), .input_data_2(input_data_2), .input_select(input_select), .output_data(output_data));

memory memory1( .clk(clk), .Address(Address), .Write_data(Write_data), .Read_data(Read_data), .MemRead(MemRead), .MemWrite(MemWrite))

endmodule;
