module shifter_tb ();

    reg [4:0] in_5;
    reg [4:0] expected_5;
    wire [4:0] out_5;
    reg [2:0] distance_5;
    reg direction_5;
    shifter #(.WIDTH(5)) dut_5 (
        .in(in_5),
        .out(out_5),
        .distance(distance_5),
        .direction(direction_5)
    );
    
    initial begin
        ////// 5-bit tests ////////////////////

        // shift left
        direction_5 = 0;
        distance_5 = 3'd2;
        in_5 = 5'b00010;
        expected_5 = 5'b01000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 0;
        distance_5 = 3'd7;
        in_5 = 5'b00010;
        expected_5 = 5'b00000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 0;
        distance_5 = 3'd7;
        in_5 = 5'b00110;
        expected_5 = 5'b00000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 0;
        distance_5 = 3'd6;
        in_5 = 5'b10000;
        expected_5 = 5'b00000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 0;
        distance_5 = 3'd6;
        in_5 = 5'b10001;
        expected_5 = 5'b00000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 0;
        distance_5 = 3'd4;
        in_5 = 5'b10001;
        expected_5 = 5'b10000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 0;
        distance_5 = 3'd4;
        in_5 = 5'b11111;
        expected_5 = 5'b10000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        //shift right
        direction_5 = 1;
        distance_5 = 3'd2;
        in_5 = 5'b00010;
        expected_5 = 5'b00000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 1;
        distance_5 = 3'd7;
        in_5 = 5'b00010;
        expected_5 = 5'b00000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 1;
        distance_5 = 3'd7;
        in_5 = 5'b00110;
        expected_5 = 5'b00000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 1;
        distance_5 = 3'd6;
        in_5 = 5'b10000;
        expected_5 = 5'b00000;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 1;
        distance_5 = 3'd3;
        in_5 = 5'b10001;
        expected_5 = 5'b00010;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 1;
        distance_5 = 3'd4;
        in_5 = 5'b10001;
        expected_5 = 5'b00001;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 1;
        distance_5 = 3'd2;
        in_5 = 5'b10100;
        expected_5 = 5'b00101;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);
        
        direction_5 = 1;
        distance_5 = 3'd2;
        in_5 = 5'b11111;
        expected_5 = 5'b00111;
        #5
        $display ("%b -> %b, expected %b", in_5, out_5, expected_5);


    end

endmodule