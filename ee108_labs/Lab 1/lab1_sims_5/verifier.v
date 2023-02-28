module verifier ( input wire [63:0] password, 
                  input wire [63:0] username,
                  input wire valid );

	wire [3:0] pass_length_out, user_length_out;
	wire [31:0] hash_out, pass_rom_out;
	wire [2:0] user_cam_addr; 
	wire user_cam_valid, out;
	
	length_finder LFUSER(.string(username), .length(user_length_out)); 
	length_finder LFPASS(.string(password), .length(pass_length_out));
	
	hasher HASHPASS(.data_len(pass_length_out), .data(password), .hash(hash_out));
	
	cam USERCAM(.data_len(user_length_out), .data(username), .addr(user_cam_addr), .valid(user_cam_valid));
	
	hash_rom PASSROM(.addr(user_cam_addr), .data(pass_rom_out));
	
	assign out = (hash_out == pass_rom_out);
	assign valid = out & user_cam_valid; 
endmodule
