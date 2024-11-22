// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed Apr 17 16:59:19 2024
// Host        : BEPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/44497/Desktop/mft_k7_project/test_all_pro_4.12/project_official_1/project_official_1.srcs/sources_1/ip/rom_cg/rom_cg_stub.v
// Design      : rom_cg
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k70tfbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module rom_cg(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[8:0],douta[191:0]" */;
  input clka;
  input ena;
  input [8:0]addra;
  output [191:0]douta;
endmodule
