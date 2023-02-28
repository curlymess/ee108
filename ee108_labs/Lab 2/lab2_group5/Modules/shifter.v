module shifter #(parameter WIDTH=5) 
(
    input  wire [WIDTH-1:0] in,
    input  wire  direction,
    input  wire [2:0] distance,
    output wire [WIDTH-1:0] out
);

	// Declarations
    wire[WIDTH-1:0] rot_left, rot_right;

	   // right rotation - >> shift
      assign rot_right = in >> distance; 
               
	   // left rotation  - << shift
	   assign rot_left = in << distance;
	   
	// Output mux logic - ternary operator
	   // tells us what direction to use
	assign out = direction ? rot_right : rot_left;
	
endmodule


