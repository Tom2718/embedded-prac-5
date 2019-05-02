/** A module that takes the set of BCD values and drives the
 *  seven segment display via the pins defined as outputs here.
 **/

module SS_Driver(input Clk,
                 Reset,
                 input [3:0] BCD3,
                 BCD2,
                 BCD1,
                 BCD0,
                 input [7:0] Brightness,
                 output reg [3:0] SegmentDrivers,
                 output reg [7:0] SevenSegment);
    //-----------------------------------------------------------------------------
    // Make use of a subcircuit to decode the BCD to seven-segment (SS)
    wire [6:0]SS[3:0];
    BCD_Decoder BCD_Decoder0(BCD0, SS[0]);
    BCD_Decoder BCD_Decoder1(BCD1, SS[1]);
    BCD_Decoder BCD_Decoder2(BCD2, SS[2]);
    BCD_Decoder BCD_Decoder3(BCD3, SS[3]);
    //------------------------------------------------------------------------------
    // Counter to reduce the 100 MHz clock to 762.939 Hz (100 MHz / 2^17)
    reg [18:0]Count = 19'b0;
    // reg My_Count = 1'b0;
    wire pwm_value;
    
    PWM PWM_inst (
    Clk,
    Brightness,
    pwm_value
    );
    
    // Scroll through the digits, switching one on at a time
    always @(posedge Clk) begin
        Count                     <= Count + 1'b1;
        if (Reset) SegmentDrivers <= 4'hE;
        else if (&Count) begin
        SegmentDrivers <= {SegmentDrivers[2:0], SegmentDrivers[3]};
        Count          <= 19'b0;
    end
    end
    //------------------------------------------------------------------------------
    always @(*) begin
        // This describes a purely combinational circuit
        SevenSegment[7] <= 1'b1;
        // Decimal point always off
        if (Reset) begin
            SevenSegment[6:0] <= 7'h7F;
            // All off during Reset
        end
        else begin
            if (pwm_value) begin
                case(~SegmentDrivers)
                    // Connect the correct signals,
                    4'h1 : SevenSegment[6:0] <= ~SS[0];
                    // depending on which digit is on at
                    4'h2 : SevenSegment[6:0] <= ~SS[1];
                    // this point
                    4'h4 : SevenSegment[6:0]   <= ~SS[2];
                    4'h8 : SevenSegment[6:0]   <= ~SS[3];
                    default: SevenSegment[6:0] <= 7'h7F;
                endcase
            end
            else begin
                SevenSegment[6:0] <= 7'h7F;
            end
        end
    end
endmodule
