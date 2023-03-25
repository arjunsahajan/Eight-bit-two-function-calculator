module keypad_decoder
#(parameter BASE = 10)
(
	input [3: 0] row,
	input [3: 0] col,
	
	output reg[3: 0] value,
	output reg valid
);

	always @(row, col)
		begin
			if(BASE == 10)
				begin
					case({row, col})
						8'b0001_0001: begin value = 1; valid = 1; end
						
						8'b0001_0010: begin value = 2; valid = 1; end
					
						8'b0001_0100: begin value = 3; valid = 1; end
						
						8'b0001_1000: begin value = 10; valid = 1; end
						
						8'b0010_0001: begin value = 4; valid = 1; end
						
						8'b0010_0010: begin value = 5; valid = 1; end
						
						8'b0010_0100: begin value = 6; valid = 1; end
						
						8'b0010_1000: begin value = 11; valid = 1; end
						
						8'b0100_0001: begin value = 7; valid = 1; end
						
						8'b0100_0010: begin value = 8; valid = 1; end
						
						8'b0100_0100: begin value = 9; valid = 1; end
						
						8'b0100_1000: begin value = 12; valid = 1; end
						
						8'b1000_0001: begin value = 8; valid = 1; end
						
						8'b1000_0010: begin value = 0; valid = 1; end
						
						8'b1000_0100: begin value = 14; valid = 1; end
						
						8'b1000_1000: begin value = 13; valid = 1; end
						
						default: begin value = 0; valid = 0; end
					endcase
				end
			else if(BASE == 16)
				begin
					case({row, col})
						8'b0001_0001: begin value = 0; valid = 1; end
						
						8'b0001_0010: begin value = 1; valid = 1; end
						
						8'b0001_0100: begin value = 2; valid = 1; end
						
						8'b0001_1000: begin value = 3; valid = 1; end
						
						8'b0010_0001: begin value = 4; valid = 1; end
						
						8'b0010_0010: begin value = 5; valid = 1; end
						
						8'b0010_0100: begin value = 6; valid = 1; end
						
						8'b0010_1000: begin value = 7; valid = 1; end
						
						8'b0100_0001: begin value = 8; valid = 1; end
						
						8'b0100_0010: begin value = 9; valid = 1; end
						
						8'b0100_0100: begin value = 10; valid = 1; end
						
						8'b0100_1000: begin value = 11; valid = 1; end
						
						8'b1000_0001: begin value = 12; valid = 1; end
						
						8'b1000_0010: begin value = 13; valid = 1; end
						
						8'b1000_0100: begin value = 14; valid = 1; end
						
						8'b1000_1000: begin value = 15; valid = 1; end
						
						default: begin value = 0; valid = 0; end
					endcase
				end
		end

endmodule
