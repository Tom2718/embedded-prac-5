/**
 *  Every time the button is pressed, the internal count is reset to 0
 *  and the Reset output is set to 1. When count is about to overflow,
 *  Reset is set to 0. At all other timesteps, increment Count and
 *  hold Reset to 1.
 **/

module Delay_Reset(input Clk,
                   input Button,
                   output reg Reset);
    //------------------------------------------------------------------------------
    reg LocalReset;
    reg [22:0]Count;
    // Assume Count is null on FPGA configuration
    //------------------------------------------------------------------------------
    always @(posedge Clk) begin
        // Activates every clock edge
        LocalReset <= Button;
        // Localise the reset signal
        if (LocalReset) begin
            // Reset block
            Count <= 0;
            // Reset Count to 0
            Reset <= 1'b1;
            // Reset the output to 1
        end
        else if (&Count) begin
            // When Count is all ones...
            Reset <= 1'b0;
            // Release the output signal
            // Count remains unchanged
            // And do nothing else
        end
        else begin
            // Otherwise...
            Reset <= 1'b1;
            // Make sure the output signal is high
            Count <= Count + 1'b1;
            // And increment Count
        end
    end
    // always
    //------------------------------------------------------------------------------
endmodule