module clock_divider
#(parameter N = 1000, parameter M = 10)
(
	input clk, clear,
	
	output reg [M - 1: 0] COUNT,
	output reg OUT
);

	always @(negedge clk, negedge clear)
		if(clear == 1'b0)
			COUNT <= 0;
		else
			begin
				if(COUNT == N - 2'd2)
					begin
						OUT <= 1'b1;
						COUNT <= N - 1'd1;
					end
				else if(COUNT == N - 1'd1)
					begin
						OUT <= 1'b0;
						COUNT <= 0;
					end
				else
					begin
						OUT <= 1'b0;
						COUNT <= COUNT + 1'b1;
					end		
			end

endmodule
