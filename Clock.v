module Clock(input wire Clk_100M,
			    input wire button,
				 input wire [1:0] Slide_Switch,
             output [3:0] SegmentDrivers,
             output [7:0] SevenSegment,
				 output [5:0] LED_Pins
				 );
    
    // Can be 27 bits wide for frequency count of 100MHz
    reg [29:0] Count = 30'b0;
    reg [5:0] seconds = 6'b0;
    reg [3:0] minutesTens = 4'd0;
    reg [3:0] minutesUnits = 4'd0;
    reg [3:0] hoursTens = 4'd0;
    reg [3:0] hoursUnits = 4'd0;
    
    // Initialise Delay_Reset
    wire Reset;
    // Add BTNS as a pull up button !!!!!!!!!!!
    Delay_Reset Delay_Reset1(Clk_100M,button,Reset);
	 
	 wire Button_Minutes;
	 wire Button_Hours;
	 wire Set_Minutes;
	 wire Set_Hours;
	 
	 Debounce Debounce_Minutes(Clk_100M, Button_Minutes, Set_Minutes);
	 Debounce Debounce_Hours(Clk_100M, Button_Hours, Set_Hours);
    
    // Initialise SS_Driver
    SS_Driver SS_Driver1(
    Clk_100M, Reset,
    hoursTens,
    hoursUnits,
    minutesTens,
    minutesUnits,
    SegmentDrivers, SevenSegment
    );
		
	 // There are 
    assign LED_Pins = seconds;
    
    always @(posedge Clk_100M) begin
        if (Count > 30'd1) begin // Count > 1*frequency
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
				
				// Set minute time
				if (Set_Minutes) begin
					if (minutesUnits == 4'd9) begin
						if (minutesTens == 4'd5) begin
							minutesTens <= 4'b0;
						end
						else begin
							minutesTens <= minutesTens + 1'b1;
						end
						minutesUnits <= 4'b0;
					end
					minutesUnits <= minutesUnits + 1'b1;
				end
				
				// Set hour time
				if (Set_Hours) begin
					if (hoursUnits == 4'd9) begin
						if (hoursTens == 4'd5) begin
							hoursTens <= 4'b0;
						end
						else begin
							hoursTens <= hoursTens + 1'b1;
						end
						hoursUnits <= 4'b0;
					end
					hoursUnits <= hoursUnits + 1'b1;
				end
        end
        Count <= Count + 1'b1;
    end
	 
	 // Testing
	 initial begin
		// Test clock 
		// $monitor("%d%d:%d%d", hoursTens, hoursUnits, minutesTens, minutesUnits);
		
	 end
    
    // ???
    // assign SegmentDrivers = Count[29:26];
    // assign SevenSegment   = Count[25:18];
endmodule