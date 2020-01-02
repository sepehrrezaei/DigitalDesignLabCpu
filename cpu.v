module cpu();
wire clk ,MemRead,MemWrite,ALUSrc, MemtoReg, RegWrite,Branch, ALUOp1, ALUOp0;
wire [63:0] Databus1,Write_data,Read_data, Databus2, DataWriteRegister,multi1Out,pcout,RD_Address,outImmGen,aluOut,OutShift;
wire [3:0] operation_code;
wire [63:0] pcOld = 64'b0;
wire [31:0] Instruction = 32'b0;
integer write=1,reset=0;

assign Instruction = 32'b0;
assign pcOld = 64'b1;



clock clock1(.clk(clk));

pc pc1(.clk(clk), .data_input(pcOld) , .pcout(pcout) , .reset(reset) ,.write(write));

adder adder1(.clk(clk),.input_data_1(pcOld),.input_data_2(64'b100),.output_data(pcOld));

shift shift1(.input_data(outImmGen), .output_data(OutShift));

adder adder2(.clk(clk),.input_data_1(OutShift),.input_data_2(pcout),.output_data(pcOld));

multiplexer multiplexer1(.input_data_1(pcOld), .input_data_2(OutShift), .input_select(Branch), .output_data(pcOld));

insMem insMem1(.clk(clk),.RD_Address(pcout),.data_out(Instruction));

control control1(.instruction_part(Instruction[6:0]),.ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite),.MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp1(ALUOp1), .ALUOp0(ALUOp0));

Reg register_file1(.clk(clk), .RegWrite(RegWrite), 
		.Read_register1(Instruction[19:15]), .Read_register2(Instruction[24:20]), .Write_register(Instruction[11:7]),
		.Write_data(DataWriteRegister), .Read_data1(Databus1), .Read_data2(Databus2));

ImmGen immGen1(.instruction(Instruction),.output_data(outImmGen));

multiplexer multiplexer2(.input_data_1(Databus2), .input_data_2(outImmGen), .input_select(ALUSrc), .output_data(multi1Out));

aluCon aluCon1(.ALUOp1(ALUOp1), .ALUOp0(ALUOp0), .instruction_part({Instruction[31:25],Instruction[14:12]}), .operation_code(operation_code));

ALU ALU1(.in1(Databus1), .in2(multi1Out), .control(operation_code),.out(aluOut));

memory memory1( .clk(clk), .Address(aluOut), .Write_data(Databus2), .Read_data(Read_data), .MemRead(MemRead), .MemWrite(MemWrite));

multiplexer multiplexer3(.input_data_1(Read_data), .input_data_2(aluOut), .input_select(MemtoReg), .output_data(DataWriteRegister));

endmodule;
