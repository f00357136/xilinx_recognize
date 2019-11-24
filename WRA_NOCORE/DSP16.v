`include "define.v"
module DSP16(clk, inputa, inputb, outputp, fixpoint_op);
input clk;
input [127:0]inputa;
input [127:0]inputb;
input [1:0]  fixpoint_op;
output[OutDaWidth-1:0]outputp;

parameter OutDaWidth=`DSPOutWidth*16;

wire signed[15:0] pdt1, pdt2, pdt3, pdt4, pdt5, pdt6, pdt7, pdt8;
wire signed[15:0] pdt9, pdt10, pdt11, pdt12, pdt13, pdt14, pdt15, pdt16;

mult mult1 (clk, inputa[7:0]    , inputb[7:0]    , pdt1 );
mult mult2 (clk, inputa[15:8]   , inputb[15:8]   , pdt2 );
mult mult3 (clk, inputa[23:16]  , inputb[23:16]  , pdt3 );
mult mult4 (clk, inputa[31:24]  , inputb[31:24]  , pdt4 );
mult mult5 (clk, inputa[39:32]  , inputb[39:32]  , pdt5 );
mult mult6 (clk, inputa[47:40]  , inputb[47:40]  , pdt6 );
mult mult7 (clk, inputa[55:48]  , inputb[55:48]  , pdt7 );
mult mult8 (clk, inputa[63:56]  , inputb[63:56]  , pdt8 );
mult mult9 (clk, inputa[71:64]  , inputb[71:64]  , pdt9 );
mult mult10(clk, inputa[79:72]  , inputb[79:72]  , pdt10);
mult mult11(clk, inputa[87:80]  , inputb[87:80]  , pdt11);
mult mult12(clk, inputa[95:88]  , inputb[95:88]  , pdt12);
mult mult13(clk, inputa[103:96] , inputb[103:96] , pdt13);
mult mult14(clk, inputa[111:104], inputb[111:104], pdt14);
mult mult15(clk, inputa[119:112], inputb[119:112], pdt15);
mult mult16(clk, inputa[127:120], inputb[127:120], pdt16);

assign outputp[10:0   ]  =(fixpoint_op==0)?pdt1 [13:3]:pdt1 [11:1];
assign outputp[21:11  ]  =(fixpoint_op==0)?pdt2 [13:3]:pdt2 [11:1];
assign outputp[32:22  ]  =(fixpoint_op==0)?pdt3 [13:3]:pdt3 [11:1];
assign outputp[43:33  ]  =(fixpoint_op==0)?pdt4 [13:3]:pdt4 [11:1];
assign outputp[54:44  ]  =(fixpoint_op==0)?pdt5 [13:3]:pdt5 [11:1];
assign outputp[65:55  ]  =(fixpoint_op==0)?pdt6 [13:3]:pdt6 [11:1];
assign outputp[76:66  ]  =(fixpoint_op==0)?pdt7 [13:3]:pdt7 [11:1];
assign outputp[87:77  ]  =(fixpoint_op==0)?pdt8 [13:3]:pdt8 [11:1]; 
assign outputp[98:88  ]  =(fixpoint_op==0)?pdt9 [13:3]:pdt9 [11:1];
assign outputp[109:99 ]  =(fixpoint_op==0)?pdt10[13:3]:pdt10[11:1];
assign outputp[120:110]  =(fixpoint_op==0)?pdt11[13:3]:pdt11[11:1];
assign outputp[131:121]  =(fixpoint_op==0)?pdt12[13:3]:pdt12[11:1];
assign outputp[142:132]  =(fixpoint_op==0)?pdt13[13:3]:pdt13[11:1];
assign outputp[153:143]	 =(fixpoint_op==0)?pdt14[13:3]:pdt14[11:1];
assign outputp[164:154]	 =(fixpoint_op==0)?pdt15[13:3]:pdt15[11:1];
assign outputp[175:165]	 =(fixpoint_op==0)?pdt16[13:3]:pdt16[11:1]; 
                                                                
endmodule