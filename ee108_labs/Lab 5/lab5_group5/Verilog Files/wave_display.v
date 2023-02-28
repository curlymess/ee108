module wave_display (
    input clk,
    input reset,
    input [10:0] x,  // [0..1279]
    input [9:0]  y,  // [0..1023]
    input valid,
    input [7:0] read_value,
    input read_index,
    output wire [8:0] read_address,
    output wire valid_pixel,
    output wire [7:0] r,
    output wire [7:0] g,
    output wire [7:0] b
);
wire [7:0] x_eight = {x[9], x[7:1]};
wire [8:0] next_read_addr;
wire [1:0] x_quad = x[9:8];
wire [7:0] read_value_adj = (read_value >> 1) + 8'd32;

/////// RAM address logic x-coor logic ///////
assign next_read_addr = (x_quad == 2'b01 || x_quad == 2'b10) ? {read_index, x_eight} : 9'b0;

dffr #(.WIDTH(9)) ram_addr(.clk(clk), .r(reset), .d(next_read_addr), .q(read_address));   

//////// valid pixel logic ///////
wire pixel_delay, pixel_delay2;
assign pixel_delay = ((x_quad == 2'b01) || (x_quad == 2'b10)) && (y[9] == 1'b0) && valid &&(!(x_quad == 2'b01 && x[7:1] <2'b11));
dffr #(.WIDTH(1)) pixel_logic (.clk(clk), .r(reset), .d(pixel_delay), .q(pixel_delay2));
dffr #(.WIDTH(1)) pixel_logic2(.clk(clk), .r(reset), .d(pixel_delay2), .q(valid_pixel));

/////// Y-coor logic ////////
wire [7:0] curr_read_value;
wire [8:0] y_nine = y[9:1];
dffre #(.WIDTH(8)) ram_value(.clk(clk), .r(reset), .en(read_address != next_read_addr), .d(read_value_adj), .q(curr_read_value));

reg [7:0] red, blue, green;
always @(*) begin 
    if(y_nine >= read_value_adj && y_nine <= curr_read_value && valid_pixel) begin 
        {red, green, blue} = 24'hFFFFFF;
    end else if (y_nine <= read_value_adj && y_nine >= curr_read_value && valid_pixel) begin 
        {red, green, blue} = 24'hFFFFFF;
    end else begin 
        {red, green, blue} = 24'h000000;
    end
end

assign r = red;
assign g = green;
assign b = blue;

endmodule
