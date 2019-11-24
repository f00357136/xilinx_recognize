// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Sep 14 11:56:43 2019
// Host        : DESKTOP-EK7LE09 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top FilterRam -prefix
//               FilterRam_ FilterRam_stub.v
// Design      : FilterRam
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.1" *)
module FilterRam(a, d, clk, we, spo)
/* synthesis syn_black_box black_box_pad_pin="a[7:0],d[511:0],clk,we,spo[511:0]" */;
  input [7:0]a;
  input [511:0]d;
  input clk;
  input we;
  output [511:0]spo;
endmodule
