//------------------------------------------------------------------- 
//                                                                    
//  COPYRIGHT (C) 2019, Yizhou Wang, Fudan University               
//                                                                    
//  THIS FILE MAY NOT BE MODIFIED OR REDISTRIBUTED WITHOUT THE        
//  EXPRESSED WRITTEN CONSENT                        
//                                                                                          
//  IP Owner 	  : Yizhou Wang                                          
//  Contact       : wangyizhou@stu.xjtu.edu.cn             
//-------------------------------------------------------------------
// Filename       : Decoder.v
// Author         : Yizhou Wang 
// Created        : 2019-05-27
// Description    : Decode instruction of WRA
//               
//-------------------------------------------------------------------

//[0]		---> stride_OP
//[1]		---> kernelsize_OP
//[6:2] 	---> numslideH_Op
//[11:7]	---> numslideV_Op
//[16:12]   ---> numswitchH_OP
//[18:17]   ---> NInch_D_PInch_OP
//[22:19]   ---> NOuch_D_POuch_OP
//[23]      ---> poolingen_OP
//[26:24]   ---> cellnum_OP
//[31:27]   ---> linenum_OP
//[32]      ---> padding_OP
//[34:33]   ---> fixpoint_OP
//[35]      ---> ReLU_OP
//[43:36]   ---> DMAAddrFilter_OP
//[51:44]   ---> DMASizeFilter_OP
//[59:52]   ---> DMASize_OP
//[60]      ---> Model_done
//[61]      ---> ReadResult

 `include "define.v"
 
module Decoder(
input  wire clk,
input  wire rst_n,
input  wire [`InstrLength-1:0] Instr,  // From InstrMem
input  wire ProgramCnt_en,			   // From FSM_Top
 
output reg  Model_done,                // To FSM_Top
output reg  ReadResult,                // To FSM_Top
output reg  [59:0] WRAcfg              // To WRA
);
// --------------------------------------------
//                                             
//    Sequential Logic                     
//                                             
// --------------------------------------------
always@(posedge clk or negedge rst_n) begin
	if(~rst_n)begin
		Model_done<=1'b0;
		ReadResult<=1'b0;
		WRAcfg    <=60'hFFFF_FFFF_FFFF_FFF;
		end
	else if(ProgramCnt_en) begin
		ReadResult<=Instr[61];
		Model_done<=Instr[60];
		WRAcfg    <=Instr[59:0];
	end
end

endmodule
		

