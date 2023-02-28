module master_fsm (input clk, 
                   input next, // means button was pressed to go to next state
                   input reset,
                   input faster, 
                   input slower,
                   output [2:0] out,
                   output shift_left1,
                   output shift_right1,
				   output shift_left2,
				   output shift_right2);
				   
///////// States /////////
`define STATE_OFF1      3'd0 
`define STATE_ON        3'd2
`define STATE_OFF2      3'd3
`define STATE_FLASH1    3'd4
`define STATE_OFF3      3'd5
`define STATE_FLASH2    3'd6

//////// Flip-Flop //////////
reg [2:0] next_state;
wire [2:0] state;
dffr #(3) state_reg (.clk(clk),     // clock
                    .r(reset),      // reset signal
                    .d(next_state), // input signal
                    .q(state));     // flopped input signal

reg left1, right1, left2, right2;

/////////// Conditionals ////////////
 always @(*) begin
        case (state)
        `STATE_OFF1: begin
            next_state = next ? `STATE_ON : state;
        end    
        `STATE_ON: begin
            next_state = next ? `STATE_OFF2 : state;
        end
        `STATE_OFF2: begin
            next_state = next ? `STATE_FLASH1 : state;
        end
        `STATE_FLASH1: begin
            next_state = next ? `STATE_OFF3 : state;
        end
        `STATE_OFF3: begin
            next_state = next ? `STATE_FLASH2 : state;
        end
        `STATE_FLASH2: begin
            next_state = next ? `STATE_OFF1 : state;
        end
        default: begin
            next_state = `STATE_OFF1;
        end    
        endcase
        
    if((slower || faster) && (state == `STATE_FLASH1 || state == `STATE_FLASH2) && !next) begin
        case(state)
            `STATE_FLASH1: begin
                left1  = slower ? 1:0;
                right1 = faster ? 1:0;
                left2 = 0;
                right2 = 0;

            end
            `STATE_FLASH2: begin
                left2  = slower ? 1:0;
                right2 = faster ? 1:0;
                left1 = 0;
                right1 = 0;

            end
            default: begin
        //        next_state = state;
                left1 	= 0;
                right1	= 0;
				left2 	= 0;
                right2 	= 0;
            end
        endcase
    end else begin 
		left1 	= 0;
        right1 	= 0;
		left2 	= 0;
        right2 	= 0;
		//next_state = state;
	end
end

///////// Outputs /////////
assign out = state;
assign shift_left1 	= left1;
assign shift_right1 = right1;
assign shift_left2 	= left2;
assign shift_right2 = right2;

endmodule