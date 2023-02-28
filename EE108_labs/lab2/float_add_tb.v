`timescale 1ns / 1ps

module float_add_tb ();
localparam N = 4'd9; // num of test cases
reg [7:0] aIn1, bIn1;
wire [7:0] result1;

reg [7:0] aInputArray [0:N-1];
reg [7:0] bInputArray [0:N-1];
reg [7:0] expected [0:N-1];
reg flag;


float_add dut(.aIn(aIn1), .bIn(bIn1), .result(result1));
integer i;

initial begin
flag = 1'b0;
//////// Test Cases provided in handout ////////
// Test 0 - exact result
aInputArray[0] = 8'b00001000;
bInputArray[0] = 8'b00000011;
expected[0]    = 8'b00001011;

// Test 1 - exact result
aInputArray[1] = 8'b00110001;
bInputArray[1] = 8'b00001100;
expected[1]    = 8'b00110111;

// Test 2 - inacurate result but no overflow
aInputArray[2] = 8'b10010010;
bInputArray[2] = 8'b01011111;
expected[2]    = 8'b10011001;

// Test 3 - saturated result 
aInputArray[3] = 8'b11111110;
bInputArray[3] = 8'b11111000;
expected[3]    = 8'b11111111;

//there is an overflow but exponent is not saturated
aInputArray[4] = 8'b10010010;
bInputArray[4] = 8'b01111111;
expected[4]    = 8'b10110000;

//result outputs 111 11111 but not because of saturation
aInputArray[5] = 8'b11111110;
bInputArray[5] = 8'b01111000;
expected[5]    = 8'b11111111;

//saturated result
aInputArray[6] = 8'b11111110;
bInputArray[6] = 8'b10011000;
expected[6]    = 8'b11111111;

//overflow result but exponent is not saturated
aInputArray[7] = 8'b10011100;
bInputArray[7] = 8'b10110010;
expected[7]    = 8'b11010000;

// bIn larger than aIn
aInputArray[8] = 8'b00011100;
bInputArray[8] = 8'b00110010;
expected[8]    = 8'b01010000;

for (i = 0; i < N; i=i+1) begin
	assign aIn1 = aInputArray[i];
	assign bIn1 = bInputArray[i];
	#10
	$display("%08b + %08b = %08b, expected = %08b", aIn1, bIn1, result1, expected[i]);
	#10
	if(result1 != expected[i]) begin
		assign flag = 1'b1;
		$display(" ERROR found :'(");
	end

end

///// Final Results Messages /////
    if (flag == 1'b0) begin
        $display("Passed float_add Test :)");
    end else begin
        $display("Failed float_bit tests :(");
    end


end
endmodule