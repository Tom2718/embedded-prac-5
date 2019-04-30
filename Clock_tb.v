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
	reg Reset_Button = 1'b0;
	reg Button_Minutes = 1'b0;
	reg Button_Hours = 1'b0;
	reg [1:0] Slide_Switch = 2'b11; // Full brightness

	// Outputs
	wire [3:0] SegmentDrivers;
	wire [7:0] SevenSegment;

	// Instantiate the Unit Under Test (UUT)
	Clock uut (
		.Clk_100M(Clk_100M), 
		.Reset_Button(Reset_Button),
		.Button_Minutes(Button_Minutes),
		.Button_Hours(Button_Hours),
		.Slide_Switch(Slide_Switch),
		.SegmentDrivers(SegmentDrivers), 
		.SevenSegment(SevenSegment)
	);

	initial begin
		// Initialize Inputs
		Clk_100M = 0;

		// Wait 100 ns for global reset to finish
		#100;
		Reset_Button = 1'b1;
		#50
		Reset_Button = 1'b0;
        
		// Test Minutes Button
//		#20
//		Button_Minutes = 1'b1;
//		#20 
//		Button_Minutes = 1'b0;
//		#20
//		Button_Minutes = 1'b1;
//		#20 
//		Button_Minutes = 1'b0;
//		
//		repeat(200) begin
//			#250
//			Button_Minutes = ~Button_Minutes;
//		end
		
		// Test Hours Button
//		#20
//		Button_Hours = 1'b1;
//		#20 
//		Button_Hours = 1'b0;
//		#20
//		Button_Hours = 1'b1;
//		#20 
//		Button_Hours = 1'b0;
//		
//		repeat(100) begin
//			#250
//			Button_Hours = ~Button_Hours;
//		end

		// Test Brightness
//		#20
//		Slide_Switch = 2'b11;
//		#600000
//		Slide_Switch = 2'b10;
//		#1000000
//		Slide_Switch = 2'b1;
//		#2000000
//		Slide_Switch = 2'b00;		
	end

	always begin
		#1 Clk_100M = ~Clk_100M;
	end
      
endmodule

