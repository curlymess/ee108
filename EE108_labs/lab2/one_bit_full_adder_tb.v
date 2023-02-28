`timescale 1ns / 1ps

module one_bit_full_adder_tb ();

reg a1, b1, cin1;
reg expectedSum, expectedCout;
wire sum;
wire cout1;
reg flag = 0; // to tell if any cases failed

one_bit_full_adder dut(.a(a1), .b(b1), .cin(cin1), .cout(cout1), .s(sum)); 

integer i, j, k;
initial begin

	for ( i = 0; i < 2; i=i+1) begin
	assign a1 = i;
		for ( j = 0; j < 2; j=j+1) begin
		assign b1 = j;
			for ( k = 0; k < 2; k=k+1) begin
			assign cin1 = k;
			#10
            $display("%01d + %01d + %01d -> sum = %01d, cout = %01d", a1, b1, cin1, sum, cout1);
			#10
				case (a1 + b1 + cin1)
					0: 	begin
							assign expectedSum = 0;
							assign expectedCout = 0;
						end
					1: 	begin
							assign expectedSum = 1;
							assign expectedCout = 0;
						end
					2: 	begin
							assign expectedSum = 0;
							assign expectedCout = 1;
						end
					3: 	begin
							assign expectedSum = 1;
							assign expectedCout = 1;
						end
					default: $display("some kind of error occurred here :/ maybe invalid input??");
				endcase
				#10
				/// check if output matches expected
				if( expectedSum != sum || expectedCout != cout1) begin
					assign flag = 1;
				end
			end
		end
	end

///// Final Results Messages /////
    if (!flag) begin
        $display("Passed One-Bit Addition Test :)");
    end else begin
            $display("Failed One-Bit Addition tests :(");
    end
end
endmodule