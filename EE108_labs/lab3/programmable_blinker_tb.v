module programmable_blinker_tb ();

reg clk, rst, count_en1, left1, right1, count_en2, left2, right2;
wire out1, out2;

programmable_blinker #(5) flash1(.clk(clk), .rst(rst), .count_en(count_en1), .shift_left(left1), .shift_right(right1), .out(out1));
programmable_blinker #(2) flash2(.clk(clk), .rst(rst), .count_en(count_en2), .shift_left(left2), .shift_right(right2), .out(out2));

// clock with period of 10 units
initial
    forever
    begin
    #5 clk = 1 ; #5 clk = 0;
    end 
    
 // input stimuli
     initial begin
        #10 rst = 0; // start w/o reset
        #20 rst = 1; // reset
        #10 rst = 0;
        #30
        
        // stimulus
        // flash1 testing
        right1 = 0;
        count_en1 = 1;
        left2 = 0;
        right2 = 0;
        count_en2 = 0;
        
        
        // wait until first clock cycle (needs to count down from 512) finishes
        while(out1 != 1) begin
            #10;
        end
        
        left1 = 1;
        #5
        // Test 0 - expected 1
        $display("count_en = %d, shift_left = %d, shift_right = %d -> out = %d", count_en1, left1, right1, out1);
        #5
        left1=0;
        
        #10000
   /*     
        // Test 1 - expected 0
        left1 = 0;
        right1 = 1;
        //count_en1 = 0;
        $display("count_en = %d, shift_left = %d, shift_right = %d -> out = %d", count_en1, left1, right1, out1);
        #10000
        
        left1 = 0;
        right1 = 1;
        //count_en1 = 1;
        $display("count_en = %d, shift_left = %d, shift_right = %d -> out = %d", count_en1, left1, right1, out1);
        #10000

        // Test 2 - expected 1
        count_en1 = 1;
        #100
        $display("count_en = %d, shift_left = %d, shift_right = %d -> out = %d", count_en1, left1, right1, out1);
*/
        ///// FLASH2 testing
        // Test 3 - expected 0
        #10
        $display("count_en = %d, shift_left = %d, shift_right = %d -> out = %d", count_en2, left2, right2, out2);
        
        // Test 4
        left2 = 1;
        #100
        $display("count_en = %d, shift_left = %d, shift_right = %d -> out = %d", count_en2, left2, right2, out2);

        // Test 5
        count_en2 = 1;
        #1000
        $display("count_en = %d, shift_left = %d, shift_right = %d -> out = %d", count_en2, left2, right2, out2);

        // Test 6
        left2 = 0;
        right2 = 1;
        #10 
        right2 = 0;
        #1000
        $display("count_en = %d, shift_left = %d, shift_right = %d -> out = %d", count_en2, left2, right2, out2);

        // Test 7
        count_en2 = 1;
        right2 = 1;
        #10 
        right2 = 0;
        #100
        $display("count_en = %d, shift_left = %d, shift_right = %d -> out = %d", count_en1, left1, right1, out1);
                     
      
   
   $stop;
    end
   

endmodule
