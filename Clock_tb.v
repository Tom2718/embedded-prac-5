`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:38:56 04/29/2019
// Design Name:   Clock
// Module Name:   /home/bluelabuser/Documents/tom/Clock/Clock_tb.v
// Project Name:  Clock
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Clock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Clock_tb;

	// Inputs
	reg Clk_100M;
	reg button;
	reg [1:0] Slide_Switch = 2'b11; // Full brightness

	// Outputs
	wire [3:0] SegmentDrivers;
	wire [7:0] SevenSegment;

	// Instantiate the Unit Under Test (UUT)
	Clock uut (
		.Clk_100M(Clk_100M), 
		.button(button),
		.Slide_Switch(Slide_Switch),
		.SegmentDrivers(SegmentDrivers), 
		.SevenSegment(SevenSegment)
	);

	initial begin
		// Initialize Inputs
		Clk_100M = 0;
		button = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#20
		button = ~button;
		
		
	end

	always begin
		#1 Clk_100M = ~Clk_100M;
	end
      
endmodule

