module master_fsm_tb ();
reg clk, nxt, rst, fast, slow;
wire left1, left2, right1, right2;
wire [2:0] out;

master_fsm dut(.clk(clk), .next(nxt), .reset(rst), .faster(fast), .slower(slow), .out(out), .shift_left1(left1), .shift_right1(right1), .shift_left2(left2), .shift_right2(right2));

 initial 
     forever
     begin 
        #5 clk = 1; #5 clk = 0;
     end
   // input stimuli
   initial begin 
        #10 rst = 0;
        #20 rst = 1;
        #10 rst = 0;
        #30
   // test cases begin
        // default case - OFF1
        fast = 0;
        slow = 0;
        nxt = 0;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);
        
        // move to ON
        nxt = 1;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);        
        
        // move to OFF2
        //nxt = 1;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);        
        
        // move to FLASH1
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);        
        
        // move to OFF3
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);
        
        // move to FLASH2
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);
        
        // move back to OFF1
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);
        
        // at OFF1, move faster -- expect nothing to happen and stay OFF1
        nxt = 0;
        fast = 1;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);
        
        // at OFF1, move slower -- expect nothing to happen and stay OFF1
        fast = 0;
        slow = 1;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);
        
        // nxt and slow on, expect to only move to ON
        nxt = 1;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);
        
        // move to FLASH1 -- disregard slow on
        #10
        nxt = 1;
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);
        
  /// start seeing shift values take effect  
        $display("/// FLASH1 ///");        
        // at FLASH1 -- move faster -- stay at default 1s
        fast = 1;
        slow = 0;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH1 -- move slower -- go to 2s 
        nxt = 0;
        fast = 0;
        slow = 0;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH1 -- move slower -- go to 2s 
        nxt = 0;
        fast = 0;
        slow = 1;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH1 -- move slower -- go to 4s
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH1 -- move slower -- go to 8s
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH1 -- move slower -- stay at 8s
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH1 -- move faster -- go to 4s
        fast = 1;
        slow = 0;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH1 -- move faster -- go to 4s
        fast = 0;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);


        $display("/// Making way to FLASH2 ///");        
        // move to OFF3
        nxt = 1;
        fast = 0;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);


///FLASH2
        $display("/// FLASH2 ///");

        // move to FLASH2
        nxt = 1;
        fast = 0;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH2 -- at 1s
        nxt = 0;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH2 -- slower -- stay at 1s
        slow = 1;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH2 -- faster -- 1/2s
        slow = 0;
        fast = 1;
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH2 -- faster -- 1/4s
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        // at FLASH2 -- faster 1/8s
        #10
        $display("next = %d, faster = %d, slower = %d -> out = %d, shift_left1 = %d, shift_right1 = %d, shift_left2 = %d, shift_right2 = %d", nxt, fast, slow, out, left1, right1, left2, right2);

        #80
        $stop;
   end
endmodule