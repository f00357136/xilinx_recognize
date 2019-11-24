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
// Filename       : ProgramCnt.v
// Author         : Yizhou Wang 
// Created        : 2019-05-27
// Description    : This module is counter, incrementing when ProgramCnt_en is valid, providing address for InstrMeM module
//               
//------------------------------------------------------------------- 

`include "define.v"
module ProgramCnt(
input  wire clk,
input  wire rst_n,
input  wire ProgramCnt_en,						// From FSM_Top
input  wire Model_done,                         // From Decoder
output wire [`InstrMemDepth-1:0] InstrMemAddr   // To InstrMeM
);
// --------------------------------------------
//                                             
//    Register DECLARATION                     
//                                             
// --------------------------------------------
reg [`InstrMemDepth-1:0] address_r;

// --------------------------------------------
//                                             
//    Combinational Logic                     
//                                             
// --------------------------------------------
assign InstrMemAddr=address_r;
// --------------------------------------------
//                                             
//    Sequential Logic                     
//                                             
// --------------------------------------------
always@(posedge clk or negedge rst_n) begin
	if((~rst_n)||(Model_done))
		address_r<=0;
	else if (ProgramCnt_en)
		address_r<=address_r+1;
end

endmodule