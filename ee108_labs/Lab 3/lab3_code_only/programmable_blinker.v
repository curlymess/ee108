module programmable_blinker #(APPEND = 5) (input clk,
                            input rst,
                            input count_en,
                            input shift_left,
                            input shift_right,
                            output out);

// call shifter
wire [APPEND + 3:0] shift_out;
shifter #(APPEND) shift(.clk(clk), .reset(rst), .shift_left(shift_left), .shift_right(shift_right), .out(shift_out));

// call timer
wire timer_out;
timer #(APPEND) tim(.clk(clk), .rst(rst), .load_value(shift_out), .count_en(count_en), .out(timer_out));

// call blinker
//wire blink_out;
blinker blink(.clk(clk), .reset(rst), .switch(timer_out), .out(out));

//assign out = blink_out;

endmodule