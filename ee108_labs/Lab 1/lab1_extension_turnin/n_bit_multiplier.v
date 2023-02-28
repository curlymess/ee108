`timescale 1ns / 1ps

module n_bit_multiplier #(parameter N = 4)
(
   input wire [N-1:0] a, // Input 1 - N bit multiplier
   input wire [N-1:0] b, // Input 2 - N bit multiplier
   output wire [2*N-1:0] p  // Output Product: a*b
);

// partial product array
 wire [N-1:0] partial_product [N-1:0]; // set of N wires of width N

// assign values to partial_product array
generate
    genvar i;
    for(i=0; i < N; i=i+1) begin: pp_module_array
        assign partial_product[i] = {N {b[i]}} & a; // allows b to be the same length! aka N copies of the ith bit in b
    end
endgenerate

// two arrays to hold your carry bits and the sum produced by each adder
 wire [N-1:0] sum_array [N-1:0]; // array of length N-1 of N wide wires maybe need to expand??
 wire carry_array [N-1:0]; // carry bits only 1 bit wide, can just use a wire length N-1

// generate adders
assign sum_array [0] = partial_product[0];
assign carry_array[0] = 1'b0;
generate
    // Generates n n-bit adders
    genvar j;
    for(j=0; j < N-1; j=j+1) begin: n_bit_adder_array // up to N-1 right
        n_bit_adder #(N) ADDER (
        .a(partial_product[j+1]),   // input - next partial product
        .b({carry_array[j], sum_array[j][N-1:1]}), // input - carry bit concantenated with the top N-1 bits of the previous sum
        .cin(1'b0),
        .out(sum_array[j+1]),     //output
        .of(carry_array[j+1])     // overflow output
        ); end
        
endgenerate


// create output p
// assign output from 1 to N-2 bits 
generate
    genvar k;
    for(k=0; k < N-1; k=k+1) begin: output_array
        assign p[k] = sum_array[k][0];
    end
endgenerate

// assign output p from N-1? to 2N - 2? bits
assign p[2*N-2 : N-1]  = sum_array[N-1];

// assign final bit - add final overflow bit as the most sig bit of output
assign p[2*N-1] = carry_array[N-1];

endmodule
