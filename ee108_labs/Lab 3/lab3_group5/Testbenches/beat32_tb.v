module beat32_tb ();
    reg clk;
    reg rst;
    wire done;
    
    beat32 DUT(.clk(clk), .rst(rst), .done(done));
    
   initial 
        forever
        begin 
        #5 clk = 1; #5 clk = 0;
        end
   //input stimuli
   initial begin 
        #10 rst = 0;
        #20 rst = 1;
        #10 rst = 0;
        #200
        #20 rst = 1;
        #10 rst = 0;
        #200
        $stop ;
   end
endmodule