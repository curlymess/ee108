// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Fri Oct 16 19:28:29 2020
// Host        : NoorWindows running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/nfaki/Desktop/ee 108/Lab
//               4/lab4/lab4.srcs/sources_1/ip/hdmi_tx_0/hdmi_tx_0_stub.v}
// Design      : hdmi_tx_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "hdmi_tx_v1_0,Vivado 2020.1" *)
module hdmi_tx_0(pix_clk, pix_clkx5, pix_clk_locked, rst, 
  pix_data, hsync, vsync, vde, TMDS_CLK_P, TMDS_CLK_N, TMDS_DATA_P, TMDS_DATA_N)
/* synthesis syn_black_box black_box_pad_pin="pix_clk,pix_clkx5,pix_clk_locked,rst,pix_data[31:0],hsync,vsync,vde,TMDS_CLK_P,TMDS_CLK_N,TMDS_DATA_P[2:0],TMDS_DATA_N[2:0]" */;
  input pix_clk;
  input pix_clkx5;
  input pix_clk_locked;
  input rst;
  input [31:0]pix_data;
  input hsync;
  input vsync;
  input vde;
  output TMDS_CLK_P;
  output TMDS_CLK_N;
  output [2:0]TMDS_DATA_P;
  output [2:0]TMDS_DATA_N;
endmodule
