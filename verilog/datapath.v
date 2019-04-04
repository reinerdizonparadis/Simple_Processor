/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Datapath Module
 */
module datapath(
	input clk, reset,					// Clock & Reset Input
	input PCWrite, IorD, PCSrc,			// *
	input IRWrite, AccWrite, OutWrite,	// * Signals from Control Unit
	input [1:0] AccSrc, ALUControl,		// *
	output zero, pos,					// Branch Condition Signals: used for JZ, JPOS instructions
	output [4:0] PC,					// Program Counter Output
	input [7:0] memOut, inFromOutside,	// Output From Memory & Outside: comes from Top Module
	output [7:0] IROut,					// Instruction Register Output
	output [7:0] AccOut, outToOutside	// Accumulator Output & Output to Outside: used for Top Module
);
	wire [4:0] pcRegIn, pcRegOut, PCplus1;
	wire [7:0] accMUX1out, accMUX2out, accIn;
	wire [7:0] ALUOut;
	
	// next PC logic
	mux2w5 pcMUX(PCplus1, IROut[4:0], PCSrc, pcRegIn);
	programCounter pcReg(clk, reset, PCWrite, pcRegIn, pcRegOut);
	incrementer PCadd(pcRegOut, PCplus1);
	mux2w5 memAddrIn(pcRegOut, IROut[4:0], IorD, PC);
	
	// instruction register
	flopr instrReg(clk, reset, IRWrite, memOut, IROut);
	
	// accumulator register
	mux2w8 accMUX1(ALUOut, memOut, AccSrc[0], accMUX1out);
	mux2w8 accMUX2(inFromOutside, 8'b0, AccSrc[0], accMUX2out);
	mux2w8 accMUX(accMUX1out, accMUX2out, AccSrc[1], accIn);
	flopr accumulator(clk, reset, AccWrite, accIn, AccOut);
	
	// ALU logic
	alu ALU(AccOut, memOut, ALUControl, ALUOut, zero, pos);
	
	// out tri-state buffer
	buff outBuff(outToOutside, AccOut, OutWrite);
endmodule