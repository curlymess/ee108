module float_add (
    input wire [7:0] aIn,
    input wire [7:0] bIn,
    output reg [7:0] result    
);

//wire declarations
wire [7:0] big_num_aOut, big_num_bOut;

wire [4:0] shifter_out, adder_sum;
reg [4:0] adder_in_b;

wire shift_direction = 1;
wire [2:0] shift_distance = big_num_aOut[7:5] - big_num_bOut[7:5];
wire adder_cout;
wire result_selector = (big_num_aOut[7] & 1'b1) && (big_num_aOut[6] & 1'b1) && (big_num_aOut[5] & 1'b1);
wire b_selector = big_num_aOut[7:5] & big_num_bOut[7:5];

wire [2:0] overflow = big_num_aOut[7:5]+1;


// call big num first
big_number_first BIGNUM(.aIn(aIn),.bIn(bIn),.aOut(big_num_aOut), .bOut(big_num_bOut));

shifter SHIFT(.in(big_num_bOut[4:0]), .direction(shift_direction), .distance(shift_distance), .out(shifter_out));

always @(*) begin 
    if (b_selector == 1) begin
      adder_in_b = big_num_bOut[4:0];
    end else begin
      adder_in_b = shifter_out;
    end 
end

adder ADDER(.a(big_num_aOut[4:0]),.b(adder_in_b), .sum(adder_sum),.cout(adder_cout));

always @(*) begin 
    if (adder_cout == 0) begin
      result = {big_num_aOut[7:5], adder_sum};
    end else if (adder_cout == 1'b1 && result_selector == 1) begin
      result = 8'b11111111;
    end else begin
       result = {overflow, {1'b1 ,adder_sum[4:1]}};
    end 
end
endmodule