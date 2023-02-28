module sine_reader(
    input clk,
    input reset,
    input [19:0] step_size,
    input generate_next,
    output sample_ready,
    output wire [15:0] sample
);

/////////GENERATE SAMPLES/////////
wire delay_generate_next;
//wire delay_2;
dffr #(.WIDTH(1)) sample_delay(.clk(clk), .r(reset),.d(generate_next), .q(delay_generate_next));
dffr #(.WIDTH(1)) gen_sample(.clk(clk), .r(reset), .d(delay_generate_next), .q(sample_ready));
//dffr #(.WIDTH(1)) gen_sample2(.clk(clk), .r(reset), .d(delay_2), .q(sample_ready));

////////GENERATE SINE WAVE///////
wire [21:0] curr_addr;
dffre #(.WIDTH(22)) get_addr(.clk(clk), .r(reset),.en(generate_next), .d(curr_addr+step_size), .q(curr_addr));

///////SINE_ROM///////////
reg [9:0] rom_input;
reg [15:0] rom_output;
wire[15:0] dout;

sine_rom sinerom(.clk(clk), .addr(rom_input), .dout(dout));

always @(*) begin
    rom_input = (curr_addr[21:20] == 2'b01 || curr_addr[21:20] == 2'b11) 
                    ? (10'd1023 - curr_addr[19:10]) : curr_addr[19:10]; 
    rom_output = (curr_addr[21:20] == 2'b10 || curr_addr[21:20] == 2'b11)
                    ? (0-dout) : dout;
end

assign sample = rom_output;

endmodule
