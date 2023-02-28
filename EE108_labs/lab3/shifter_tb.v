module shifter_tb ();
reg clk, rst, shift_left9,shift_right9, shift_left6,shift_right6;
wire [8:0] out9;
wire [5:0] out6;

shifter shifter_flash1(
    .clk(clk),
    .reset(rst),
    .shift_left(shift_left9),
    .shift_right(shift_right9),
    .out(out9)
);

shifter #(2)shift_flash2(
    .clk(clk),
    .reset(rst),
    .shift_left(shift_left6),
    .shift_right(shift_right6),
    .out(out6)
);

    
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
        #20

        ///////////////////////// Shift all the way left - FLASH1 - ///////////////////////////////////
        shift_right9 = 0;
        shift_left9 = 1;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 64", shift_left9, shift_right9, out9);
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 128", shift_left9, shift_right9, out9);
        #30
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 256", shift_left9, shift_right9, out9);
        #10
        
        
        
        /////////////////////// Turn off both lights /////////////////////////////////////////////////
        
        
        shift_right9 = 0;
        shift_left9 = 0;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 256", shift_left9, shift_right9, out9);
        
        
              
        /////////////////////// Shift all the way right - FLASH1 /////////////////////////////////////
        shift_right9 = 1;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 128", shift_left9, shift_right9, out9);
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 64", shift_left9, shift_right9, out9);
        
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 32", shift_left9, shift_right9, out9);
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d expected = 32", shift_left9, shift_right9, out9);
        #10
        shift_right9 = 0;
        
        
        
        
        //////////////////////// Test Reset /////////////////////////////////////////////////////////
        #10 
        rst = 1;
        #10
        rst = 0;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d expected = 32 ", shift_left9, shift_right9, out9);
        
        //Try shifting right from reset
        #10 
        shift_right9 = 1;
        #10 
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 32", shift_left9, shift_right9, out9);
        shift_right9 = 0;
 
        //Reset
        #10 
        rst = 1;
        #10
        rst = 0;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d expected = 32 ", shift_left9, shift_right9, out9);
        
        //Shift left from reset //
        #10 
        shift_left9 = 1;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 64", shift_left9, shift_right9, out9);
        shift_left9 = 0;
        #50
        
        
        
       ///////////////////////////////////////////////////////NOW TESTING FLASH 2//////////////////////////////////////////////////////////
       $display("/////////////////////////////////////////////NOW TESTING FLASH 2/////////////////////////////////////////////////////////");
        #10 rst = 0; // start w/o reset
        #20 rst = 1; // reset
        #10 rst = 0;
        #20

        ///////////////////////// Shift all the way right ///////////////////////////////////
        shift_right6 = 1;
        shift_left6 = 0;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 16", shift_left6, shift_right6, out6);
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 8", shift_left6, shift_right6, out6);
        #30
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 4", shift_left6, shift_right6, out6);
        #10
        
        
        
        /////////////////////// Turn off both lights /////////////////////////////////////////////////
        
        
        shift_right6 = 0;
        shift_left6 = 0;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 4", shift_left6, shift_right6, out6);
        
        
              
        /////////////////////// Shift all the way left /////////////////////////////////////
        shift_left6 = 1;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 8", shift_left6, shift_right6, out6);
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 16", shift_left6, shift_right6, out6);
        
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 32", shift_left6, shift_right6, out6);
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d expected = 32", shift_left6, shift_right6, out6);
        #10
        shift_left6 = 0;
        
        
        
        
        //////////////////////// Test Reset /////////////////////////////////////////////////////////
        #10 
        rst = 1;
        #10
        rst = 0;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d expected = 32 ", shift_left6, shift_right6, out6);
        
        //Try shifting right from reset
        #10 
        shift_right6 = 1;
        #10 
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 16", shift_left6, shift_right6, out6);
        shift_right6 = 0;
 
        //Reset
        #10 
        rst = 1;
        #10
        rst = 0;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d expected = 32 ", shift_left6, shift_right6, out6);
        
        //Shift left from reset //
        #10 
        shift_left6 = 1;
        #10
        $display("shift_left = %01d, shift_right = %01d, out = %01d, expected = 32", shift_left6, shift_right6, out6);
        shift_left6 = 0;
        #50
        $stop;
    end


endmodule