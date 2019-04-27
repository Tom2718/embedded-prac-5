module Clock(input Clk_100M,
             output [3:0] SegmentDrivers,
             output [7:0] SevenSegment);
    
    // Can be 27 bits wide for frequency count of 100MHz
    reg [29:0] Count;
    reg seconds [5:0] = 6'b0;
    reg minutesTens,
    minutesUnits,
    hoursTens,
    hoursUnits [3:0] = 4'd0;
    
    // Initialise Delay_Reset
    wire Reset;
    // Add BTNS as a pull up button !!!!!!!!!!!
    Delay_Reset Delay_Reset1(Clk_100M,BTNS,Reset);
    
    // Initialise SS_Driver
    SS_Driver SS_Driver1(
    Clk_100M, Reset,
    hoursTens,
    hoursUnits,
    minutesTens,
    minutesUnits,
    SegmentDrivers, SevenSegment
    );
    
    always @(posedge Clk_100M) begin
        if (Count > 100000000) begin // Count > 1*frequency
            if (seconds == 6'd59) begin
                if (minutesTens == 4'd5 && minutesUnits == 4'd9) begin
                    if (hoursTens == 4'd2 && hoursUnits == 4'd3) begin
                        hoursTens    <= 4'd0;
                        hoursUnits   <= 4'd0;
                        minutesTens  <= 4'd0;
                        minutesUnits <= 4'd0;
                        seconds      <= 6'b0;
                    end
                    else if (hoursUnits == 4'd9) begin
                        minutesTens  <= 4'd0;
                        minutesUnits <= 4'd0;
                        hoursUnits   <= 4'd0;
                        hoursTens    <= hoursTens + 1'b1;
                    end
                    else begin
                        minutesTens  <= 4'd0;
                        minutesUnits <= 4'd0;
                        hoursUnits   <= hoursUnits + 1'b1;
                    end
                end
                else if (minutesUnits == 4'd9) begin
                    minutesTens  <= minutesTens + 1'b1;
                    minutesUnits <= 4'd0;
                    seconds      <= 6'b0;
                end
                else begin
                    minutesUnits <= minutesUnits + 1'b1;
                    seconds      <= 6'b0;
                end
            end
            else begin
                seconds <= seconds + 1'b1;
            end
        end
        Count <= Count + 1'b1;
    end
    
    // ???
    // assign SegmentDrivers = Count[29:26];
    // assign SevenSegment   = Count[25:18];
endmodule
