module shift(input_data, output_data);
    parameter n = 64;
    input [n - 1 : 0] input_data;
    output[n - 1 : 0] output_data;

    assign output_data = input_data << 1;
    
endmodule