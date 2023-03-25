module cla_4bit 
#(parameter n = 4)
(
	input [n - 1: 0] a, b,
	input cin, add_sub_control,
	
	output [n - 1: 0] c,
	output [n - 1: 0] sum
);

	wire [n - 1: 0] b_xor;
	wire [n - 1: 0] p, g;
	
	assign b_xor[0] = b[0] ^ add_sub_control;
	assign b_xor[1] = b[1] ^ add_sub_control;
	assign b_xor[2] = b[2] ^ add_sub_control;
	assign b_xor[3] = b[3] ^ add_sub_control;
		
	full_adder FA0(.a(a[0]), .b(b_xor[0]), .p(p[0]), .g(g[0]));		
	assign c[0] = g[0] | (p[0] & cin);
	
		
	full_adder FA1(.a(a[1]), .b(b_xor[1]), .p(p[1]), .g(g[1]));
	assign c[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
	
	
	full_adder FA2(.a(a[2]), .b(b_xor[2]), .p(p[2]), .g(g[2]));
	assign c[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
	
	
	full_adder FA3(.a(a[3]), .b(b_xor[3]), .p(p[3]), .g(g[3]));
	assign c[3] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) |  (p[3] & p[2] & p[1] & p[0] & cin);
	
	assign sum[0] = p[0] ^ cin;
	assign sum[1] = p[1] ^ c[0];
	assign sum[2] = p[2] ^ c[1];
	assign sum[3] = p[3] ^ c[2];
	
endmodule
