//----------------------------------------------------
// Test bench for EE108 Lab 3 (Bicycle Light)
//----------------------------------------------------

/* For this lab, you need to include additional test cases in the testbench that
 * will show the correct implementation of the adjustable fast and slow states 
 * 
 * To make this easier, it is suggested that you run the simulations run the
 * flashing at a much faster speed for debugging.  It is possible to simulate
 * for the full seconds that the light should flash, but this would take a very
 * long time.  Instead simulate the lights flashing at a much faster speed and
 * just make sure that you can identify the doubling and halving of this speed.
 * Then slow down to the desired speed when implementing you program on the
 * chip.
 */

module lab3_top_tb();

    reg clk, rst, nxt, fast, slow;
    wire [3:0] leds;
    wire light = leds[0];

    lab3_top dut (
        .sysclk(clk),
        .btn({rst, nxt, fast, slow}),
        .leds(leds)
    );

    // Clock with period of 10 units
    initial forever begin
        #5 clk = 1;
        #2 $display("%b %b %b", rst, nxt, light);
        #3 clk = 0;
    end

    // Input stimuli
    initial begin
        #10 rst = 0; // start w/o reset to show x state
        #10 rst = 1; nxt = 0; fast = 0; slow = 0; // reset
        #10 rst = 0; // remove reset
        #20 nxt = 1; // Constant on
        #10 nxt = 0;
        #30 nxt = 1; // OFF
        #10 nxt = 0;
        #40 nxt = 1; // Flash 1
        // TODO: Add in code here to show response to fast/slow buttons
        #10 slow = 1;
        #10 slow = 0;
        #30 slow = 1;
        #10 slow = 0;
        #30 fast = 1;
        #30 fast = 0;
        
        #10 nxt = 0;
        #50 nxt = 1; // OFF
        #10 nxt = 0;
        #30 nxt = 1; // Flash
        // TODO: Add in code here to show response to up/down buttons
        
        
        
        #10 nxt = 0;
        #120 nxt = 1; // OFF
        #10 nxt = 0;
        #40;
        $stop;
    end

endmodule
