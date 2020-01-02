module clock(clk);

output reg clk;

always
begin
    clk = 0; 
    #10 clk = ~clk;
    #10;
end


endmodule;