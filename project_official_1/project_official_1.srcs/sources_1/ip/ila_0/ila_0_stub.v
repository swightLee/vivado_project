// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Apr 15 10:05:18 2024
// Host        : BEPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {D:/BES
//               upgradePHD/MFT_all_file/Firmware_file/mft_vhdl_project/mft_k7_project/test_all_project_v1.6_Apr_12_2024/project_official_1/project_official_1.srcs/sources_1/ip/ila_0/ila_0_stub.v}
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k70tfbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2019.1" *)
module ila_0(clk, probe0, probe1, probe2, probe3, probe4, probe5, 
  probe6)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[79:0],probe1[7:0],probe2[0:0],probe3[1:0],probe4[7:0],probe5[0:0],probe6[0:0]" */;
  input clk;
  input [79:0]probe0;
  input [7:0]probe1;
  input [0:0]probe2;
  input [1:0]probe3;
  input [7:0]probe4;
  input [0:0]probe5;
  input [0:0]probe6;
endmodule
