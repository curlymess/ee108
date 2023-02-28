  module note_player(
    input clk,
    input reset,
    input play_enable,           // When high we play, when low we don't.
    input [5:0] note_to_load,    // The note to play
    input [5:0] duration_to_load,// The duration of the note to play
    input load_new_note,         // Tells us when we have a new note to load
    output done_with_note,       // When we are done with the note this stays high.
    input beat,                  // This is our 1/48th second beat
    input generate_next_sample,  // Tells us when the codec wants a new sample
    output [15:0] sample_out,    // Our sample output
    output new_sample_ready      // Tells the codec when we've got a sample
);

//////////INSTANTIATONS///////////
wire [19:0] freqrom_out_stepsize; //step size
frequency_rom freqrom(.clk(clk), .addr(note_to_load), .dout(freqrom_out_stepsize));

////////FREQROM AND SINE READER////////
wire [5:0] next_note_to_load;
dffre #(.WIDTH(6)) note_load(.clk(clk), .r(reset), .en(load_new_note), 
        .d(note_to_load), .q(next_note_to_load));
        

//////////ASSIGN OUTPUTS//////////
sine_reader sineread(.clk(clk), .reset(reset), .step_size(freqrom_out_stepsize), 
                        .generate_next(generate_next_sample && play_enable), .sample_ready(new_sample_ready), 
                        .sample(sample_out));

/////////DURATION COUNTER////////
wire [5:0] next_count;
wire [5:0] count;
 wire[5:0] count1;
dffre #(.WIDTH(6)) timer_counter(.clk(clk), .r(reset), .en(play_enable && beat), 
         .d(next_count), .q(count));
dffr #(.WIDTH(6)) timer_different(.clk(clk), .r(reset), 
        .d(count), .q(count1));

         
assign next_count = (count == 6'b0 || load_new_note) ? duration_to_load : (count - 6'd1);
assign done_with_note = (count==1 && count1 != 1) ? 1:0;


endmodule