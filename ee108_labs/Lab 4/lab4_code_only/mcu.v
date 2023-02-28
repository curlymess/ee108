module mcu(
    input clk,
    input reset,
    input play_button,
    input next_button,
    input song_done,
    output play,
    output reset_player,// high when changing songs
    output [1:0] song   // song to play
);

///////// States /////////
// PAUSES
`define PAUSE_0     3'd0
`define PAUSE_1     3'd1
`define PAUSE_2     3'd2
`define PAUSE_3     3'd3
// SONGS
`define SONG_0      3'd4
`define SONG_1      3'd5
`define SONG_2      3'd6
`define SONG_3      3'd7


//////// Flip-Flop //////////
reg [2:0] next_state;
wire [2:0] state;
dffr #(3) state_reg (.clk(clk),     // clock
                    .r(reset),      // reset signal
                    .d(next_state), // input signal
                    .q(state));     // flopped input signal

reg [1:0] sng; // for song #
/////////// Conditionals ////////////
always @(*) begin         
        case(state)
            `PAUSE_0:
            begin
                if(play_button) begin
                    next_state = `SONG_0;
                    sng = 2'd0;
                end else if(next_button || song_done) begin
                    next_state = `PAUSE_1;
                    sng = 2'd1;
                end else begin
                    next_state = `PAUSE_0;
                    sng = 2'd0;
                end
            end
             `SONG_0: begin
                if(play_button) begin
                    next_state = `PAUSE_0;
                    sng = 2'd0;
                end else if(next_button || song_done) begin
                    next_state = `PAUSE_1;
                    sng = 2'd1;
                end else begin
                    next_state = `SONG_0;
                    sng = 2'd0;
                end
            end
            `PAUSE_1: 
            begin
                if(play_button) begin
                    next_state = `SONG_1;
                    sng = 2'd1;
                end else if(next_button || song_done) begin
                    next_state = `PAUSE_2;
                    sng = 2'd2;
                end else begin
                    next_state = `PAUSE_1;
                    sng = 2'd1;
                end
            end
             `SONG_1: 
             begin
                if(play_button) begin
                    next_state = `PAUSE_1;
                    sng = 2'd1;
                end else if(next_button || song_done) begin
                    next_state = `PAUSE_2;
                    sng = 2'd2;
                end else begin
                    next_state = `SONG_1;
                    sng = 2'd1;
                end
            end
            `PAUSE_2: 
            begin
                if(play_button) begin
                    next_state = `SONG_2;
                    sng = 2'd2;
                end else if(next_button || song_done) begin
                    next_state = `PAUSE_3;
                    sng = 2'd3;
                end else begin
                    next_state = `PAUSE_2;
                    sng = 2'd2;
                end
            end
             `SONG_2: begin
                if(play_button) begin
                    next_state = `PAUSE_2;
                    sng = 2'd2;
                end else if(next_button || song_done) begin
                    next_state = `PAUSE_3;
                    sng = 2'd3;
                end else begin
                    next_state = `SONG_2;
                    sng = 2'd2;
                end
            end
            `PAUSE_3: 
            begin
                if(play_button) begin
                    next_state = `SONG_3;
                    sng = 2'd3;
                end else if(next_button || song_done) begin
                    next_state = `PAUSE_0;
                    sng = 2'd0;
                end else begin
                    next_state = `PAUSE_3;
                    sng = 2'd3;
                end
            end
             `SONG_3: 
             begin
                if(play_button) begin
                    next_state = `PAUSE_3;
                    sng = 2'd3;
                end else if(next_button || song_done) begin
                    next_state = `PAUSE_0;
                    sng = 2'd0;
                end else begin
                    next_state = `SONG_3;
                    sng = 2'd3;
                end
            end
            default: begin
                next_state = `PAUSE_0;
                sng = 2'd0;
            end                   
        endcase
end



///////// Outputs /////////
assign play = (state > 3'd3) ? 1 : 0;
assign reset_player = next_button || song_done || reset;
assign song = sng;
endmodule
