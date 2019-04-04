/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Tri-State Buffer Module
 */
module buff(
	output reg [7:0] result, 	// Data Output
	input[7:0] a, 				// Tri-State Bus Control
	input buf1					// Data Input
);
	always @(*)
		if(buf1 == 1)
			result = a;
		else 
			result = 8'bzzzz_zzzz;		
endmodule
