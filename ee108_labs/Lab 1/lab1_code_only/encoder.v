module encoder (
   input [7:0] in,
   output reg [2:0] out);
   
   always @(*) begin 
    case(in)
        8'b10: out = 3'b001;
        8'b100: out = 3'b010;
        8'b1000: out = 3'b011;
        8'b10000: out = 3'b100;
        8'b100000: out = 3'b101;
        8'b1000000: out = 3'b110;
        8'b10000000: out = 3'b111;
        default: out = 3'b000;
     endcase
    end
   
endmodule
