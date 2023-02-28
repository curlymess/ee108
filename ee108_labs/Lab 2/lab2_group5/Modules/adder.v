module adder (
    input wire [4:0] a, b,
    output wire [4:0] sum,
    output wire cout
    );
    
    wire [5:0] a_extended = {1'b0,a};
    wire [5:0] b_extended = {1'b0, b};
    wire [5:0] sum_and_cout = a_extended + b_extended;
    
    assign sum = sum_and_cout[4:0];
    assign cout = sum_and_cout[5];

endmodule


