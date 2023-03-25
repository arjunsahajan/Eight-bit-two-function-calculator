module full_adder (
	input a, b,
	
	output p, g
);

	assign p = a ^ b;
	assign g = a & b;

endmodule
