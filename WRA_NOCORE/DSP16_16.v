`include "define.v"
module DSP16_16(clk, inputa, inputb, outputp, fixpoint_op);
input clk;
input [`GtInDSPWidth-1:0] inputa;
input [`GtInDSPWidth-1:0] inputb;
input [1:0]   fixpoint_op;
output[`DSPOutWidthA-1:0] outputp;

//DSP16 DSP16_1 (clk, inputa[127 :0	], inputb[127 :0   ], outputp[127 :0   ], fixpoint_op);
//DSP16 DSP16_2 (clk, inputa[255 :128 ], inputb[255 :128 ], outputp[255 :128 ], fixpoint_op);
//DSP16 DSP16_3 (clk, inputa[383 :256 ], inputb[383 :256 ], outputp[383 :256 ], fixpoint_op);
//DSP16 DSP16_4 (clk, inputa[511 :384 ], inputb[511 :384 ], outputp[511 :384 ], fixpoint_op);
//DSP16 DSP16_5 (clk, inputa[639 :512 ], inputb[639 :512 ], outputp[639 :512 ], fixpoint_op);
//DSP16 DSP16_6 (clk, inputa[767 :640 ], inputb[767 :640 ], outputp[767 :640 ], fixpoint_op);
//DSP16 DSP16_7 (clk, inputa[895 :768 ], inputb[895 :768 ], outputp[895 :768 ], fixpoint_op);
//DSP16 DSP16_8 (clk, inputa[1023:896 ], inputb[1023:896 ], outputp[1023:896 ], fixpoint_op);

DSP16_lut DSP16_1 (clk, inputa[127 :0	], inputb[127 :0   ], outputp[175  :0    ], fixpoint_op);
//20190927gai
//DSP16_lut DSP16_2 (clk, inputa[255 :128 ], inputb[255 :128 ], outputp[351  :176  ], fixpoint_op);
DSP16     DSP16_2 (clk, inputa[255 :128 ], inputb[255 :128 ], outputp[351  :176  ], fixpoint_op);
DSP16     DSP16_3 (clk, inputa[383 :256 ], inputb[383 :256 ], outputp[527  :352  ], fixpoint_op);
DSP16     DSP16_4 (clk, inputa[511 :384 ], inputb[511 :384 ], outputp[703  :528  ], fixpoint_op);


endmodule