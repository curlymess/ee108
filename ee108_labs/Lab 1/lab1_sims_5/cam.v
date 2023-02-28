module cam ( input [63:0] data,
             input [3:0] data_len,
             output wire [2:0] addr,
             output wire valid);
	// wire declarations
	wire [67:0] data_word;
	wire [67:0] first_user_data = 68'h3_00000000004F454C;
	wire [67:0] second_user_data = 68'h5_0000004E4F524141;
	wire [67:0] third_user_data = 68'h5_000000594C4C4F48; 
	wire [67:0] fourth_user_data = 68'h5_0000004449564144;
	wire [67:0] fifth_user_data = 68'h6_0000455249414C43;
	wire [67:0] sixth_user_data = 68'h5_0000004B4E415246;
	wire [67:0] seventh_user_data = 68'h5_00000045434E414C;
	wire [67:0] eighth_user_data = 68'h4_000000004E415952;
	wire [7:0] entry_matches;

	// data concatenation
	assign data_word = {data_len,data};
	
	// 8 equality comparisons
	assign entry_matches[0] = (data_word == first_user_data);
	assign entry_matches[1] = (data_word == second_user_data);
	assign entry_matches[2] = (data_word == third_user_data);
	assign entry_matches[3] = (data_word == fourth_user_data);
	assign entry_matches[4] = (data_word == fifth_user_data);
	assign entry_matches[5] = (data_word == sixth_user_data);
	assign entry_matches[6] = (data_word == seventh_user_data);
	assign entry_matches[7] = (data_word == eighth_user_data);
	
	// encoder instantiation
	encoder ENC(.in(entry_matches), .out(addr));
	// valid logic
	assign valid = entry_matches[0] | entry_matches[1] | entry_matches[2] | entry_matches[3] | entry_matches[4]
	| entry_matches[5] | entry_matches[6] | entry_matches[7];
	
endmodule
