/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Top Module
 */
module top(
	input clk, reset, start,					// Clock, Reset, & Start Input
	input [7:0] inFromOutside,					// Input from Outside
	output [7:0] AccOut, outToOutside, memOut,	// Accumulator Output, Output from Outside, & Memory Output
	output [4:0] PC, 							// Program Counter/Address to the Memory
	output MemWrite, OutWrite					// Memory Write & OutWrite Signal (from Control Unit)
);
	microProc mp(
		clk, reset, start, PC, inFromOutside, memOut, 
		OutWrite, MemWrite, AccOut, outToOutside
	);
	mem memory(clk, PC, AccOut, MemWrite, memOut);
endmodule