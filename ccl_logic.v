module condition_code_logic(
	input [7: 0] sum,
	input c8, c7,
	
	output [3: 0] in_ccout
);

	assign in_ccout[0] = c8 ^ c7;
	assign in_ccout[1] = c8;
	assign in_ccout[2] = sum[7];
	assign in_ccout[3] = ~(sum[7] | sum[6] | sum[5] | sum[4] | sum[3] | sum[2] | sum[1] | sum[0]);

endmodule

