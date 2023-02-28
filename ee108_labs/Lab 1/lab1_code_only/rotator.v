module rotator #(parameter WIDTH=8, parameter DISTANCE=8) //distance parameterized is optional, will be fixed at 8
(
    input  wire [WIDTH-1:0] in,
    input  wire  direction,
    input  wire [DISTANCE-1:0] distance,
    output wire [WIDTH-1:0] out
);

	// Declarations
    wire[WIDTH*2-1:0] double_in, double_rot_left, double_rot_right; 
    wire[WIDTH-1:0] rot_left, rot_right;
	
	// Rotating logic
	   // double_in - replication operator
	assign double_in = {2{in}};

	   // right rotation - >> shift
      assign double_rot_right = double_in >> distance; 
      assign rot_right = double_rot_right[WIDTH-1:0];
               
	   // left rotation  - << shift
	   assign double_rot_left = double_in << distance;
	   assign rot_left = double_rot_left[WIDTH*2 - 1: WIDTH];
	   
	// Output mux logic - ternary operator
	   // tells us what direction to use
	assign out = direction ? rot_left : rot_right;
	
endmodule
