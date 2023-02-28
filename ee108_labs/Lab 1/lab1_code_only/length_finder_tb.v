module length_finder_tb ();

   reg [63:0] in;
   wire [3:0] len;
   reg [3:0] expected_len;
   
   length_finder dut (
      .string (in),
      .length (len)
   );
   // reading from right to left 
   initial begin
      in = 64'hAABBCCDDEEFFAA00;
      expected_len = 4'b0000; // 0
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 64'hAABBCCDDEEFFAA99;
      expected_len = 4'b1000; // 8
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 64'hAABBCCDDEEFF00AA;
      expected_len = 4'b0001; // 1
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 64'hAABBCCDDEE00FFAA;
      expected_len = 4'b0010; // 2
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 64'hAABBCC00EE00FFAA;
      expected_len = 4'b0010; // 2
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 64'h00BBCCDDEE44FFAA;
      expected_len = 4'b0111; // 7
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 64'h00BBCC00EE44FFAA;
      expected_len = 4'b0100; // 4
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 64'h44BBC00DEE44FFAA;
      expected_len = 4'b1000; // 8
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 4'b0;
      expected_len = 4'b0000; // 0
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      // additional test cases
        // lots of 00s
      in = 64'h00BB00DD00FF00AA;
      expected_len = 4'b0001; // 1
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 64'h00BB00DD0000EEFFAA;
      expected_len = 4'b0011; // 3
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 64'h00BB00DD0000EEFF00;
      expected_len = 4'b0000; // 0
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
      in = 64'h00BB00DD0000000000;
      expected_len = 4'b0000; // 0
      #5
      $display ("%h : len = %b, expected len = %b", in, len, expected_len);
      
   end
   
endmodule
