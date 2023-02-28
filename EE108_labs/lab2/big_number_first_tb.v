`timescale 1ns / 1ps

module big_number_first_tb ();

reg [7:0] aIn1, bIn1;
reg [7:0] expectedA;
wire [7:0] aOut1, bOut1;

big_number_first DUT(.aIn(aIn1), .bIn(bIn1), .aOut(aOut1), .bOut(bOut1));

initial begin

// test 1
assign aIn1 = 8'b01100000;
assign bIn1 = 8'b01000000;
assign expectedA = aIn1;
#10
$display("aIn: %08b, bIn: %08b, expected aOut: %08b, actual aOut: %08b", aIn1, bIn1, expectedA, aOut1);
#10

if(expectedA != aOut1) begin
    $display("failed");
end else begin
    $display("passed");
end

// test 2
assign aIn1 = 8'b01000000;
assign bIn1 = 8'b01100000;
assign expectedA = bIn1;
#10
$display("aIn: %08b, bIn: %08b, expected aOut: %08b, actual aOut: %08b", aIn1, bIn1, expectedA, aOut1);
#10

if(expectedA != aOut1) begin
    $display("failed");
end else begin
    $display("passed");
end

// test 3 - should return aIn despite same exponent, and bIn has a bigger mantissa
assign aIn1 = 8'b00001000;
assign bIn1 = 8'b00000011;
assign expectedA = aIn1;
#10
$display("aIn: %08b, bIn: %08b, expected aOut: %08b, actual aOut: %08b", aIn1, bIn1, expectedA, aOut1);
#10

if(expectedA != aOut1) begin
    $display("failed");
end else begin
    $display("passed");
end

end
endmodule