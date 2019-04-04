/* Reiner Dizon
 * Simple 8-bit microprocessor (MP-8)
 * Testbench Module
 */
module testb;
	reg clk, reset, start;
	reg [7:0] inFromOutside;
	wire [7:0] AccOut, outToOutside, memOut;
	wire [4:0] addr;
	wire MemWrite, OutWrite;
	
	// device under test
	top dut(clk, reset, start, inFromOutside, AccOut, outToOutside, memOut, addr, MemWrite, OutWrite);
	
	initial begin
		start <= 0;
		reset <= 1;
		#22;
		start <= 1;
		#22;
		reset <= 0;
		inFromOutside <= 5;
	end
	
	always begin
		clk <= 0;
		#5;
		clk <= 1;
		#5;
	end
	
	always @(posedge clk) begin
		if(addr === 30 && memOut === 15) begin
				$display ("Write Data:      Expected: 15       Actual: %d", memOut);
				$display ("Simulation succeeded");
		end
		else if(addr === 16) begin
			if(AccOut !== 15) begin
				$display ("Write Data:      Expected: 15       Actual: %d", AccOut);
				$display ("Simulation failed");
			end
			$display ("Simulation done");
			$stop;
		end
	end
endmodule