module twos_comp_to_sign_mag 
#(parameter n = 8)
(
	input [n - 1: 0] the_input,
	
	output [n - 1: 0] the_output
);

	wire [n - 1: 0] the_input_xor;
	wire [n - 3: 0] sec_input;
	
	assign the_input_xor[0] = the_input[0] ^ the_input[7];
	assign the_input_xor[1] = the_input[1] ^ the_input[7];
	assign the_input_xor[2] = the_input[2] ^ the_input[7];
	assign the_input_xor[3] = the_input[3] ^ the_input[7];
	assign the_input_xor[4] = the_input[4] ^ the_input[7];
	assign the_input_xor[5] = the_input[5] ^ the_input[7];
	assign the_input_xor[6] = the_input[6] ^ the_input[7];
	
	HalfAdder HA0(.a(the_input_xor[0]), .b(the_input[7]), .sum(the_output[0]), .cout(sec_input[0]));
	HalfAdder HA1(.a(the_input_xor[1]), .b(sec_input[0]), .sum(the_output[1]), .cout(sec_input[1]));
	HalfAdder HA2(.a(the_input_xor[2]), .b(sec_input[1]), .sum(the_output[2]), .cout(sec_input[2]));
	HalfAdder HA3(.a(the_input_xor[3]), .b(sec_input[2]), .sum(the_output[3]), .cout(sec_input[3]));
	HalfAdder HA4(.a(the_input_xor[4]), .b(sec_input[3]), .sum(the_output[4]), .cout(sec_input[4]));
	HalfAdder HA5(.a(the_input_xor[5]), .b(sec_input[4]), .sum(the_output[5]), .cout(sec_input[5]));
	HalfAdder HA6(.a(the_input_xor[6]), .b(sec_input[5]), .sum(the_output[6]), .cout());
	
	HalfAdder HA7(.a(the_input[7]), .b(0), .sum(the_output[7]), .cout());

endmodule
