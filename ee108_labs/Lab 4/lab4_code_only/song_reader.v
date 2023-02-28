module song_reader(
    input clk,
    input reset,
    input play,
    input [1:0] song,
    input note_done,
    output song_done,
    output [5:0] note,
    output [5:0] duration,
    output new_note
);
//STATES
`define STATE_PAUSED       3'd0 
`define STATE_RETRIEVING   3'd1
`define STATE_LOAD         3'd2
`define STATE_WAITING      3'd3
`define STATE_INCREMENT    3'd4

//SONG STATES
`define SONG0 7'd0
`define SONG1 7'd32
`define SONG2 7'd64
`define SONG3 7'd96
//FLIP-FLOP
wire [2:0] state;
reg [2:0] next_state;
wire [6:0] count;
//OTHER
reg [6:0] addr; 
wire [11:0] rom_out; 
reg nn; // new note 


// Get starting position for song
always @(*) begin
    case (song)
        2'd0 : addr = `SONG0;
        2'd1 : addr = `SONG1;
        2'd2 : addr = `SONG2;
        2'd3 : addr = `SONG3;
        default : addr = 7'd0;
    endcase
end

//////////FLIP-FLOPS//////////////
// State Flip-Flop
dffr #(3) state_reg (.clk(clk),     // clock
                    .r(reset),      // reset signal
                    .d(next_state), // input signal
                    .q(state));     // flopped input signal
// Increment Address Flip-Flop
dffre #(7) addr_counter (
        .clk(clk),
        .en(state == `STATE_INCREMENT),
        .r(reset | (count == 7'd32)), // 31 or 32
        .d(count + 1'b1),
        .q(count)
    );
 
//wire [6:0] rom_in = addr + count;
song_rom song_rom1(.clk(clk), .addr(addr+count), .dout(rom_out));

///// CASE STATEMENTS ////////
always @(*) begin  
    case (state)
        `STATE_PAUSED: begin
            next_state = play ? `STATE_RETRIEVING : state;
            nn = 1'b0;
        end
        `STATE_RETRIEVING: begin
            next_state = play ? `STATE_LOAD : `STATE_PAUSED;
            nn = 1'b0;
        end
        `STATE_LOAD: begin
            next_state = play ? `STATE_WAITING : `STATE_PAUSED;
            nn = 1'b1;
        end
        `STATE_WAITING: begin
          // next_state = play ? `STATE_PAUSED: note_done ? `STATE_INCREMENT : state;
           nn = 1'b0;

            if(play) begin // prioritize play being pressed and interrupting the cycle
                next_state = note_done || (duration == 6'd0) ? `STATE_INCREMENT : state;
            end else begin
                next_state = `STATE_PAUSED;

            end
        end
        `STATE_INCREMENT: begin
            if(play) begin // prioritize play being pressed and interrupting the cycle
                next_state = song_done ? `STATE_PAUSED:`STATE_RETRIEVING;
            end else begin
                next_state = `STATE_PAUSED;

            end
           // next_state = play ? `STATE_PAUSED: song_done ? `STATE_PAUSED : `STATE_RETRIEVING;
            nn = 1'b0;
        end
        default: begin
            next_state = `STATE_PAUSED;
            nn = 1'b0;
        end
    endcase 
end

////// OUTPUTS /////
assign song_done = (count == 7'd31);
assign duration = rom_out [5:0];
assign note =  rom_out[11:6];
assign new_note = nn;

endmodule



