module calculator
(
	input clk,
	input clear,
	input add_sub_control,
	input enter,
	input [3: 0] row,
	input clear_screen,
	
	output [3: 0] col,
	output [6: 0] seg,
	output [3: 0] CAT,
	output [6: 0] seg_ones, seg_tens, seg_hun, seg_sign,
	output reg valid,
	output overflow
);

	wire [7: 0] inp_to_other_units;
	wire [7: 0] Rout;
	reg [7: 0] mux2x1_out;
	wire loadA, loadB, loadR, load_out_unit, sel;
	wire slow_clock;
	wire enter_out;

	reg [7: 0] inp_mux;
	wire inp_validity;
	wire [3: 0] ccout;

	keypad_input KPIN(.clk(clk), .reset(clear_screen), .row(row), .col(col), .valid(inp_validity), .the_output(inp_to_other_units));

	clock_div #(.DIV(100000)) control_unit_fsm_clk_div(.clk(clk), .clk_out(slow_clock));
	
	EdgeDetect ED(.in(enter), .clock(slow_clock), .out(enter_out));
	
	control_unit_fsm CUF(.reset(clear), .enter(enter_out), .loadA(loadA), .loadB(loadB), .loadR(loadR), .load_out_unit(load_out_unit), .sel(sel));
	
	au calc(.clk(slow_clock), .inA(loadA), .inB(loadB), .clear(clear), .out(loadR), .add_sub_control(add_sub_control), .the_input(inp_to_other_units), .ccout(ccout), .Rout(Rout));
	
	always @(inp_validity)
		if(inp_validity == 1'b1)
			valid = 1'b1;
		else
			valid = 1'b0;

	always @(valid)
		if(valid)
			inp_mux = 8'b0;
		else
			inp_mux = Rout;
	
	always @(sel)
		if(sel)
			mux2x1_out = inp_mux;
		else
			mux2x1_out = inp_to_other_units;
	
	output_unit OU(.the_input(mux2x1_out), .seg_ones(seg_ones), .seg_tens(seg_tens), .seg_hun(seg_hun), .seg_sign(seg_sign));
	
	out_unit_caller OUC(.the_input(mux2x1_out), .clk(clk), .reset(clear_screen), .load_out_unit(load_out_unit), .seg(seg), .CAT(CAT));
	
	assign overflow = ccout[0];
	
endmodule
