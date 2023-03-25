module control_unit_fsm
(
	input reset, enter,
	
	output reg loadA, loadB, loadR, load_out_unit, sel
);

	reg [1: 0] state, nextstate;
	
	always @(negedge enter, negedge reset)
		if(reset == 0) state <= 2'b0; else state <= nextstate;
	
	always @(state)
		case ({state})
			2'b00: begin nextstate = 2'b01; loadA = 1'b1; loadB = 1'b1; loadR = 1'b1; load_out_unit = 1'b0; sel = 1'b0; end
			2'b01: begin nextstate = 2'b10; loadA = 1'b0; loadB = 1'b1; loadR = 1'b1; load_out_unit = 1'b0; sel = 1'b0; end
			2'b10: begin nextstate = 2'b11; loadA = 1'b1; loadB = 1'b0; loadR = 1'b1; load_out_unit = 1'b0; sel = 1'b0; end
			2'b11: begin nextstate = 2'b00; loadA = 1'b1; loadB = 1'b1; loadR = 1'b0; load_out_unit = 1'b0; sel = 1'b1; end
		endcase
		
endmodule
