module keypad_input
#(parameter DIGITS = 4)
(
	input clk,
	input reset,
	input [3: 0] row,
	
	output [3: 0] col,
	output reg valid,
	output [7: 0] the_output
);

	wire [7: 0] binarySM;
	reg [7: 0] inp_last_module;
	wire [3: 0] value;
	wire [(DIGITS * 4) - 1: 0] out;
	wire trig;

	keypad_base kp_base(.clk(clk), .row(row), .col(col), .value(value), .valid(trig));
	
	shift_reg #(.COUNT(DIGITS)) shft_reg(.trig(trig), .in(value), .out(out), .reset(reset));
	
	always @(out)
		if(out[11: 0] > 12'd295)
			valid = 1'b1;
		else
			valid = 1'b0;
	
	BCD2BinarySM bcd_to_bin(.BCD(out), .binarySM(binarySM));
	
	always @(valid)
		if(valid)
			inp_last_module = 8'b0;
		else
			inp_last_module = binarySM;
	
	twos_comp_to_sign_mag sm_to_two_comp(.the_input(inp_last_module), .the_output(the_output));
	
endmodule
