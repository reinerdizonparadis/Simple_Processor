/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Controller Module
 */
module controller(
	input clk, reset, start,		// Clock, Reset, & Start Signal
	input [7:0] instr,				// Instruction Input
	output PCSrc,
	output reg PCWrite, IorD, MemWrite, 
	output reg IRWrite, OutWrite,
	output reg [1:0] AccSrc, ALUControl,
	output reg AccWrite,
	input zero, pos					// Branch Condition Input (from ALU)
);
	reg branch, ZorP;
	reg [4:0] state;
	reg [4:0] nextstate;
	parameter S0 = 0; // reset
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;
	parameter S4 = 4;
	parameter S5 = 5;
	parameter S6 = 6;
	parameter S7 = 7;
	parameter S8 = 8;
	parameter S9 = 9;
	parameter S10 = 10;
	parameter S11 = 11;
	
	always @(posedge clk, posedge reset)
		if(reset) state <= S0;
		else state <= nextstate;
	
	always @(state, instr, start) begin
	case(state)
		S0: begin
			if(start) begin
				PCWrite <= 1'b0;
				IorD <= 1'b0;
				MemWrite <= 1'b0;
				IRWrite <= 1'b1;
				OutWrite <= 1'b0;
				AccSrc <= 2'bxx;
				AccWrite <= 1'b0;
				ALUControl <= 2'bxx;
				branch <= 1'b0;
				ZorP <= 1'bx;
				nextstate <= S1;
			end
			else nextstate <= S0;
		end
		
		S1: begin
			PCWrite <= 1'b1;
			IRWrite <= 1'b0;
			if(instr[7:5] == 3'b000) nextstate <= S2; //opcode = LOAD
			if(instr[7:5] == 3'b001) nextstate <= S3; //opcode = STORE
			if(instr[7:5] == 3'b010) nextstate <= S4; //opcode = ADD
			if(instr[7:5] == 3'b011) nextstate <= S5; //opcode = SUB
			if(instr[7:5] == 3'b100) nextstate <= S6; //opcode = AND
			if(instr[7:5] == 3'b101) nextstate <= S7; //opcode = JZ
			if(instr[7:5] == 3'b110) nextstate <= S8; //opcode = JPOS
			if(instr[7:3] == 5'b11100) nextstate <= S9; //opcode = IN
			if(instr[7:3] == 5'b11101) nextstate <= S10; //opcode = OUT
			if(instr[7:4] == 4'b1111) nextstate <= S11; //opcode = HALT
		end
		
		S2: begin // LOAD
			PCWrite <= 1'b0;
			IorD <= 1'b1;
			AccWrite <= 1'b1;
			AccSrc <= 2'b01;
			nextstate <= S0;
		end
		
		S3: begin // STORE
			PCWrite <= 1'b0;
			IorD <= 1'b1;
			MemWrite <= 1'b1;
			nextstate <= S0;
		end
		
		S4: begin // ADD
			PCWrite <= 1'b0;
			IorD <= 1'b1;
			ALUControl <= 2'b00;
			AccSrc <= 2'b00;
			AccWrite <= 1'b1;
			nextstate <= S0;
		end
		
		S5: begin // SUB
			PCWrite <= 1'b0;
			IorD <= 1'b1;
			ALUControl <= 2'b01;
			AccSrc <= 2'b00;
			AccWrite <= 1'b1;
			nextstate <= S0;
		end
		
		S6: begin // AND
			PCWrite <= 1'b0;
			IorD <= 1'b1;
			ALUControl <= 2'b10;
			AccSrc <= 2'b00;
			AccWrite <= 1'b1;
			nextstate <= S0;
		end
		
		
		S7: begin // JZ
			PCWrite <= zero;
			branch <= 1'b1;
			ZorP <= 1'b0;
			nextstate <= S0;
		end
		
		S8: begin // JPOS
			PCWrite <= pos;
			branch <= 1'b1;
			ZorP <= 1'b1;
			nextstate <= S0;
		end
		
		S9: begin // IN
			PCWrite <= 1'b0;
			AccSrc <= 2'b10;
			AccWrite <= 1'b1;
			nextstate <= S0;
		end
		
		S10: begin // OUT
			PCWrite <= 1'b0;
			OutWrite <= 1'b1;
			nextstate <= S0;
		end
		
		S11: begin // HALT
			PCWrite <= 1'b0;
			nextstate <= S11;
		end
		default: nextstate <= S0;
	endcase
	end
	assign PCSrc = ZorP ? (branch & pos) : (branch & zero);
endmodule