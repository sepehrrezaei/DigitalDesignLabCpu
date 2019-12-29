module pc(  clk , data_input , pcout , reset ,write);
input clk , reset,write;
parameter n=63;
input [n:0] data_input ;
output  reg [n:0]  pcout;
always @(posedge clk)
begin
    if(reset)
        pcout = 0 ;
    else
       if (write)
          pcout = data_input ;
end
endmodule;