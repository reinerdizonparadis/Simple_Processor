/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Program Counter Register Module
 */
module programCounter(
	input clk, clear, load,	// Clock, Clear, & Load Signal
	input [4:0] d,			// Data Input
	output reg [4:0] q		// Data Output
);
	always @(posedge clk, posedge clear)
		if(clear) q <= 0;
		else if(load) q <= d;
endmodule