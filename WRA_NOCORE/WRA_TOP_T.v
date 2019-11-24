`timescale 1ns/1ps
module WRA_TOP_T;
reg  HCLK,HRESETn;
always #10 HCLK=~HCLK;

reg [31:0]stride_OP;     
reg [31:0]kernelsize_OP; 
reg [31:0]numslideH_OP;  
reg [31:0]numslideV_OP; 
reg [31:0]numswitchH_OP;     
reg [31:0]NInch_D_PInch_OP; 
reg [31:0]NOuch_D_POuch_OP;  
reg [31:0]poolingen_OP;  
reg [31:0]inputbstart_OP;     
reg [31:0]cellnum_OP; 
reg [31:0]linenum_OP;  
reg [31:0]padding_OP;  
reg [31:0]fixpoint_OP; 
reg [31:0]ReLU_OP;
wire[31:0]Layer_Finish_OP; 
//DMA Register 
reg [31:0]DMARead_OP;  
reg [31:0]DMASize_OP;  
reg [31:0]DMAReadFilter_OP;
reg [31:0]DMASizeFilter_OP;
reg [31:0]DMAAddrFilter_OP;

initial begin
HRESETn<=0;
HCLK<=0;
#20
HRESETn<=1;

inputbstart_OP<=0;
stride_OP<=1;
kernelsize_OP<=1;
numslideH_OP<=12;
numslideV_OP<=13;
numswitchH_OP<=12;
NInch_D_PInch_OP<=0;
NOuch_D_POuch_OP<=1;
poolingen_OP<=0;
cellnum_OP<=6;
linenum_OP<=27;
padding_OP<=1;
fixpoint_OP<=0;
ReLU_OP<=1;

DMASize_OP<=195;
DMARead_OP<=1;

DMAAddrFilter_OP<=0;
DMASizeFilter_OP<=7;
DMAReadFilter_OP<=1;

#20
DMARead_OP<=0;
DMAReadFilter_OP<=0;

#4000
inputbstart_OP<=1;
#20
inputbstart_OP<=0;

#12800
stride_OP<=1;
kernelsize_OP<=1;
numslideH_OP<=12;
numslideV_OP<=6;
numswitchH_OP<=5;
NInch_D_PInch_OP<=1;
NOuch_D_POuch_OP<=3;
poolingen_OP<=0;
//cellnum_OP<=6;
//linenum_OP<=27;
padding_OP<=0;
fixpoint_OP<=0;
ReLU_OP<=1;
//DMASize_OP<=195;
//DMARead_OP<=1;

DMAAddrFilter_OP<=8;
DMASizeFilter_OP<=31;
DMAReadFilter_OP<=1;
#20
DMAReadFilter_OP<=0;

#800
inputbstart_OP<=1;
#20
inputbstart_OP<=0;

#10000
stride_OP<=1;
kernelsize_OP<=1;
numslideH_OP<=10;
numslideV_OP<=2;
numswitchH_OP<=1;
NInch_D_PInch_OP<=3;
NOuch_D_POuch_OP<=9;
poolingen_OP<=1;
//cellnum_OP<=6;
//linenum_OP<=27;
padding_OP<=0;
fixpoint_OP<=1;
ReLU_OP<=0;

DMAAddrFilter_OP<=40;
DMASizeFilter_OP<=159;
DMAReadFilter_OP<=1;
#20
DMAReadFilter_OP<=0;
#3200
inputbstart_OP<=1;
#20
inputbstart_OP<=0;
end

wire FeatureFIFO_rd, FeatureFIFO_wr, FeatureFIFO_empty;
reg  [15 :0] DMARead_cnt;
reg  DMARead_cnt_en;
wire [127:0] WRA_FeatureDataIn;

always@(posedge HCLK)
	if((~HRESETn)||(DMARead_cnt==DMASize_OP))
		DMARead_cnt_en<=0;
	else if(DMARead_OP[0])
		DMARead_cnt_en<=1;
		
always@(posedge HCLK)
	if((~HRESETn)||(DMARead_cnt==DMASize_OP))
		DMARead_cnt<=0;
	else if(DMARead_cnt_en)
		DMARead_cnt<=DMARead_cnt+1;

assign FeatureFIFO_rd=DMARead_cnt_en;
//fifo_generator_0 fifo_generator_0(
//  .clk(HCLK),               // input wire clk
//  .srst(HRESETn),           // input wire srst
//  .din(CamDataIn),          // input wire [127 : 0] din
//  .wr_en(CamWr_en),         // input wire wr_en
//  .rd_en(FeatureFIFO_rd),   // input wire rd_en
//  .dout(WRA_FeatureDataIn), // output wire [127 : 0] dout
//  .full(CamFull),           // output wire full
//  .empty(FeatureFIFO_empty)             // output wire empty
//);

//FOR SIMULATION InputRAM
dist_mem_gen_0 dist_mem_gen_0(
  .a(DMARead_cnt[7:0]),      // input wire [7 : 0] a
  .d(),      // input wire [127 : 0] d
  .clk(HCLK),  // input wire clk
  .we(1'b0),    // input wire we
  .spo(WRA_FeatureDataIn)  // output wire [127 : 0] spo
); 

// -----------------------------------------------------------------------------
// Filter Data synFIFO and wr/rd signals   
// -----------------------------------------------------------------------------
 
//FOR SIMULATION FilterRAM

reg  [15 :0] DMAFilterRead_cnt;
reg  DMAFilterRead_cnt_en;
reg  [31:0] DMAAddrFilter_reg;
wire [511:0] WRA_FilterDataIn;
wire [15:0] a_GtOutside;

always@(posedge HCLK)
	if(~HRESETn)
		DMAAddrFilter_reg<=0;
	else 
		DMAAddrFilter_reg<=DMAAddrFilter_OP;

always@(posedge HCLK)
	if((~HRESETn)||(DMAFilterRead_cnt==DMASizeFilter_OP+DMAAddrFilter_OP))
		DMAFilterRead_cnt_en<=0;
	else if(DMAReadFilter_OP[0])
		DMAFilterRead_cnt_en<=1;
		
always@(posedge HCLK)
	if((~HRESETn)||(DMAFilterRead_cnt==DMASizeFilter_OP+DMAAddrFilter_OP))
	    DMAFilterRead_cnt<=0;
	else if(DMAAddrFilter_reg!=DMAAddrFilter_OP)
		DMAFilterRead_cnt<=DMAAddrFilter_OP;
	else if(DMAFilterRead_cnt_en)
		DMAFilterRead_cnt<=DMAFilterRead_cnt+1;		
		
assign a_GtOutside=DMAFilterRead_cnt-DMAAddrFilter_reg;
		
dist_mem_gen_1 dist_mem_gen_1(
  .a(DMAFilterRead_cnt[7:0]),      // input wire [5 : 0] a
  .d(),      // input wire [512 : 0] d
  .clk(HCLK),  // input wire clk
  .we(1'b0),    // input wire we
  .spo(WRA_FilterDataIn)  // output wire [512 : 0] spo
);  


// -----------------------------------------------------------------------------
// WRA: DATA in and CONTROL generate
// -----------------------------------------------------------------------------
wire [11:0] WRA_FeatureData_Address;
wire WRA_FeatureData_En, Layer_Finish;
wire [511:0]WRA_FeatureData;

//assign WRA_FeatureData_Address={2'b0,reg_haddr[AW-2:4]}-256; //AHB HADDRESS_FF
assign WRA_FeatureData_En=DMARead_cnt_en;
assign Layer_Finish_OP={31'b0, Layer_Finish};

WRA_Top WRA_Top(
	.a(WRA_FeatureData_Address),
	.clk(HCLK),
	.we(WRA_FeatureData_En),
	.we_Gt(DMAFilterRead_cnt_en),
	.rst(HRESETn),
	.stride_op(stride_OP[0]),
	.kernelsize_op(kernelsize_OP[0]),
	.numslideH_op(numslideH_OP[8:0]),
	.numslideV_op(numslideV_OP[4:0]),
	.numswitchH_op(numswitchH_OP[4:0]),
	.NInch_D_PInch_op(NInch_D_PInch_OP[4:0]),
	.NOuch_D_POuch_op(NOuch_D_POuch_OP[4:0]),
	.poolingen_op(poolingen_OP[0]),
	.Layer_Finish(Layer_Finish),
	.inputbstart_op(inputbstart_OP[0]),
	.cellnum_op(cellnum_OP[7:0]),
	.linenum_op(linenum_OP[7:0]),
	.a_GtOutside(a_GtOutside),
	.d_ram(WRA_FeatureDataIn),
	.d_Gt(WRA_FilterDataIn),
	.padding_op(padding_OP[0]),
	.WRA_FeatureData(WRA_FeatureData),
	.fixpoint_op(fixpoint_OP[1:0]),
	.relu_op(ReLU_OP[0])
	);
	
endmodule