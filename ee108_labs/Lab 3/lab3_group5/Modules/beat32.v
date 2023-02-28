module beat32 #(parameter N=4)
(
    input clk, rst,
    output done
);

//Value Register
reg [N-1:0] next_value;
wire [N-1:0] value;
wire finished_count;

dffr #(.WIDTH(N)) value_reg (.clk(clk), .r(rst), .d(next_value), .q(value));


always @(*) begin 
    next_value = finished_count ? 4'b0 : (value + 1);
end

assign finished_count = (value == 22'd4);
assign done = (value == 0);

endmodule



