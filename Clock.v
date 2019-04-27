module Clock(input Clk_100M,
             output [3:0] SegmentDrivers,
             output [7:0] SevenSegment);
    reg [29:0] Count;
    
    always @(posedge Clk_100) Count <= Count + 1'b1;
    
    assign SegmentDrivers = Count[29:26];
    assign SevenSegment   = Count[25:18];
endmodule
