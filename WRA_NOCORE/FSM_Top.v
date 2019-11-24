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
// Filename       : FSM_Top.v
// Author         : Yizhou Wang 
// Created        : 2019-05-27
// Description    : This module replaces the RISC CORE, and generates control signal for WRA, Instr_Mem
//               
//------------------------------------------------------------------- 

`include "define.v"
module FSM_Top(
// ----------------------------------------------------------------------------
// Port declarations
// ----------------------------------------------------------------------------
input  wire clk,
input  wire rst_n,

input  wire AynFIFO_full,   //From asynchronous FIFO
input  wire OutputRd_done,  //From ResultAccess
input  wire Layer_done,     //From WRA
input  wire DataPre_done,   //From DMA_WRA
input  wire Model_done,     //From Decoder
input  wire ReadResult,     //From Decoder

output reg  WAR_start,      //To WRA
output reg  Data_en,        //To DMA_WRA
output reg  Filter_en,      //To DMA_WRA
output reg  ResultRd_en,    //To ResultAccess
output reg  Cfg_en,			//To DMA_WRA
output reg  ProgramCnt_en  //To Programer Counter and Decoder
);
// --------------------------------------------
//                                             
//    Parameter DECLARATION                     
//                                             
// --------------------------------------------
parameter 		IDLE 	 	   = 4'b0000,  // IDLE state
				READINSTR	   = 4'b0001,  // Read Instruction
				DECODE         = 4'b0010,
				LOADDATA	   = 4'b0011,  // load data	
				STARTWRA       = 4'b0100,  // Start up WRA
				RUNWRA         = 4'b0101,  // WRA is Running
				READRESULT     = 4'b0110;  // Read output 
// --------------------------------------------
//                                             
//    Register DECLARATION                     
//                                             
// --------------------------------------------
reg [3:0] current_state;
reg [3:0] next_state;
// --------------------------------------------
//                                             
//    Wire DECLARATION                     
//                                             
// --------------------------------------------
// --------------------------------------------
//                                             
//    Combinational Logic                     
//                                             
// --------------------------------------------
always@(*) begin
	case(current_state)
		IDLE      : begin 
			        WAR_start=0;
			        Data_en=0;
			        Filter_en=0; 
					ResultRd_en=0;
					ProgramCnt_en=0;
					Cfg_en=0;
			        end
		READINSTR : begin 
			        WAR_start=0;
			        Data_en=0;
			        Filter_en=0; 
					ResultRd_en=0;
					ProgramCnt_en=1;
					Cfg_en=0;
			        end	    
		DECODE    : begin 
			        WAR_start=0;
			        Data_en=0;
			        Filter_en=0; 
					ResultRd_en=0;
					ProgramCnt_en=0;
					Cfg_en=1;
			        end	 		
		LOADDATA  : begin 
					WAR_start=0;
					Data_en=1;
					Filter_en=1; 
					ResultRd_en=0;
					ProgramCnt_en=0;
					Cfg_en=0;
					end
		STARTWRA  : begin 
					WAR_start=1;
					Data_en=0;
					Filter_en=0;
					ResultRd_en=0;
					ProgramCnt_en=0;
					Cfg_en=0;
					end
		RUNWRA	  : begin 
					WAR_start=0;
					Data_en=0;
					Filter_en=0;
					ResultRd_en=0;
					ProgramCnt_en=0;
					Cfg_en=0;
					end
		READRESULT: begin 
					WAR_start=0;
					Data_en=0;
					Filter_en=0; 
					ResultRd_en=1;
					ProgramCnt_en=0;
					Cfg_en=0;
					end		
		default   : begin 
					WAR_start=0;
					Data_en=0;
					Filter_en=0;
					ResultRd_en=0;
					ProgramCnt_en=0;
					Cfg_en=0;		
					end		
	endcase
end
	
always@(*) begin
	case(current_state)
	IDLE		: if (AynFIFO_full)
					next_state=READINSTR;
				  else
					next_state=IDLE;
	READINSTR	: 	next_state=DECODE;
	DECODE      : if (Model_done)
					next_state=IDLE;
				  else if (ReadResult)
					next_state=READRESULT;
				  else
				    next_state=LOADDATA;
	LOADDATA    : if (DataPre_done)
					next_state=STARTWRA;
				  else
					next_state=LOADDATA;
	STARTWRA    :   next_state=RUNWRA;
	RUNWRA      : if (Layer_done)
					next_state=READINSTR;
				  else
					next_state=RUNWRA;
	READRESULT  : if (OutputRd_done)
					next_state=READINSTR;
				  else 
					next_state=READRESULT;
	default     :   next_state=IDLE;
	endcase		
end	
// --------------------------------------------
//                                             
//    Sequential Logic                     
//                                             
// --------------------------------------------
always @(posedge clk or negedge rst_n) begin
	if (!rst_n)
		current_state <= IDLE;
	else
		current_state <= next_state;
end

endmodule