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
// Filename       : ReadResult.v
// Author         : Yizhou Wang 
// Created        : 2019-05-27
// Description    : Read the 3-layers CNN result. Need to self-define the result address, and the post computation 
//               
//-------------------------------------------------------------------
 `include "define.v"
 
module ReadResult(
input  wire clk,
input  wire rst_n,		
input  wire ResultRd_en,        					 		//From FSM_Top
input  wire [`WRAOutDataWidth-1:0] WRA_FeatureData,  		//From WRA

output wire OutputRd_done,       						    //To FSM_Top
output wire [`WRAInAddrWidth-1:0] WRA_FeatureData_Address,  //To WRA
output reg  [19:0] IdentifiedNum 							//To outside 
);

// --------------------------------------------
//                                             
//    Parameter DECLARATION                     
//                                             
// --------------------------------------------
parameter WRABoundLOW_BASE=16'h4000;
// --------------------------------------------
//                                             
//    Register DECLARATION                     
//                                             
// --------------------------------------------
reg [3:0] vol_idx;
reg [3:0] col_idx;
reg [3:0] col_idx_r;
reg [3:0] vol_idx_r;
reg signed [31:0]candidate;
reg [3:0] can_idx;
reg signed [31:0]accumulate;
// --------------------------------------------
//                                             
//    Wire DECLARATION                     
//                                             
// --------------------------------------------
reg  [31:0]				      WRA_FeatureData_AHB;
reg  signed [7:0]             WRA_FeatureData_AHB_INT8; 
reg  [31:0]				      HADDR;
wire [`WRAOutDataWidth-1:0]   WRA_FeatureData_RR;
// --------------------------------------------
//                                             
//    Sequential Logic                     
//                                             
// --------------------------------------------
//Generate WRA_FeatureData_Address automatically
always@(posedge clk or negedge rst_n) begin
	if((~rst_n)||(vol_idx==3))
		vol_idx<=0;
	else if(ResultRd_en)
		vol_idx<=vol_idx+1;
end

always@(posedge clk or negedge rst_n) begin
	if((~rst_n)||((col_idx==9)&&(vol_idx==3)))
		col_idx<=0;
	else if((ResultRd_en)&&(vol_idx==3))
		col_idx<=col_idx+1;
end

always@(posedge clk) begin
	col_idx_r<=col_idx;
	vol_idx_r<=vol_idx;
	end
//take post-computation		
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) 
		accumulate<=0;
	else if(vol_idx_r==3)
		accumulate<=WRA_FeatureData_AHB_INT8;
	else if(ResultRd_en)
		accumulate<=accumulate+WRA_FeatureData_AHB_INT8;
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		candidate<=32'b10000000_00000000_00000000_00000001;
		can_idx<=0;
	end
	else if((vol_idx_r==3)&&(candidate<=accumulate)) begin
		candidate<=accumulate;
		can_idx  <=col_idx_r;
	end
end	

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) 
	//20190929gai
//	IdentifiedNum<=20'bx;
		IdentifiedNum<=0;
	else if ((vol_idx_r==3)&&(col_idx_r==9))
		IdentifiedNum<={IdentifiedNum[15:0],can_idx};
end
// --------------------------------------------
//                                             
//    Combinational Logic                     
//                                             
// --------------------------------------------
assign WRA_FeatureData_Address=HADDR[15:6]-256;
assign WRA_FeatureData_RR=(ResultRd_en==1)?WRA_FeatureData:0;
assign OutputRd_done=((vol_idx==3)&&(col_idx==9))?1:0;

always@(*)
	case(vol_idx)
	0: HADDR=WRABoundLOW_BASE+{col_idx,6'b0};
	1: HADDR=WRABoundLOW_BASE+{col_idx,6'b0}+19;
	2: HADDR=WRABoundLOW_BASE+{col_idx,6'b0}+44;
	3: HADDR=WRABoundLOW_BASE+{col_idx,6'b0}+63;
	default: HADDR=0;
	endcase
	
//Capture WRA_FeatureData 
always@(*)
	case(HADDR[5:2])
	0 : WRA_FeatureData_AHB=WRA_FeatureData_RR[31	:0  ];
	1 : WRA_FeatureData_AHB=WRA_FeatureData_RR[63	:32 ];
	2 : WRA_FeatureData_AHB=WRA_FeatureData_RR[95	:64 ];
	3 : WRA_FeatureData_AHB=WRA_FeatureData_RR[127	:96 ];
	4 : WRA_FeatureData_AHB=WRA_FeatureData_RR[159	:128];
	5 : WRA_FeatureData_AHB=WRA_FeatureData_RR[191	:160];
	6 : WRA_FeatureData_AHB=WRA_FeatureData_RR[223	:192];
	7 : WRA_FeatureData_AHB=WRA_FeatureData_RR[255	:224];
	8 : WRA_FeatureData_AHB=WRA_FeatureData_RR[287	:256];
	9 : WRA_FeatureData_AHB=WRA_FeatureData_RR[319	:288];
	10: WRA_FeatureData_AHB=WRA_FeatureData_RR[351	:320];
	11: WRA_FeatureData_AHB=WRA_FeatureData_RR[383	:352];
	12: WRA_FeatureData_AHB=WRA_FeatureData_RR[415	:384];
	13: WRA_FeatureData_AHB=WRA_FeatureData_RR[447	:416];
	14: WRA_FeatureData_AHB=WRA_FeatureData_RR[479	:448];
	15: WRA_FeatureData_AHB=WRA_FeatureData_RR[511	:480];
    default:WRA_FeatureData_AHB=0;
	endcase

always@(*)
	case(HADDR[1:0])
	0 : WRA_FeatureData_AHB_INT8=WRA_FeatureData_AHB[7	:0  ];
	1 : WRA_FeatureData_AHB_INT8=WRA_FeatureData_AHB[15	:8  ];
	2 : WRA_FeatureData_AHB_INT8=WRA_FeatureData_AHB[23	:16 ];
	3 : WRA_FeatureData_AHB_INT8=WRA_FeatureData_AHB[31 :24 ];
    default:WRA_FeatureData_AHB_INT8=0;
	endcase

endmodule

