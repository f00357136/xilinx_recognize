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
// Filename       : InstrMem.v
// Author         : Yizhou Wang 
// Created        : 2019-05-27
// Description    : Save the instruction of WRA
//               
//-------------------------------------------------------------------
 
`include "define.v"
module InstrMem(
input  wire clk,
input  wire [`InstrMemDepth-1:0] InstrMemAddr,  //From ProgramCnt

output wire [`InstrLength-1:0]   Instr          //To Decoder
);

// --------------------------------------------
//                                             
//    Sub Modules                              
//                                             
// --------------------------------------------
instrmemory instrmemory0(
	.a(InstrMemAddr),
	.d(),
	.clk(clk),
	.we(1'b0),
	.spo(Instr)
);

endmodule