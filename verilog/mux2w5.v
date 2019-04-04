/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * 2-to-1 MUX with 5-bit Data Width Module
 */
module mux2w5(
	input [4:0] d0, d1,	// Two Data Inputs
	input s, 			// Selector Input (from Control Unit)
	output [4:0] y		// MUX Output
);
	assign y = s ? d1 : d0;
endmodule