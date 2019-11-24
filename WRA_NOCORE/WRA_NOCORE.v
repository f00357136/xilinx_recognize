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
// Filename       : WRA_NOCORE.v
// Author         : Yizhou Wang 
// Created        : 2019-05-27
// Description    : Integrate WRA on a NO-CORE SOC
//               
//-------------------------------------------------------------------
 `include "define.v"
 
module WRA_NOCORE(
input  wire clk,
input  wire rst_n,
input  wire [127:0] CamDataIn,
input  wire CamWr_en,

output wire CamEmpty,
output wire [19:0] IdentifiedNum
);

// --------------------------------------------
//                                             
//    Wire DECLARATION                     
//                                             
// --------------------------------------------
wire [127:0] WRA_FeatureDataIn;
wire [511:0] WRA_FilterDataIn;
wire [7:0]   InstrMemAddr;
wire [`InstrLength-1:0] Instr;
wire [59:0]  WRAcfg; 
wire [511:0] WRA_FeatureData;
wire [11:0]  WRA_FeatureData_Address;
wire [15:0]  FilterRam_addr;
wire [15:0]  FilterWRA_addr;

wire stride_OP;     
wire kernelsize_OP; 
wire [8:0]numslideH_OP;  
wire [4:0]numslideV_OP; 
wire [4:0]numswitchH_OP;     
wire [7:0]NInch_D_PInch_OP; 
wire [7:0]NOuch_D_POuch_OP;  
wire poolingen_OP;       
wire [7:0]cellnum_OP; 
wire [7:0]linenum_OP;  
wire padding_OP;  
wire [1:0]fixpoint_OP; 
wire ReLU_OP;    
wire [7:0]DMASize_OP;  
wire [7:0]DMASizeFilter_OP;
wire [7:0]DMAAddrFilter_OP;
// --------------------------------------------
//                                             
//    Combinational Logic                     
//                                             
// --------------------------------------------
assign stride_OP       =   WRAcfg [0]	 ;
assign kernelsize_OP   =   WRAcfg [1]	 ;
assign numslideH_OP    =   {4'b0,WRAcfg [6:2]}  ;
assign numslideV_OP    =   WRAcfg [11:7] ;
assign numswitchH_OP   =   WRAcfg [16:12];
assign NInch_D_PInch_OP=   WRAcfg [18:17];
assign NOuch_D_POuch_OP=   WRAcfg [22:19];
assign poolingen_OP    =   WRAcfg [23]   ;
assign cellnum_OP      =   WRAcfg [26:24];
assign linenum_OP      =   WRAcfg [31:27];
assign padding_OP      =   WRAcfg [32]   ;
assign fixpoint_OP     =   WRAcfg [34:33];
assign ReLU_OP         =   WRAcfg [35]   ;
assign DMAAddrFilter_OP=   WRAcfg [43:36];
assign DMASizeFilter_OP=   WRAcfg [51:44];
assign DMASize_OP      =   WRAcfg [59:52];
// --------------------------------------------
//                                             
//    Sub Modules                              
//                                             
// --------------------------------------------
DataFIFO DataFIFO0(
  .clk(clk),                         
  .din(CamDataIn),      				 //From outside        
  .wr_en(CamWr_en),     				 //From outside     
  .rd_en(DataFIFO_en),  				 //From DMA_WRA 
  .dout(WRA_FeatureDataIn),              //To WRA
  .full(AynFIFO_full),              	 //To FSM_Top 
  .empty(CamEmpty)      				 //To outside
);

FilterRam FilterRam0(
  .a(FilterRam_addr),      				 //From DMA_WRA
  .d(),                                  //From .coe file 
  .clk(clk),  
  .we(1'b0),    
  .spo(WRA_FilterDataIn)  				 //To WRA
);

FSM_Top FSM_Top0(
  .clk(clk),
  .rst_n(rst_n),
  
  .AynFIFO_full(AynFIFO_full),   		 //From asynchronous FIFO
  .OutputRd_done(OutputRd_done),  		 //From ResultAccess
  .Layer_done(Layer_done),     			 //From WRA
  .DataPre_done(DataPre_done),   		 //From DMA_WRA
  .Model_done(Model_done),     			 //From Decoder
  .ReadResult(ReadResult),     			 //From Decoder
  
  .WAR_start(WAR_start),      			 //To WRA
  .Data_en(Data_en),        			 //To DMA_WRA
  .Filter_en(Filter_en),     			 //To DMA_WRA
  .ResultRd_en(ResultRd_en),   			 //To ResultAccess
  .Cfg_en(Cfg_en),						 //To DMA_WRA
  .ProgramCnt_en(ProgramCnt_en)  		 //To Programer Counter and Decoder
);

ProgramCnt ProgramCnt0(
  .clk(clk),
  .rst_n(rst_n),
  .ProgramCnt_en(ProgramCnt_en),		 // From FSM_Top
  .Model_done(Model_done),               // From Decoder
  .InstrMemAddr(InstrMemAddr)            // To InstrMeM
);

InstrMem InstrMem0(
  .clk(clk),
  .InstrMemAddr(InstrMemAddr),  		 //From ProgramCnt
  
  .Instr(Instr)              			 //To Decoder
);

Decoder Decoder0(
  .clk(clk),
  .rst_n(rst_n),
  .Instr(Instr),  						 // From InstrMem
  .ProgramCnt_en(ProgramCnt_en),	     // From FSM_Top
  
  .Model_done(Model_done),               // To FSM_Top
  .ReadResult(ReadResult),               // To FSM_Top
  .WRAcfg(WRAcfg)                        // To WRA
);

ReadResult ReadResult0(
  .clk(clk),
  .rst_n(rst_n),
  .ResultRd_en(ResultRd_en),			 //From FSM_Top
  .WRA_FeatureData(WRA_FeatureData),     //From WRA
  
  .OutputRd_done(OutputRd_done),		 //To FSM_Top
  .WRA_FeatureData_Address(WRA_FeatureData_Address),
										 //To WRA
  .IdentifiedNum(IdentifiedNum) 		 //To outside 
);

DMA_WRA DMA_WRA0(
  .clk(clk),
  .rst_n(rst_n),
  .DMAAddrFilter_OP(DMAAddrFilter_OP),  //From Decoder
  .DMASizeFilter_OP(DMASizeFilter_OP),  //From Decoder
  .DMASize_OP(DMASize_OP),        		//From Decoder
  .Data_en(Data_en),                	//From FSM_Top
  .Filter_en(Filter_en),                //From FSM_Top
  .Cfg_en(Cfg_en),                      //From FSM_Top
  
  .DataPre_done(DataPre_done),          //To FSM_Top
  .DataFIFO_en(DataFIFO_en),            //To DataFIFO
  .FilterRam_en(FilterRam_en),          //To FilterRam
  .we_data(we_data),                    //To WRA 
  .we_filter(we_filter),                //To WRA    
  .FilterRam_addr(FilterRam_addr),   	//To FilterRam
  .FilterWRA_addr(FilterWRA_addr)   	//To FSM_Top 
);

WRA_Top WRA_Top0(
	.a(WRA_FeatureData_Address),        //From ReadResult
	.clk(clk), 
	.we(we_data),                       //From DMA_WRA
	.we_Gt(we_filter),       			//From DMA_WRA
	.rst(rst_n),
	.stride_op(stride_OP), 
	.kernelsize_op(kernelsize_OP),
	.numslideH_op(numslideH_OP),
	.numslideV_op(numslideV_OP),
	.numswitchH_op(numswitchH_OP),
	.NInch_D_PInch_op(NInch_D_PInch_OP),
	.NOuch_D_POuch_op(NOuch_D_POuch_OP),
	.poolingen_op(poolingen_OP),
	.Layer_Finish(Layer_done),          //To FSM_Top
	.inputbstart_op(WAR_start),         //From FSM_Top
	.cellnum_op(cellnum_OP),
	.linenum_op(linenum_OP),
	.a_GtOutside(FilterWRA_addr),       //From DMA_WRA
	.d_ram(WRA_FeatureDataIn),          //From DataFIFO
	.d_Gt(WRA_FilterDataIn),            //From FilterRam
	.padding_op(padding_OP),
	.WRA_FeatureData(WRA_FeatureData),  //To ReadResult
	.fixpoint_op(fixpoint_OP),
	.relu_op(ReLU_OP)
	);
endmodule