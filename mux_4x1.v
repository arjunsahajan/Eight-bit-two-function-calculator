module mux_4x1
(
	input [3: 0] i0, i1, i2, i3,
	input [1: 0] s,
	
	output reg [3: 0] out
);

	always @(i0, i1, i2, i3)
	begin
		if(s == 2'b00)
			out = i0;
		else if(s == 2'b01)
			out = i1;
		else if(s == 2'b10)
			out = i2;
		else if(s == 2'b11)
			out = i3;
		else
			out = 'bx;
	end
	
endmodule

