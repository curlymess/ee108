module timer #(APPEND = 5) (
    input clk, rst,
    input [APPEND + 3:0] load_value,
    input count_en, 
    output wire out
);

reg [APPEND + 3:0] next_count;
wire [APPEND + 3:0] count, count1; 
 

dffre #(.WIDTH(APPEND + 4)) timer_value(.clk(clk), .r(rst), .en(count_en), 
        .d(next_count), .q(count));
dffr #(.WIDTH(APPEND + 4)) timer_different(.clk(clk), .r(rst), 
        .d(count), .q(count1));

always @(*) begin 
    next_count = (count==0 || count == 1) ? (load_value) : ((count!=0) ? (count - 1'b1) : 1'b1);
 
end

assign out = (count==1 && count1 != 1) ? 1:0;
endmodule
