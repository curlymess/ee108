`timescale 1s / 1ps

module n_bit_multiplier_tb ();

reg [3:0] a4, b4;
reg [4:0] a5, b5;
reg [7:0] expected4;
reg [9:0] expected5;

wire [7:0] out4;
wire [9:0] out5;
reg flag4 = 0; // to tell if any test cases have failed
reg flag5 = 0;

n_bit_multiplier #(4) FOUR_BIT(.a(a4), .b(b4), .p(out4));
n_bit_multiplier #(5) FIVE_BIT(.a(a5), .b(b5), .p(out5));

integer i, k, m, n;
initial begin
/// 4 bit multiplier test ////
    for( i = 0; i < 16; i=i+1) begin
    assign a4 = i;
    
        for ( k = 0; k < 16; k=k+1) begin
            assign b4 = k;
            #10
            assign expected4 = a4 * b4;
            $display("%03d * %03d = %03d ", a4, b4, out4) ;
            #10
            if(expected4 != out4) begin
                assign flag4 = 1'd1;
            end
        end
    end
    #100


//// 5-bit multiplier test /////
    for( m = 0; m < 32; m=m+1) begin
    assign a5 = m;
    
        for ( n = 0; n < 32; n=n+1) begin
            assign b5 = n;
            #10
            assign expected5 = a5 * b5;
            $display("%03d * %03d = %03d ", a5, b5, out5) ;
            #10
            if(expected5 != out5) begin
                assign flag5 = 1'd1;
            end
        end
    end
    #100
    
 //// Final Results Messages ////
    if (!flag4 && !flag5) begin
        $display("Passed 4 and 5 bit Multiplier Tests! :)))");
    end else begin
        if(!flag4) begin
            $display("Passed 4-bit Multiplier tests!");
        end else begin
            $display("Failed 4-bit Multiplier tests :(");
        end
        
        if(!flag5) begin
            $display("Passed 5-bit Multiplier tests!");
        end else begin
            $display("Failed 5-bit Multiplier tests :(");
        end
     end
end
endmodule
