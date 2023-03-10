module big_number_first (
input wire [7:0] aIn,
input wire [7:0] bIn,
output reg [7:0] aOut,
output reg [7:0] bOut
);

wire [2:0] aExp = aIn[7:5];
wire [2:0] bExp = bIn[7:5];

always @(*) begin
    if ( aExp < bExp ) begin
        aOut = bIn;
        bOut = aIn;
    end else begin
        aOut = aIn;
        bOut = bIn;
    end
end


endmodule