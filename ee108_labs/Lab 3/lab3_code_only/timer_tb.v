module timer_tb ();

reg clk, rst, count_en;
reg [8:0] load_value1;
reg [5:0] load_value2;
wire out1, out2;

timer #(5) timer1 (.clk(clk), .rst(rst), .load_value(load_value1), .count_en(count_en), .out(out1));
timer #(2) timer2 (.clk(clk), .rst(rst), .load_value(load_value2), .count_en(count_en), .out(out2));


// clock with period of 10 units
initial
    forever
    begin
    #5 clk = 1 ; #5 clk = 0;
    end 
    
// input stimuli
//flash1 timer
  initial begin
        #10 rst = 0; count_en = 0; // start w/o reset
        #20 rst = 1; count_en = 0; // reset
        #10 rst = 0; count_en = 0;
        #30
        // flash1 case
        count_en = 1'b0;
        load_value1 = 9'd0; 
        load_value2 = 6'd0;
        #10
        count_en = 1'b1; 
        load_value1 = 9'd8;
        load_value2 = 6'd14;
        #70
        count_en = 0;
        load_value1 = 9'd32;
        #10
        count_en = 1;
        #100
        #10
        rst = 0;
        count_en = 1;
        load_value1 = 9'd16;
        #80
        count_en = 0; 
        #30
        count_en = 1;
        #80
        rst = 1; 
        #40
        rst = 0;
        #60
        count_en = 0; 
        #20
        count_en = 1;
        #40
       
        //flash2 case
        load_value2 = 6'd20;
        #80
        count_en = 0;
        #30
        count_en = 1;
        load_value2 = 6'd10;
        #60
        rst = 1; 
        #20
        rst = 0; 
        #100
                      
        $stop;
        
        end
endmodule 