// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Tue Sep 24 20:44:39 2019
// Host        : GENGLONGFEI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top instrmemory -prefix
//               instrmemory_ instrmemory_stub.v
// Design      : instrmemory
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2018.1" *)
module instrmemory(a, d, clk, we, spo)
/* synthesis syn_black_box black_box_pad_pin="a[7:0],d[63:0],clk,we,spo[63:0]" */;
  input [7:0]a;
  input [63:0]d;
  input clk;
  input we;
  output [63:0]spo;
endmodule
