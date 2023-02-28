module wave_capture (
    input clk,
    input reset,
    input new_sample_ready,
    input [15:0] new_sample_in,
    input wave_display_idle,

    output wire [8:0] write_address,
    output wire write_enable,
    output wire [7:0] write_sample,
    output wire read_index
);

////////////// STATES //////////////
`define STATE_ARMED     2'd0
`define STATE_ACTIVE    2'd1
`define STATE_WAIT      2'd2

//////////// FLIP-FLOPS ////////////            
////// Zero Crossing
wire [15:0] curr_sample;
reg zero_crossing;
dffr #(16) zero_crossing_reg (
    .clk(clk),          // clock
    .r(reset),          // reset signal
    .d(new_sample_in),  // input signal
    .q(curr_sample));   // flopped input signal
    
always @(*) begin
    zero_crossing = ((curr_sample[15] == 0) && (new_sample_in[15] == 1));
end

////// Writing Sample
wire [15:0] write_new_sample;
dffre #(16) writing_samp_reg (
    .clk(clk),              // clock
    .r(reset),              // reset signal
    .en(new_sample_ready),  // enable signal
    .d(new_sample_in),      // input signal
    .q(write_new_sample));  // flopped input signal

assign write_sample = (write_new_sample[15:8] + 8'd128); ////// NOTE: in diagram its 7'd128 but thats not enough bits **Updated diagram
                                                             // now says 8'd128
////// Counter
wire [7:0] count;
dffre #(8) counter (
    .clk(clk),
    .en(new_sample_ready && state == `STATE_ACTIVE),
    .r(reset | (count == 8'd255)),
    .d(count + 8'b1),
    .q(count));

////// Read_Index Register
// flipflop that is enabled by if we are in the waiting state and wave display idle is high   
wire ri = ~read_index;
dffre #(.WIDTH(1)) rindex (.clk(clk), .r(reset), .en((state == `STATE_WAIT) && wave_display_idle), 
        .d(ri), .q(read_index));
        

////// State Register
reg [1:0] next_state;
wire [1:0] state;
dffr #(2) state_reg (
    .clk(clk),      // clock
    .r(reset),      // reset signal
    .d(next_state), // input signal
    .q(state));     // flopped input signal
    
// case statement
always @(*) begin
    case(state)
        `STATE_ARMED: begin
            next_state = zero_crossing ? `STATE_ACTIVE : state;
        end
        `STATE_ACTIVE: begin
            next_state = (count == 8'd255) ? `STATE_WAIT : `STATE_ACTIVE;
         end
         `STATE_WAIT: begin
            next_state = wave_display_idle ? `STATE_ARMED : `STATE_WAIT;
         end
         default: begin
            next_state = `STATE_ARMED;
         end
    endcase
end

/////////// OUTPUTS ///////////
// write_sample assigned in writing sample section
assign write_enable  = (state == `STATE_ACTIVE);
assign write_address = {~read_index, count}; 
endmodule
