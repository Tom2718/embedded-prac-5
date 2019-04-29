`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:34 04/29/2019 
// Design Name: 
// Module Name:    Debounce 
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
module Debounce(
		input Clk,
		input Button,
		output reg Set
    );
	 reg [24:0] count = 25'b0;

    always @(posedge Clk) begin 
        if (Button == 1'b1 && count == 25'b0) begin
            Set <= 1'b1;
				count <= count + 1'b1;
        end 
        else if (count > 1e8/50) begin // Debounce time: 20ms
				Set <= ~Set;
            count <= 25'b0;
        end
        else if (count > 25'b0) begin
            count <= count + 1'b1;
        end
    end

endmodule
