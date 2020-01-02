module Reg(clk, RegWrite, Read_register1, Read_register2, Write_register, Write_data, Read_data1, Read_data2);
input clk;
parameter n=63;

integer i =0;
reg [n:0]registers[31:0];
input RegWrite;
input [4:0] Read_register1, Read_register2, Write_register;
input [n:0] Write_data;
output [n:0] Read_data1, Read_data2;


/*
initial begin
for(i=0;i<n;i=i+1)
   registers[i] <=2'b01;
end
*/

assign Read_data1 = registers[Read_register1];
assign Read_data2 = registers[Read_register2];


always@(posedge clk)
  begin
    if (RegWrite)
	registers[Write_register] <= Write_data;
  end



endmodule;