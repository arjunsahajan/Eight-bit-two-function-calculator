module bcd_to_sev
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
		
			4'b0000: seg = 7'b1000000;
			
			4'b0001: seg = 7'b1111001;
			
			4'b0010: seg = 7'b0100100;
			
			4'b0011: seg = 7'b0110000;
			
			4'b0100: seg = 7'b0011001;
			
			4'b0101: seg = 7'b0010010;
			
			4'b0110: seg = 7'b0000010;
			
			4'b0111: seg = 7'b1111000;

			4'b1000: seg = 7'b0000000;
			
			4'b1001: seg = 7'b0011000;
		
		endcase
	end

endmodule
