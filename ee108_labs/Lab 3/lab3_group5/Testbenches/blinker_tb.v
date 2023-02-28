module blinker_tb ();

reg switch, expected, clk, rst;
wire out;
reg flag = 1'b0; // to tell if any cases failed

blinker dut(.clk(clk), .reset(rst), .switch(switch), .out(out));

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
        assign switch = 0;
        assign expected = 0;
        #10
        $display("switch = %01d, expected = %01d, out = %01d", switch, expected, out);
        assign switch = 0;
        assign expected = 0;
        #10
        $display("switch = %01d, expected = %01d, out = %01d", switch, expected, out);        
        assign switch = 1;
        assign expected = 1;
        #10
        $display("switch = %01d, expected = %01d, out = %01d", switch, expected, out);
        
        assign switch = 0;
        assign expected = 1;
        #10
        $display("switch = %01d, expected = %01d, out = %01d", switch, expected, out);
        
        assign switch = 1;
        assign expected = 0;
        #30
        $display("switch = %01d, expected = %01d, out = %01d", switch, expected, out);
        
        assign switch = 0;
        assign expected = 0;
        #10
        $display("switch = %01d, expected = %01d, out = %01d", switch, expected, out);
        
        #80
        $stop;
    end
endmodule