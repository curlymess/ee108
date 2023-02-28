module blinker (input clk,
                input reset,
                input switch,
                output out);

////////// States ////////////
`define STATE_OFF   1'b0
`define STATE_ON_B    1'b1

//////// Flip-Flop //////////
// State Register
reg next_state;
wire state;
dffr state_reg (.clk(clk),      // clock
                .r(reset),      // reset signal
                .d(next_state), // input signal
                .q(state));     // flopped input signal
                
always @(*) begin
    case(state)
        `STATE_OFF: begin
            next_state = switch ? `STATE_ON_B : `STATE_OFF;
         end
        `STATE_ON_B: begin
            next_state = switch ? `STATE_OFF : `STATE_ON_B;
         end
         default: begin
            next_state = `STATE_OFF;
         end
    endcase
end

assign out = state;

endmodule