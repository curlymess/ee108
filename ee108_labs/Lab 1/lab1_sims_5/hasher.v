module hasher (
        input wire [3:0] data_len,
        input wire [63:0] data,
        output wire [31:0] hash
);
        wire [7:0] a, b, c, d, e,f, g,h;
        assign {h,g,f,e,d,c,b,a} = data;
        wire [31:0] out_0, out_1, out_2,out_3, out_4,out_5, out_6, out_7;
        wire [31:0] final_state;
        
        hash_round #(.ROUND(0)) HASH0(.in_state(32'h55555555), .in_byte(a), .out_state(out_0));
        hash_round #(.ROUND(1)) HASH1(.in_state(32'hAAAAAAAA), .in_byte(b), .out_state(out_1));
        hash_round #(.ROUND(2)) HASH2(.in_state(out_0), .in_byte(c), .out_state(out_2));
        hash_round #(.ROUND(3)) HASH3(.in_state(out_1), .in_byte(d), .out_state(out_3));
        hash_round #(.ROUND(4)) HASH4(.in_state(out_2), .in_byte(e), .out_state(out_4));
        hash_round #(.ROUND(5)) HASH5(.in_state(out_3), .in_byte(f), .out_state(out_5));
        hash_round #(.ROUND(6)) HASH6(.in_state(out_4), .in_byte(g), .out_state(out_6));
        hash_round #(.ROUND(7)) HASH7(.in_state(out_5), .in_byte(h), .out_state(out_7));
        assign final_state = (out_6^out_7);
        
        rotator #(.WIDTH(32), .DISTANCE(5)) ROTATE(.in(final_state), .out(hash), .distance(final_state[4:0]), 
                                                    .direction(^data_len));

endmodule
