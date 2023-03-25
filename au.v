module au
#(parameter n = 8)
(
	input clk,
	input inA,
	input inB,
	input clear,
	input out,
	input add_sub_control,
	input [n - 1: 0] the_input,
	
	output [n - 5: 0] ccout,
	output [n - 1: 0] Rout
);

	wire [n - 1: 0] c, sum, Aout, Bout;
	wire [n - 5: 0] in_ccout;
	
	wire [11: 0] valid_sum;
	
	wire [3: 0] ONES, TENS, ONES_1, TENS_1;
	wire [1: 0] HUNDREDS, HUNDREDS_1;
	
	register reg_A(.clk(clk), .load(inA), .clear(clear), .D(the_input), .Q(Aout));
	
	register reg_B(.clk(clk), .load(inB), .clear(clear), .D(the_input), .Q(Bout));
	
	cla_4bit CLA1(.a(Aout[n - 5: 0]), .b(Bout[n - 5: 0]), .cin(add_sub_control), .add_sub_control(add_sub_control), .c(c[n - 5: 0]), .sum(sum[n - 5: 0]));
	
	cla_4bit CLA2(.a(Aout[n - 1: n - 4]), .b(Bout[n - 1: n - 4]), .cin(c[n - 5]), .add_sub_control(add_sub_control), .c(c[n - 1: n - 4]), .sum(sum[n - 1: n - 4]));

	condition_code_logic CCL(.sum(sum), .c7(c[n - 2]), .c8(c[n - 1]), .in_ccout(in_ccout));
	
	register #(.N(4)) CC(.clk(clk), .load(out), .clear(clear), .D(in_ccout), .Q(ccout));
	
	register reg_R(.clk(clk), .load(out), .clear(clear), .D(sum), .Q(Rout));
	
endmodule
