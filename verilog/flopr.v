/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Resettable Flip-Flop Module 
 * (Accumulator & Instruction Register)
 */
module flopr(
	input clk, clear, load,	// clock, clear, & load
	input [7:0] d,			// data in
	output reg [7:0] q		// data out
);
	// used for Accumulator & Instruction Register
	always @(posedge clk, posedge clear)
		if(clear) q <= 0;
		else if(load) q <= d;
endmodule