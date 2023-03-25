module test_pat_gen
(
	input clk, reset, on_off,
	
	output [6: 0] seg_ones, seg_tens, seg_hun, seg_sign
);

	wire clk1, clk2, clk3, out_clk;
	
	reg dupe_clock;
	
	wire [2: 0] count1;
	wire [3: 0] count2;
	wire [9: 0] count3;
	wire [7: 0] count;
	
	always @(posedge clk)
	begin
		if(on_off)
			dupe_clock <= ~dupe_clock;
	end
	
	clock_div #(.N(625), .M(12)) c1(.clk(dupe_clock), .clear(reset), .COUNT(count1), .OUT(clk1)); // clk1 = 80,000Hz
	
	clock_div #(.N(125), .M(8)) c2(.clk(clk1), .clear(reset), .COUNT(count2), .OUT(clk2)); // clk2 = 640 Hz
	
	clock_div #(.N(128), .M(8)) c3(.clk(clk2), .clear(reset), .COUNT(count3), .OUT(out_clk)); // out_clk = 5Hz
	
	nbit_counter counter(.clk(out_clk), .reset(reset), .count_val(count));
	
	output_unit OU(.the_input(count), .seg_ones(seg_ones), .seg_tens(seg_tens), .seg_hun(seg_hun), .seg_sign(seg_sign));
	
endmodule
