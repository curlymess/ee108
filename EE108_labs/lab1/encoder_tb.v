module encoder_tb ();
    reg [7:0] in = 8'b00000001;
    reg [2:0] expected = 0;
    wire [2:0] out;
    encoder dut (.in(in), .out(out));
    initial begin
       repeat (8) begin
            in =  in<<1;
            expected = expected +1;
            #5
            $display("%b -> %d, expected %d", in, out, expected);
       end 
    end
endmodule
