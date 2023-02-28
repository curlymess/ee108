module rotator_tb ();

    // Test two different widths of rotator

    reg [7:0] in_8;
    reg [7:0] expected_8;
    wire [7:0] out_8;
    reg [7:0] distance_8;
    reg direction_8;
    rotator #(.WIDTH(8)) dut_8 (
        .in(in_8),
        .out(out_8),
        .distance(distance_8),
        .direction(direction_8)
    );

    reg [31:0] in_32;
    reg [31:0] expected_32;
    wire [31:0] out_32;
    reg [7:0] distance_32;
    reg direction_32;
    rotator #(.WIDTH(32)) dut_32 (
        .in(in_32),
        .out(out_32),
        .distance(distance_32),
        .direction(direction_32)
    );

    initial begin
        ////// 8-bit tests ////////////////////

        // Basic test cases
        direction_8 = 0;
        distance_8 = 8'd2;
        in_8 = 8'b00010000;
        expected_8 = 8'b00000100;
        #5
        $display ("%b -> %b, expected %b", in_8, out_8, expected_8);

        direction_8 = 1;
        expected_8 = 8'b01000000;
        #5
        $display ("%b -> %b, expected %b", in_8, out_8, expected_8);

        // Add more test cases here, including edge cases.
            // wrap - around cases
        distance_8 = 8'd1;
        in_8 = 8'b10000000;
        direction_8 = 1;
        expected_8 = 8'b00000001;
        #5
        $display ("%b -> %b, expected %b", in_8, out_8, expected_8);

        in_8 = 8'b00000001;
        direction_8 = 0;
        expected_8 = 8'b10000000;
        #5
        $display ("%b -> %b, expected %b", in_8, out_8, expected_8);
        
        distance_8 = 8'd4;
        in_8 = 8'b00000001;
        direction_8 = 0;
        expected_8 = 8'b00010000;
        #5
        $display ("%b -> %b, expected %b", in_8, out_8, expected_8);
        
        // different directions, 2 1's, same output
        in_8 = 8'b01000001;
        expected_8 = 8'b00010100;
        #5
        $display ("%b -> %b, expected %b", in_8, out_8, expected_8);
        
        in_8 = 8'b01000001;
        direction_8 = 1;
        expected_8 = 8'b00010100;
        #5
        $display ("%b -> %b, expected %b", in_8, out_8, expected_8);
        
        // three 1s, different directions, distance 7
        distance_8 = 8'd7;
        in_8 = 8'b01100001;
        direction_8 = 0;
        expected_8 = 8'b11000010;
        #5
        $display ("%b -> %b, expected %b", in_8, out_8, expected_8);
        
        in_8 = 8'b01100001;
        direction_8 = 1;
        expected_8 = 8'b10110000;
        #5
        $display ("%b -> %b, expected %b", in_8, out_8, expected_8);
        
        ////// 32-bit tests ///////////////////
        // Don't worry about repeating ALL of your 8-bit tests here, the point is
        // just to make sure that parameterization of the module works correctly.
        // Basic tests will suffice, edge case tests aren't necessary for this lab

        // Add basic 32-bit test cases here
        direction_32 = 0;
        distance_32 = 32'd2;
        in_32 = 32'b_10000;
        expected_32 = 32'b00000000000000000000000000000100;
        #5
        $display ("%b -> %b, expected %b", in_32, out_32, expected_32);

        direction_32 = 1;
        expected_32 = 32'b00000000000000000000000001000000;
        #5
        $display ("%b -> %b, expected %b", in_32, out_32, expected_32);
        
        // three 1s, different directions, distance 7
        distance_32 = 32'd7;
        in_32 = 32'b_01100001;
        direction_32 = 0;
        expected_32 = 32'b11000010000000000000000000000000;
        #5
        $display ("%b -> %b, expected %b", in_32, out_32, expected_32);
        
        in_32 = 32'b_01100001;
        direction_32 = 1;
        expected_32 = 32'b00000000000000000011000010000000;
        #5
        $display ("%b -> %b, expected %b", in_32, out_32, expected_32);
    end

endmodule
