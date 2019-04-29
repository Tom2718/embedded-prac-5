`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:51:38 04/28/2019
// Design Name:   Clock
// Module Name:   /home/debi/Documents/University/embedded/prac5/src/Clock/Clock_tb.v
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
//	reg Clk_100M;
//
//	// Outputs
//	wire [3:0] SegmentDrivers;
//	wire [7:0] SevenSegment;
//
//	// Instantiate the Unit Under Test (UUT)
//	Clock uut (
//		.Clk_100M(Clk_100M), 
//		.SegmentDrivers(SegmentDrivers), 
//		.SevenSegment(SevenSegment)
//	);
//
//	initial begin
//		// Initialize Inputs
//		Clk_100M = 0;
//
//		// Wait 100 ns for global reset to finish
//		#100;
//        
//		// Add stimulus here
//
//	end

reg clk = 0;
always begin
    #1 clk = ~clk;
end
      
endmodule

