module shift_reg
#(parameter COUNT = 4, parameter WIDTH = 4)
(
	input trig, reset, dir,
	input [WIDTH - 1: 0] in,
	
	output reg [(COUNT * WIDTH) - 1: 0] out
);

	always @(posedge trig, negedge reset)
		begin
			if(~reset)
				out <= 0;
			else
				begin
					if(dir)
						begin
							out <= out >> WIDTH;
							out[(COUNT * WIDTH) - 1: ((COUNT * WIDTH) - 1) - WIDTH] <= in;
						end
						else
							begin
								out <= out << WIDTH;
								out[WIDTH - 1: 0] <= in;
							end
				end
		end

endmodule
