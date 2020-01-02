module TestRegBank ();
wire clk;


clock clock1(.clk(clk));


wire [63:0] Databus1,Databus2;
reg [31:0] Instruction;
reg RegWrite ;
reg [63:0] DataWriteRegister;

Reg register_file1(.clk(clk), .RegWrite(RegWrite), 
		.Read_register1(Instruction[19:15]), .Read_register2(Instruction[24:20]), .Write_register(Instruction[11:7]),
		.Write_data(DataWriteRegister), .Read_data1(Databus1), .Read_data2(Databus2));

always
begin

Instruction[19:15] = 4'b00;
Instruction[24:20] = 4'b00;
Instruction[11:7] = 4'b00;
RegWrite = 1;
DataWriteRegister = 64'b101;

#50

Instruction[19:15] = 4'b00;

  	
end

endmodule;
