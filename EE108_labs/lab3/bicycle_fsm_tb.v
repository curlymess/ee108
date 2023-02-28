module bicycle_fsm_tb ();

reg clk, faster, slower, next, reset;
wire rear_light;


bicycle_fsm DUT(
    .clk(clk), 
    .faster(faster), 
    .slower(slower), 
    .next(next), 
    .reset(reset), 
    .rear_light(rear_light)
);


initial 
    forever
    begin
    #5 clk = 1 ; #5 clk = 0;
    end 
    
 // input stimuli
     initial begin
        #10 reset = 0; // start w/o reset
        #20 reset = 1; // reset
        #10 reset = 0;
        faster = 0;
        slower = 0;
        //$display("faster = %01d, slower = %01d, rear_light = %01d", faster, slower, rear_light);
        /////////////////////Check States ////////////////////
        #10
        next = 1;
        #100
        /////////////////////TEST FLASH 1////////////////////
        next = 0;
        slower = 1;
        #50
        slower = 0;
        faster = 1;
        #20
        faster = 0;
        ////////////////////STATE 5////////////////////
        next = 1; 
        #10
        next = 0 ;
        #10
        ///////////////////FLASH 2////////////////////
        next = 1;
        #10 next = 0;
        faster = 1;
        #50
        faster = 0;
        slower = 1;
        #50
        slower = 0;
        next = 1;
        #40
        //////////////////Test reset
        next= 0;
        slower= 1;
        #20
        slower = 0;
        next = 1;
        #20
        next = 0;
        faster = 1;
        #20;
        reset = 1;
        #10
        reset = 0;
        #30
        next = 1;
        #30
        next = 0;
        faster=1;
        #20
        faster = 0;
        
        ////////////////////////////////////TESTING FLASH 1////////////////////////////////////////////////////////////////////
        // Let blink - rate 32
       #100000
        
        //////Slow down//////
        slower = 1;
        #10
        slower = 0;
        //Let blink - rate 64
        #100000
        
        //Slow down
        slower = 1;
        #10
        slower = 0;
        //Let blink ->  rate 128
        #100000
      //Slow down
        slower = 1;
        #10        
        slower = 0;
        //let blink -> rate 256
        #100000
        slower = 1;
        #10        
        slower = 0;
        
        ////////Speed back up //////
        faster = 1;
        #10
        faster = 0;
        //Let blink - rate 128
        #100000
        
        //Slow down
        faster = 1;
        #10
        faster = 0;
        //Let blink ->  rate 64
        #100000
      //Slow down
        faster = 1;
        #10        
        faster = 0;
        //let blink -> rate 32
        #100000
        faster = 1;
        #10        
        faster = 0;
        // let blink -> rate 32
        #100000
        ////////////////////////////////////TESTING FLASH 2///////////////////////////////////////////////////////////////////
        //Change to State 6/ Flash 2
        next = 1;
        #20
        next = 0;
        //Let blink - rate 32
        #100000

        faster = 1;
        #10
        faster = 0;
        //Let blink - rate 16
        #100000
        
        //speed up
        faster = 1;
        #10
        faster = 0;
        //Let blink ->  rate 8 
        #100000
        //Speed up
        faster = 1;
        #10        
        faster = 0;
        //let blink -> rate 4
        #100000
        faster = 1;
        #10        
        faster = 0;
        //let blink -> rate 4
        #100000
        
        //////Slow down//////
        slower = 1;
        #10
        slower = 0;
        //Let blink - rate 8
        #100000
        
        //Slow down
        slower = 1;
        #10
        slower = 0;
        //Let blink ->  rate 16
        #100000
      //Slow down
        slower = 1;
        #10        
        slower = 0;
        //let blink -> rate 32
        #100000
        slower = 1;
        #10        
        slower = 0;
        //let blink -> rate 32

        #100000

        
        
        
        
        
     
        
        $stop;
     
      end

endmodule