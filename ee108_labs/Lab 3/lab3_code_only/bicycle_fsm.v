// Bicycle Light FSM
//
// This module determines how the light functions in the given state and what
// the next state is for the given state.
// 
// It is a structural module: it just instantiates other modules and hooks
// up the wires between them correctly.

/* For this lab, you need to implement the finite state machine following the
 * specifications in the lab hand-out */

module bicycle_fsm(
    input clk, 
    input faster, 
    input slower, 
    input next, 
    input reset, 
    output reg rear_light
);

//Master FSM wires
wire [2:0] out_MFSM;
wire shift_left1, shift_right1;
wire shift_left2, shift_right2;

//Beat32 Wires
wire count_en;

//Programmable Blinker Output wires
wire flash1_out;
wire flash2_out;

beat32  beat(
    .clk(clk),
    .rst(reset),
    .done(count_en)
);



///////// States /////////
master_fsm masterFSM (
    .clk(clk),
    .next(next),
    .reset(reset),
    .faster(faster),
    .slower(slower),
    .out(out_MFSM),
    .shift_left1(shift_left1),
    .shift_right1(shift_right1),
    .shift_left2(shift_left2),
    .shift_right2(shift_right2)
);



programmable_blinker#(5) flash1(
    .rst(reset),
    .clk(clk),
    .count_en(count_en),
    .shift_left(shift_left1),
    .shift_right(shift_right1),
    .out(flash1_out)
);


programmable_blinker#(2) flash2(
    .rst(reset),
    .clk(clk),
    .count_en(count_en),
    .shift_left(shift_left2),
    .shift_right(shift_right2),
    .out(flash2_out)
);

always @(*) begin
    if (out_MFSM == 3'd2) begin
        rear_light = 1'd1;
    end else if (out_MFSM == 3'd4) begin
        rear_light = flash1_out;
    end else if (out_MFSM == 3'd6) begin
        rear_light = flash2_out;
    end else begin
        rear_light = 1'd0;
    end 
end

endmodule



