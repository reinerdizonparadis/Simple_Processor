/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Incrementer Module
 */
module incrementer (input [4:0] a, output [4:0] y);
	assign y = a + 1; // takes 5-bit input and adds 1, used for PC
endmodule
