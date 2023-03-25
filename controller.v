module controller
(
	input clk, reset,

	output [6: 0] seg,
	
	output [3: 0] CAT,
	
	output [6: 0] seg_ones, seg_tens, seg_hun, seg_sign
);

	wire clk1, clk2, clk3, out_clk;
	
	wire [2: 0] count1;
	wire [3: 0] count2;
	wire [9: 0] count3;
	wire [7: 0] count;
	
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
	
	clock_div #(.N(625), .M(20)) c1(.clk(clk), .clear(reset), .COUNT(count1), .OUT(clk1)); // clk1 = 80,000Hz
	
	clock_div #(.N(125), .M(8)) c2(.clk(clk1), .clear(reset), .COUNT(count2), .OUT(clk2)); // clk2 = 640Hz
	
	clock_div #(.N(128), .M(8)) c3(.clk(clk2), .clear(reset), .COUNT(count3), .OUT(out_clk)); // out_clk = 5Hz
	
	nbit_counter counter(.clk(out_clk), .reset(reset), .count_val(count));
	
	twos_comp_to_sign_mag TCSM(.the_input(count), .the_output(tcsm_out));
	
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
	
	register #(.N(4)) R1(.clk(out_clk), .load(1'b0), .clear(reset), .D(ONES), .Q(ONES_out));
	register #(.N(4)) R2(.clk(out_clk), .load(1'b0), .clear(reset), .D(TENS), .Q(TENS_out));
	register #(.N(4)) R3(.clk(out_clk), .load(1'b0), .clear(reset), .D({1'b0, 1'b0, HUNDREDS}), .Q(HUNDREDS_out));
	register #(.N(4)) R4(.clk(out_clk), .load(1'b0), .clear(reset), .D(det_sign), .Q(NOPE_out));
	
	mux_4x1 m4x1(.i0(ONES_out), .i1(TENS_out), .i2(HUNDREDS_out), .i3(NOPE_out), .s(SEL), .out(mux_out));
	
	bcd_to_sev_act_high btsev(.bin(mux_out), .s(seg));
	
	output_unit OU(.the_input(count), .seg_ones(seg_ones), .seg_tens(seg_tens), .seg_hun(seg_hun), .seg_sign(seg_sign));

endmodule
