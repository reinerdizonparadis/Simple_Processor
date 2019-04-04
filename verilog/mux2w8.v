/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * 2-to-1 MUX (8-bit data width) Module
 */
module mux2w8(
	input [7:0] d0, d1,	// Two Data Inputs
	input s, 			// Selector Input (from Control Unit)
	output [7:0] y		// MUX Output
);
	assign y = s ? d1 : d0;
endmodule