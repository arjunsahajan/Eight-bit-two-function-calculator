module out_unit_caller
(	
	input [7: 0] the_input,
	input clk, reset, load_out_unit,

	output [6: 0] seg,
	output [3: 0] CAT
);

	wire clk1, clk2, clk3, out_clk;
	wire [1: 0] SEL;
	wire [7: 0] tcsm_out;
	wire [3: 0] ONES, TENS;
	wire [1: 0] HUNDREDS;
	wire [3: 0] ONES_out, TENS_out;
	wire [3: 0] HUNDREDS_out;
	wire [3: 0] NOPE_out;
	wire [3: 0] mux_out;
	
	reg sign_bit;
	reg [3: 0] det_sign;

	clock_div #(.DIV(100000)) fsm_clk_div(.clk(clk), .clk_out(clk2));
	
	clock_div #(.DIV(100)) load_seg_clk_div(.clk(clk), .clk_out(out_clk)); // 5Hz
	
	twos_comp_to_sign_mag TCSM(.the_input(the_input), .the_output(tcsm_out));
	
	fsm f(.slow_clock(clk2), .reset(reset), .SEL(SEL), .CAT(CAT));	
	
	always @(tcsm_out)
		if(tcsm_out[7] == 1'b1 && tcsm_out[6: 0] == 7'b0000000)
			sign_bit = 1'b1;
		else
			sign_bit = 1'b0;
		
	always @(tcsm_out)
		if(tcsm_out[7] == 1'b1)
			det_sign = 4'b1111;
		else
			det_sign = 4'b1110;
	
	b_to_bcd BTBCD(.A({sign_bit, tcsm_out[6: 0]}), .ONES(ONES), .TENS(TENS), .HUNDREDS(HUNDREDS));
	
	register #(.N(4)) R1(.clk(out_clk), .load(load_out_unit), .clear(reset), .D(ONES), .Q(ONES_out));
	register #(.N(4)) R2(.clk(out_clk), .load(load_out_unit), .clear(reset), .D(TENS), .Q(TENS_out));
	register #(.N(4)) R3(.clk(out_clk), .load(load_out_unit), .clear(reset), .D({1'b0, 1'b0, HUNDREDS}), .Q(HUNDREDS_out));
	register #(.N(4)) R4(.clk(out_clk), .load(load_out_unit), .clear(reset), .D(det_sign), .Q(NOPE_out));
	
	mux_4x1 m4x1(.i0(ONES_out), .i1(TENS_out), .i2(HUNDREDS_out), .i3(NOPE_out), .s(SEL), .out(mux_out));
	
	bcd_to_sev_act_high btsev(.bin(mux_out), .s(seg));
	
endmodule
