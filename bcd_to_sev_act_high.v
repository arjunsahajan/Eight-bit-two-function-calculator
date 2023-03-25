module bcd_to_sev_act_high
#(parameter n = 4)
(
	input [n - 1: 0] bin,
	
	output wire [6: 0] s
);

	reg [6: 0] seg;

	assign s = seg;

	always @(bin[3], bin[2], bin[1], bin[0])
	begin
		case({bin[3], bin[2], bin[1], bin[0]})
		
			4'b0000: seg = 7'b0111111;
			
			4'b0001: seg = 7'b0000110;
			
			4'b0010: seg = 7'b1011011;
			
			4'b0011: seg = 7'b1001111;
			
			4'b0100: seg = 7'b1100110;
			
			4'b0101: seg = 7'b1101101;
			
			4'b0110: seg = 7'b1111101;
			
			4'b0111: seg = 7'b0000111;

			4'b1000: seg = 7'b1111111;
			
			4'b1001: seg = 7'b1100111;
			
			4'b1111: seg = 7'b1000000;
			
			4'b1110: seg = 7'b0000000;
		
		endcase
	end

endmodule
