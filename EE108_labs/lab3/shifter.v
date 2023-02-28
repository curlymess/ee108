module shifter #(parameter APPEND = 5) 
(
    input clk,
    input reset,
    input shift_left,
    input shift_right,
    output [APPEND + 3:0] out

);

// States
`define STATE_1		    4'b0001
`define STATE_2         4'b0010
`define STATE_4         4'b0100
`define STATE_8         4'b1000

wire [3:0] state;
reg  [3:0] next_state;

// State Register
dffr #(.WIDTH(4)) value_reg(.clk(clk), .r(reset), .d(next_state), .q(state));

always @(*) begin
        case (state) 
            `STATE_1: begin
                if(shift_left || shift_right) begin
                    next_state = shift_left ? `STATE_2 : `STATE_1;
                end else begin
                    next_state = state;
                end
            end 
            `STATE_2: begin
                if(shift_left || shift_right) begin
                    next_state = shift_left ? `STATE_4 : `STATE_1;
                end else begin 
                    next_state = state;
                end
            end
            `STATE_4: begin
                if(shift_left || shift_right) begin
                    next_state = shift_left ? `STATE_8 : `STATE_2;
                end else begin
                    next_state = state;
                end
            end
            `STATE_8: begin
                if(shift_left || shift_right) begin
                    next_state = shift_left ? `STATE_8 : `STATE_4;
                end else begin
                    next_state = state;
                end
            end
            default: begin
                if (APPEND == 5) begin
                    next_state = `STATE_1;
                end else begin
                    next_state = `STATE_8;
                end
            end
    endcase
end
 
assign out = {state, {APPEND{1'b0}}}; // add APPEND # of 0s after state
    
    
endmodule