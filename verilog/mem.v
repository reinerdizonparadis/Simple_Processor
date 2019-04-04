/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Combined Instruction/Data Memory Module
 */
module mem(
	input CLK,			// Clock Input
	input [4:0] addr, 	// Address Input (from MUX)
	input [7:0] WD,		// Write Data Input
	input WE,			// Write Enable Input
	output [7:0] RD		// Read Data Output
);
	reg [7:0] RAM[31:0]; // RAM limited to 32-bit
	initial $readmemb ("memfile.dat", RAM);
	assign RD = RAM[addr];
	always @(posedge CLK)
		if(WE) RAM[addr] <= WD;
endmodule
