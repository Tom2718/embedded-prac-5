`timescale 1ns / 1ps

module Debounce(input Clk,
                input Button,
                output reg Set);
    reg [24:0] count = 25'b0;
    
    always @(posedge Clk) begin
        if (Button == 1'b1 && count == 25'b0) begin
            Set   <= 1'b1;
            count <= count + 1'b1;
        end
        else if (Set) begin
            Set <= ~Set;
        end
            else if (count > 25'd80000000) begin // Debounce time: 20ms; Temp: 200ns * 2
            count <= 25'b0;
            end
            else if (count > 25'b0) begin
            count <= count + 1'b1;
            end
        else begin
            Set <= 1'b0;
        end
    end
    
endmodule
