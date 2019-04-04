/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Microprocessor Module
 */
module microProc(
	input clk, reset, start,			// Clock, Reset, & Start Signal
	output [4:0] PC,					// Program Counter Output
	input [7:0] inFromOutside, memOut,	// Input From Outside, Memory Output
	output OutWrite, MemWrite,
	output [7:0] AccOut, outToOutside
);
	wire PCWrite, IorD, PCSrc, IRWrite, AccWrite;
	wire [1:0] ALUControl, AccSrc;
	wire zero, pos;
	wire [7:0] IROut;
	
	controller CU(
		clk, reset, start, IROut, PCSrc, PCWrite, 
		IorD, MemWrite, IRWrite, OutWrite, AccSrc, 
		ALUControl, AccWrite, zero, pos
	);
	datapath DP(
		clk, reset, PCWrite, IorD, PCSrc, 
		IRWrite, AccWrite, OutWrite,
		AccSrc, ALUControl, zero, pos, PC, 
		memOut, inFromOutside, IROut,
		AccOut, outToOutside
	);
endmodule
