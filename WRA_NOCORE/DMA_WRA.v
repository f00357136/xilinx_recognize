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
// Filename       : DMA_WRA.v
// Author         : Yizhou Wang 
// Created        : 2019-05-27
// Description    : Fetch data from FIFO and fetch filter from filter ram, generate DataPre_done signal
//               
//-------------------------------------------------------------------
 `include "define.v"
 
 module DMA_WRA(
input  wire clk,
input  wire rst_n,
input  wire [7:0] DMAAddrFilter_OP,  //From Decoder
input  wire [7:0] DMASizeFilter_OP,  //From Decoder
input  wire [7:0] DMASize_OP,        //From Decoder
input  wire Data_en,                 //From FSM_Top
input  wire Filter_en,               //From FSM_Top
input  wire Cfg_en,                  //From FSM_Top

output wire DataPre_done,            //To FSM_Top
output wire DataFIFO_en,             //To FSM_Top and DataFIFO
output wire FilterRam_en,            //To FSM_Top and FilterRam
output reg  we_data,                 //To WRA 
output wire we_filter,               //To WRA 
output wire [15:0] FilterRam_addr,   //To FilterRam
output wire [15:0] FilterWRA_addr    //To FSM_Top 
);
 // --------------------------------------------
//                                             
//    Register DECLARATION                     
//                                             
// --------------------------------------------
reg [15:0]data_cnt;
reg [15:0]filter_cnt;
reg datap_done;
reg filterp_done;
reg [15:0]DMAFilterRead_cnt;
// --------------------------------------------
//                                             
//    Combinational Logic                     
//                                             
// --------------------------------------------
assign DataPre_done=filterp_done&datap_done;
assign DataFIFO_en =Data_en&(!datap_done)&(DMASize_OP!=0);
assign FilterRam_en=Filter_en&(!filterp_done);
assign FilterRam_addr=DMAFilterRead_cnt;
assign FilterWRA_addr=DMAFilterRead_cnt-DMAAddrFilter_OP;
assign we_filter=FilterRam_en;
// --------------------------------------------
//                                             
//    Sequential Logic                     
//                                             
// --------------------------------------------
always@(posedge clk) begin
	we_data<=DataFIFO_en;
end

always@(posedge clk or negedge rst_n) begin
	if((~rst_n)||(data_cnt==DMASize_OP)||(DataPre_done))
	   data_cnt<=0;
	else if (DataFIFO_en)
	   data_cnt<=data_cnt+1;
end

always@(posedge clk or negedge rst_n) begin
	if((~rst_n)||(DataPre_done))
	   datap_done<=0;
	else if ((data_cnt==DMASize_OP)&&(Data_en))
	   datap_done<=1;
end

always@(posedge clk or negedge rst_n) begin
	if((~rst_n)||(filter_cnt==DMASizeFilter_OP)||(DataPre_done))
	   filter_cnt<=0;
	else if (FilterRam_en)
	   filter_cnt<=filter_cnt+1;
end

always@(posedge clk or negedge rst_n) begin
	if((~rst_n)||(DataPre_done))
	   filterp_done<=0;
	else if ((filter_cnt==DMASizeFilter_OP)&&(Filter_en))
	   filterp_done<=1;
end

always@(posedge clk)
	if((~rst_n)||(DMAFilterRead_cnt==DMASizeFilter_OP+DMAAddrFilter_OP))
	    DMAFilterRead_cnt<=0;
	else if(Cfg_en)
		DMAFilterRead_cnt<=DMAAddrFilter_OP;
	else if(FilterRam_en)
		DMAFilterRead_cnt<=DMAFilterRead_cnt+1;	

endmodule