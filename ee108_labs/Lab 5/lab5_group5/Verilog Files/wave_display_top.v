module wave_display_top(
    input clk,
    input reset,
    input new_sample,
    input [15:0] sample,
    input [10:0] x,  // [0..1279]
    input [9:0]  y,  // [0..1023]     
    input valid,
    input vsync,
    output [7:0] r,
    output [7:0] g,
    output [7:0] b
);

// wc output
wire read_index; // wc output, wd input
wire write_enable;
wire [7:0] write_sample, write_address; // wc output, ram input

// wd output
wire valid_pixel;
wire [8:0] read_addr;

// ram output
wire [7:0] read_value; // ram output, wd input

wave_capture wc (.clk(clk), .reset(reset), .new_sample_ready(new_sample), .new_sample_in(sample), .wave_display_idle(vsync),
    .write_address(write_address), .write_enable(write_enable), . write_sample(write_sample), . read_index(read_index));

// can leave out douta empty as we don't care about it
ram_1w2r ram (.clka(clk), .wea(write_enable), .addra(write_address), .dina(write_sample), .douta(), 
              .clkb(clk), .addrb(read_addr), .doutb(read_value));

wave_display wd (.clk(clk), .reset(reset), .x(x), .y(y), .valid(valid), .read_value(read_value),
    .read_index(read_index), .read_address(read_addr), .valid_pixel(valid_pixel), .r(r), .g(g), .b(b));


endmodule
