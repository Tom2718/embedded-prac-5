`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:58:03 04/30/2019 
// Design Name: 
// Module Name:    PWM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PWM (
		input clk,
		input [7:0] PWM_CW,
		output reg PWM_out					         
	);
	reg [7:0] count = 8'b0;  // 8 bit counter output

	always @ (posedge clk)
	begin
			
			if (PWM_CW > count)
				PWM_out <= 1;
			else 
				PWM_out <= 0;
				
			count <= count + 1'b1;
	end
endmodule
