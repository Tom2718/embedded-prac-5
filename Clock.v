module Clock(input wire Clk_100M,
			    input wire Reset_Button,
				 input wire Button_Minutes,
				 input wire Button_Hours,
				 input wire [7:0] Slide_Switch,
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
    Delay_Reset Delay_Reset1(Clk_100M,Reset_Button,Reset);
	 
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
		 Slide_Switch,
		 SegmentDrivers, SevenSegment
    );
		
	 // Assign seconds value in binary to LEDs
    assign LED_Pins = seconds;
    
    always @(posedge Clk_100M) begin
			if (Reset) begin
				hoursTens    <= 4'd0;
				hoursUnits   <= 4'd0;
				minutesTens  <= 4'd0;
				minutesUnits <= 4'd0;
				seconds      <= 6'b0;
			end
	 
        if (Count > 30'd1) begin // Count > 1*frequency. 200000000 = 1s
				Count <= 30'b0;
				// Count 24h clock
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
		  else begin
				Count <= Count + 1'b1;
		  end
		  
		  // Set minute time
			if (Set_Minutes) begin
				if (minutesUnits == 4'd9) begin
					if (minutesTens == 4'd5) begin
						minutesTens <= 4'b0;
						minutesUnits <= 4'b0;
					end
					else begin
						minutesTens <= minutesTens + 1'b1;
						minutesUnits <= 4'b0;
					end
				end
				else begin
					minutesUnits <= minutesUnits + 1'b1;
				end
			end
			
			// Set hour time
			if (Set_Hours) begin
				if (hoursTens == 4'd2) begin
					if (hoursUnits == 4'd3) begin
						hoursTens <= 4'b0;
						hoursUnits <= 4'b0;
					end
					else begin
						hoursUnits <= hoursUnits + 1'b1;
					end
				end
				else if (hoursUnits == 4'd9) begin
					hoursUnits <= 4'd0;
					hoursTens <= hoursTens + 1'b1;
				end
				else begin
					hoursUnits <= hoursUnits + 1'b1;
				end
			end
    end
	 
	 // Testing
	 initial begin
		// Test clock 
		// $monitor("%d%d:%d%d", hoursTens, hoursUnits, minutesTens, minutesUnits);
		
		// Test LEDs
		// $monitor("%b", seconds);
		
		// Test Buttons
		// $monitor("%d,%d:%d,%d", hoursTens, hoursUnits, minutesTens, minutesUnits);
	 end
endmodule