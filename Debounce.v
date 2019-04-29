module Debounce(input clk, input button, output reg active);
    reg [24:0] count = 25'b0;

    always @(posedge clk) begin 
        if (button == 1'b1 && count == 25'b0) begin
            active <= 1'b1;
        end 
        else if (active == 1'b1) begin
            active <= 1'b0;
            count <= count + 1'b1;
        end
        else if (count > 1e8/5) begin // Debounce time
            count <= 25'b0;
        end
        else if (count > 25'b0) begin
            count <= count + 1'b1;
        end
    end
endmodule
