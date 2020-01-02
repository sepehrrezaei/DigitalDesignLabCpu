module multiplexer (input_data_1, input_data_2, input_select, output_data);
    parameter n = 64;
	input input_select;
	input [n - 1 : 0] input_data_1, input_data_2;
	output[n - 1 : 0] output_data;

	assign output_data = input_select ? input_data_1 : input_data_2;

endmodule