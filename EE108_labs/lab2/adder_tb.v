`timescale 1s / 1ps

module adder_tb ();
// adder only works for two 5-bit inputs

reg [4:0] a5, b5;
reg [5:0] expected5;
wire [4:0] sum5;
wire cout5;
reg flag = 1'b0; // to tell if any cases failed

adder dut(.a(a5), .b(b5), .sum(sum5), .cout(cout5));

integer i, k;
initial begin

    for(i = 0; i < 32; i=i+1) begin
    assign a5 = i;
       for( k=0; k < 32; k=k+1) begin
            assign b5 = k;
            
            assign expected5 = a5 + b5;
            #10
            $display("%03d + %03d = %03d -- Expected %03d ", a5, b5, {cout5,sum5}, expected5);
           
            if(expected5 != {cout5, sum5}) begin
                assign flag = 1'd1;
            end
        end
    end
    
///// Final Results Messages /////
    if (!flag) begin
        $display("Passed 5-bit Addition Test :)");
    end else begin
        $display("Failed 5-bit Addition tests :(");
    end

end
endmodule