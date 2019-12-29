module cpu();
wire clk ,RD_Address,Instruction,pcout,Address,Write_data,Read_data,MemRead,MemWrite,input_data_1,input_data_2,input_select,instruction_part,ALUSrc, MemtoReg, RegWrite,Branch, ALUOp1, ALUOp0,operation_code,in1, in2, control,aluOut,outImmGen;
wire [63:0] Databus1, Databus2, DataWriteRegister,multi1Out;

wire [63:0] Instruction;
integer write=1,reset=0;
clock clock1(.clk(clk));

insMem insMem1(.clk(clk),.RD_Address(data_out),.data_out(Instruction));

pc pc1(.clk(clk), .data_out(data_out) , .pcout(pcout) , .reset(reset) ,.write(write));

Reg register_file1(.clk(clk), .RegWrite(RegWrite), 
		.Read_register1(Instruction[19:15]), .Read_register2(Instruction[24:20]), .Write_register(Instruction[11:7]),
		.Write_data(DataWriteRegister), .Read_data1(Databus1), .Read_data2(Databus2));

control control1(.instruction_part(Instruction[6:0]),.ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite),.MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp1(ALUOp1), .ALUOp0(ALUOp0));

ImmGen immGen1(.Instruction(Instruction),.output_data(outImmGen));

multiplexer multiplexer1(.input_data_1(Databus2), .input_data_2(outImmGen), .input_select(ALUSrc), .output_data(multi1Out));

memory memory1( .clk(clk), .Address(aluOut), .Write_data(Databus2), .Read_data(Read_data), .MemRead(MemRead), .MemWrite(MemWrite));

alu ALU1(.in1(Databus1), .in2(multi1Out), .control(operation_code),.out(aluOut));

aluCon aluCon1(.ALUOp1(ALUOp1), .ALUOp0(ALUOp0), .instruction_part({Instruction[31:25],Instruction[14:12]}}), .operation_code(operation_code));

multiplexer multiplexer2(.input_data_1(Read_data), .input_data_2(aluOut), .input_select(MemtoReg), .output_data(DataWriteRegister));

	
endmodule;
