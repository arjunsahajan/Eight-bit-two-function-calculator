module nbit_counter
#(parameter N = 8)
(
	input clk,
	input reset,
	output reg [N - 1: 0] count_val
);

	always @(posedge clk, negedge reset)
		if(reset == 1'b0)
			count_val <= 0;
		else
			count_val <= count_val + 1'b1;

endmodule
