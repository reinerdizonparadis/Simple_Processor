/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Arithmetic Logic Unit (ALU) Module
 */
module alu (a, b, sel, out, zero, pos);
	input [7:0] a, b;		// a - Accumulator, b - Memory
	input [1:0] sel;		// from Control Unit (ALUControl signal)
	output reg [7:0] out;	// fed back to Accumulator MUX
	output reg zero, pos;	// used for JZ, JPOS instructions
	
	initial begin
		out = 0;
		zero = 1'b0;
		pos = 1'b0;
	end
	
	always @ (*) begin 
		case(sel)
			2'b00: begin // ADD
				out = a + b;
				if(a == 0) zero = 1;
				else zero = 0;
				if(a > 0) pos = 1;
				else pos = 0;
			end
			2'b01: begin // SUB
				out = a - b;
				if(a == 0) zero = 1;
				else zero = 0;
				if(a > 0) pos = 1;
				else pos = 0;
			end
			2'b10: begin // AND
				out = a & b;
				if(a == 0) zero = 1;
				else zero = 0;
				if(a > 0) pos = 1;
				else pos = 0;
			end
		endcase
	end
endmodule