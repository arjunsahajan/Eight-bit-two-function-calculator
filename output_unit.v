module output_unit
(
	input [7: 0] the_input,
	
	output [6: 0] seg_ones, seg_tens, seg_hun, seg_sign 
);

	wire [7: 0] tcsm_out;
	wire [3: 0] ONES, TENS;
	wire [1: 0] HUNDREDS;

	reg sign_bit;
	
	twos_comp_to_sign_mag TCSM(.the_input(the_input), .the_output(tcsm_out));
	
	always @(tcsm_out)
		if(tcsm_out[7] == 1'b1 && tcsm_out[6: 0] == 7'b0000000)
			sign_bit = 1'b1;
		else
			sign_bit = 1'b0;
	
	b_to_bcd BTBCD(.A({sign_bit, tcsm_out[6: 0]}), .ONES(ONES), .TENS(TENS), .HUNDREDS(HUNDREDS));
	
	bcd_to_sev BCDTSEV_ones(.bin(ONES), .s(seg_ones));
	bcd_to_sev BCDTSEV_tens(.bin(TENS), .s(seg_tens));
	bcd_to_sev BCDTSEV_hun(.bin({1'b0, 1'b0, HUNDREDS}), .s(seg_hun));

	assign seg_sign[6] = ~tcsm_out[7];
	assign seg_sign[5] = 1'b1;
	assign seg_sign[4] = 1'b1;
	assign seg_sign[3] = 1'b1;
	assign seg_sign[2] = 1'b1;
	assign seg_sign[1] = 1'b1;
	assign seg_sign[0] = 1'b1;
	
endmodule
