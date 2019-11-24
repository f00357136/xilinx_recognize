`include "define.v"
module Channel_Accumu1_16(clk, rst, UpV, UpV_Accumu1_16);
input clk, rst;
input  [`DSPOutWidthA-1:0] UpV;
output reg [`ChAcOutWidthA-1:0] UpV_Accumu1_16;

wire [`ChAcOutWidthA-1:0] UpV_Inch1;
wire [`ChAcOutWidthA-1:0] UpV_Inch2;
wire [`ChAcOutWidthA-1:0] UpV_Inch3;
wire [`ChAcOutWidthA-1:0] UpV_Inch4;


assign UpV_Inch1 = UpV[175  :0   ]; 
assign UpV_Inch2 = UpV[351  :176 ]; 
assign UpV_Inch3 = UpV[527  :352 ]; 
assign UpV_Inch4 = UpV[703  :528 ]; 

parameter St1OutWidth=(`ChAcOutWidth+1)*16;
wire [St1OutWidth-1:0] result_stage1_1,result_stage1_2;
wire [`ChAcOutWidthA-1:0] result_stage2_1;


/*--------------------------------------------------------------stage1------------------------------------------------------------------*/
Sign_Add #(`ChAcOutWidth,`ChAcOutWidth+1) Sign_Add1(UpV_Inch1,UpV_Inch2,result_stage1_1);
Sign_Add #(`ChAcOutWidth,`ChAcOutWidth+1) Sign_Add2(UpV_Inch3,UpV_Inch4,result_stage1_2);

Sign_Add #(`ChAcOutWidth+1,`ChAcOutWidth) Sign_Add5(result_stage1_1,result_stage1_2,result_stage2_1);//定点化操作

always@(posedge clk)
	if(~rst)
		UpV_Accumu1_16<=0;
	else
		UpV_Accumu1_16<=result_stage2_1;
		
endmodule

/*--------------------------------------------------------------------------------------------------------------------------------------------*/




