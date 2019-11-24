`include "define.v"
module Buffer_Grain_16_32_32bit(poolingen_op, current_state, spo, a, d, we, clk, stride_op, kernelsize_op);
input [3:0]current_state;
input [InBuAddrWidth-1:0] a;       //read max=128*4-2=510; write=0-63
input [`AyInFIFOWidth-1:0] d;     //32*16
input we, clk, poolingen_op;    
output[InBuLineoutDW-1:0] spo;   //32*16
input stride_op;
input kernelsize_op;
// --------------------------------------------------------------------------
// Parameter Declarations
// --------------------------------------------------------------------------
parameter InBuAddrWidth=8;
parameter InBuLineoutDW=4*`PEArraySize_DF*8; //128=4*1(element)*4(PEArraySize_DF)*8(DataWidth)

wire [31:0] spo1_ ,spo2_ ,spo3_ ,spo4_ ;
	
Ram_Grain_32_32bit Ram_Grain_32_32bit1 (.a(a),.clk(clk),.d(d[31 :0  ]),.we(we),.spo(spo1_ ),.stride_op(stride_op),.kernelsize_op(kernelsize_op),.current_state(current_state), .poolingen_op(poolingen_op));         
Ram_Grain_32_32bit Ram_Grain_32_32bit2 (.a(a),.clk(clk),.d(d[63 :32 ]),.we(we),.spo(spo2_ ),.stride_op(stride_op),.kernelsize_op(kernelsize_op),.current_state(current_state), .poolingen_op(poolingen_op));         
Ram_Grain_32_32bit Ram_Grain_32_32bit3 (.a(a),.clk(clk),.d(d[95 :64 ]),.we(we),.spo(spo3_ ),.stride_op(stride_op),.kernelsize_op(kernelsize_op),.current_state(current_state), .poolingen_op(poolingen_op));         
Ram_Grain_32_32bit Ram_Grain_32_32bit4 (.a(a),.clk(clk),.d(d[127:96 ]),.we(we),.spo(spo4_ ),.stride_op(stride_op),.kernelsize_op(kernelsize_op),.current_state(current_state), .poolingen_op(poolingen_op));	       
       
assign spo={spo4_,spo3_,spo2_,spo1_};

endmodule  
//第二版删除
//Ram_Grain_8_32bit Ram_Grain_8_32bit17(.a(a17_),.clk(clk),.d(d[135:128]),.we(we),.spo(spo17_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit18(.a(a18_),.clk(clk),.d(d[143:136]),.we(we),.spo(spo18_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit19(.a(a19_),.clk(clk),.d(d[151:144]),.we(we),.spo(spo19_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit20(.a(a20_),.clk(clk),.d(d[159:152]),.we(we),.spo(spo20_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));	       
//Ram_Grain_8_32bit Ram_Grain_8_32bit21(.a(a21_),.clk(clk),.d(d[167:160]),.we(we),.spo(spo21_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit22(.a(a22_),.clk(clk),.d(d[175:168]),.we(we),.spo(spo22_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit23(.a(a23_),.clk(clk),.d(d[183:176]),.we(we),.spo(spo23_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit24(.a(a24_),.clk(clk),.d(d[191:184]),.we(we),.spo(spo24_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));	       
//Ram_Grain_8_32bit Ram_Grain_8_32bit25(.a(a25_),.clk(clk),.d(d[199:192]),.we(we),.spo(spo25_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit26(.a(a26_),.clk(clk),.d(d[207:200]),.we(we),.spo(spo26_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit27(.a(a27_),.clk(clk),.d(d[215:208]),.we(we),.spo(spo27_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit28(.a(a28_),.clk(clk),.d(d[223:216]),.we(we),.spo(spo28_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));	       
//Ram_Grain_8_32bit Ram_Grain_8_32bit29(.a(a29_),.clk(clk),.d(d[231:224]),.we(we),.spo(spo29_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit30(.a(a30_),.clk(clk),.d(d[239:232]),.we(we),.spo(spo30_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit31(.a(a31_),.clk(clk),.d(d[247:240]),.we(we),.spo(spo31_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit32(.a(a32_),.clk(clk),.d(d[255:248]),.we(we),.spo(spo32_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit33(.a(a33_),.clk(clk),.d(d[263:256]),.we(we),.spo(spo33_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit34(.a(a34_),.clk(clk),.d(d[271:264]),.we(we),.spo(spo34_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit35(.a(a35_),.clk(clk),.d(d[279:272]),.we(we),.spo(spo35_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit36(.a(a36_),.clk(clk),.d(d[287:280]),.we(we),.spo(spo36_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));	       
//Ram_Grain_8_32bit Ram_Grain_8_32bit37(.a(a37_),.clk(clk),.d(d[295:288]),.we(we),.spo(spo37_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit38(.a(a38_),.clk(clk),.d(d[303:296]),.we(we),.spo(spo38_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit39(.a(a39_),.clk(clk),.d(d[311:304]),.we(we),.spo(spo39_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit40(.a(a40_),.clk(clk),.d(d[319:312]),.we(we),.spo(spo40_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));	       
//Ram_Grain_8_32bit Ram_Grain_8_32bit41(.a(a41_),.clk(clk),.d(d[327:320]),.we(we),.spo(spo41_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit42(.a(a42_),.clk(clk),.d(d[335:328]),.we(we),.spo(spo42_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit43(.a(a43_),.clk(clk),.d(d[343:336]),.we(we),.spo(spo43_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit44(.a(a44_),.clk(clk),.d(d[351:344]),.we(we),.spo(spo44_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));	       
//Ram_Grain_8_32bit Ram_Grain_8_32bit45(.a(a45_),.clk(clk),.d(d[359:352]),.we(we),.spo(spo45_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit46(.a(a46_),.clk(clk),.d(d[367:360]),.we(we),.spo(spo46_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit47(.a(a47_),.clk(clk),.d(d[375:368]),.we(we),.spo(spo47_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit48(.a(a48_),.clk(clk),.d(d[383:376]),.we(we),.spo(spo48_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));	       
//Ram_Grain_8_32bit Ram_Grain_8_32bit49(.a(a49_),.clk(clk),.d(d[391:384]),.we(we),.spo(spo49_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit50(.a(a50_),.clk(clk),.d(d[399:392]),.we(we),.spo(spo50_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit51(.a(a51_),.clk(clk),.d(d[407:400]),.we(we),.spo(spo51_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit52(.a(a52_),.clk(clk),.d(d[415:408]),.we(we),.spo(spo52_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));	       
//Ram_Grain_8_32bit Ram_Grain_8_32bit53(.a(a53_),.clk(clk),.d(d[423:416]),.we(we),.spo(spo53_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit54(.a(a54_),.clk(clk),.d(d[431:424]),.we(we),.spo(spo54_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit55(.a(a55_),.clk(clk),.d(d[439:432]),.we(we),.spo(spo55_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit56(.a(a56_),.clk(clk),.d(d[447:440]),.we(we),.spo(spo56_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));	       
//Ram_Grain_8_32bit Ram_Grain_8_32bit57(.a(a57_),.clk(clk),.d(d[455:448]),.we(we),.spo(spo57_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit58(.a(a58_),.clk(clk),.d(d[463:456]),.we(we),.spo(spo58_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit59(.a(a59_),.clk(clk),.d(d[471:464]),.we(we),.spo(spo59_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit60(.a(a60_),.clk(clk),.d(d[479:472]),.we(we),.spo(spo60_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));	       
//Ram_Grain_8_32bit Ram_Grain_8_32bit61(.a(a61_),.clk(clk),.d(d[487:480]),.we(we),.spo(spo61_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit62(.a(a62_),.clk(clk),.d(d[495:488]),.we(we),.spo(spo62_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit63(.a(a63_),.clk(clk),.d(d[503:496]),.we(we),.spo(spo63_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
//Ram_Grain_8_32bit Ram_Grain_8_32bit64(.a(a64_),.clk(clk),.d(d[511:504]),.we(we),.spo(spo64_),.stride_op(stride_op),.kernelsize_op(kernelsize_op));         
/*
wire [3:0]aplus1;
assign aplus1=a[8:5]+1;

assign spo1 =(aplus1==0) ?{ spo1_[15:0], spo2_[31:16]}:spo1_;
assign spo2 =(aplus1==1) ?{ spo2_[15:0], spo3_[31:16]}:spo2_;
assign spo3 =((aplus1==0)||(aplus1==2)) ?{ spo3_[15:0], spo4_[31:16]}:spo3_;
assign spo4 =(aplus1==3)?{ spo4_[15:0], spo5_[31:16]}:spo4_;
assign spo5 =((aplus1==0)||(aplus1==4)) ?{ spo5_[15:0], spo6_[31:16]}:spo5_;
assign spo6 =((aplus1==1)||(aplus1==5)) ?{ spo6_[15:0], spo7_[31:16]}:spo6_;
assign spo7 =((aplus1==0)||(aplus1==2)||(aplus1==6))?{ spo7_[15:0], spo8_[31:16]}:spo7_;
assign spo8 =(aplus1==7)?{ spo8_[15:0],  spo9_[31:16]}:spo8_;           
assign spo9 =((aplus1==0)||(aplus1==8))?{ spo9_[15:0],spo10_[31:16]}:spo9_;
assign spo10=((aplus1==1)||(aplus1==9))?{ spo10_[15:0],spo11_[31:16]}:spo10_;
assign spo11=((aplus1==0)||(aplus1==2)||(aplus1==10))?{spo11_[15:0],spo12_[31:16]}:spo11_;
assign spo12=((aplus1==3)||(aplus1==11))?{spo12_[15:0],spo13_[31:16]}:spo12_;
assign spo13=((aplus1==0)||(aplus1==4)||(aplus1==12))?{spo13_[15:0],spo14_[31:16]}:spo13_;
assign spo14=((aplus1==1)||(aplus1==5)||(aplus1==13))?{spo14_[15:0],spo15_[31:16]}:spo14_;
assign spo15=((aplus1==0)||(aplus1==2)||(aplus1==6)||(aplus1==14))?{spo15_[15:0],spo16_[31:16]}:spo15_;
assign spo16=spo16_;

assign spo17 =(aplus1==0) ?{ spo17_[15:0], spo18_[31:16]}:spo17_;
assign spo18=(aplus1==1) ?{ spo18_[15:0], spo19_[31:16]}:spo18_;
assign spo19=((aplus1==0)||(aplus1==2)) ?{ spo19_[15:0], spo20_[31:16]}:spo19_;
assign spo20=(aplus1==3)?{ spo20_[15:0], spo21_[31:16]}:spo20_;
assign spo21=((aplus1==0)||(aplus1==4)) ?{ spo21_[15:0], spo22_[31:16]}:spo21_;
assign spo22=((aplus1==1)||(aplus1==5)) ?{ spo22_[15:0], spo23_[31:16]}:spo22_;
assign spo23=((aplus1==0)||(aplus1==2)||(aplus1==6))?{ spo23_[15:0], spo24_[31:16]}:spo23_;
assign spo24=(aplus1==7)?{ spo24_[15:0],  spo25_[31:16]}:spo24_;           
assign spo25=((aplus1==0)||(aplus1==8))?{ spo25_[15:0],spo26_[31:16]}:spo25_;
assign spo26=((aplus1==1)||(aplus1==9))?{ spo26_[15:0],spo27_[31:16]}:spo26_;
assign spo27=((aplus1==0)||(aplus1==2)||(aplus1==10))?{spo27_[15:0],spo28_[31:16]}:spo27_;
assign spo28=((aplus1==3)||(aplus1==11))?{spo28_[15:0],spo29_[31:16]}:spo28_;
assign spo29=((aplus1==0)||(aplus1==4)||(aplus1==12))?{spo29_[15:0],spo30_[31:16]}:spo29_;
assign spo30=((aplus1==1)||(aplus1==5)||(aplus1==13))?{spo30_[15:0],spo31_[31:16]}:spo30_;
assign spo31=((aplus1==0)||(aplus1==2)||(aplus1==6)||(aplus1==14))?{spo31_[15:0],spo32_[31:16]}:spo31_;
assign spo32=spo32_;

assign spo33 =(aplus1==0) ?{ spo33_[15:0], spo34_[31:16]}:spo33_;
assign spo34=(aplus1==1) ?{ spo34_[15:0], spo35_[31:16]}:spo34_;
assign spo35=((aplus1==0)||(aplus1==2)) ?{ spo35_[15:0], spo36_[31:16]}:spo35_;
assign spo36=(aplus1==3)?{ spo36_[15:0], spo37_[31:16]}:spo36_;
assign spo37=((aplus1==0)||(aplus1==4)) ?{ spo37_[15:0], spo38_[31:16]}:spo37_;
assign spo38=((aplus1==1)||(aplus1==5)) ?{ spo38_[15:0], spo39_[31:16]}:spo38_;
assign spo39=((aplus1==0)||(aplus1==2)||(aplus1==6))?{ spo39_[15:0], spo40_[31:16]}:spo39_;
assign spo40=(aplus1==7)?{ spo40_[15:0],  spo41_[31:16]}:spo40_;           
assign spo41=((aplus1==0)||(aplus1==8))?{ spo41_[15:0],spo42_[31:16]}:spo41_;
assign spo42=((aplus1==1)||(aplus1==9))?{ spo42_[15:0],spo43_[31:16]}:spo42_;
assign spo43=((aplus1==0)||(aplus1==2)||(aplus1==10))?{spo43_[15:0],spo44_[31:16]}:spo43_;
assign spo44=((aplus1==3)||(aplus1==11))?{spo44_[15:0],spo45_[31:16]}:spo44_;
assign spo45=((aplus1==0)||(aplus1==4)||(aplus1==12))?{spo45_[15:0],spo46_[31:16]}:spo45_;
assign spo46=((aplus1==1)||(aplus1==5)||(aplus1==13))?{spo46_[15:0],spo47_[31:16]}:spo46_;
assign spo47=((aplus1==0)||(aplus1==2)||(aplus1==6)||(aplus1==14))?{spo47_[15:0],spo48_[31:16]}:spo47_;
assign spo48=spo48_;

assign spo49 =(aplus1==0) ?{ spo49_[15:0], spo50_[31:16]}:spo49_;
assign spo50=(aplus1==1) ?{ spo50_[15:0], spo51_[31:16]}:spo50_;
assign spo51=((aplus1==0)||(aplus1==2)) ?{ spo51_[15:0], spo52_[31:16]}:spo51_;
assign spo52=(aplus1==3)?{ spo52_[15:0], spo53_[31:16]}:spo52_;
assign spo53=((aplus1==0)||(aplus1==4)) ?{ spo53_[15:0], spo54_[31:16]}:spo53_;
assign spo54=((aplus1==1)||(aplus1==5)) ?{ spo54_[15:0], spo55_[31:16]}:spo54_;
assign spo55=((aplus1==0)||(aplus1==2)||(aplus1==6))?{ spo55_[15:0], spo56_[31:16]}:spo55_;
assign spo56=(aplus1==7)?{ spo56_[15:0],  spo57_[31:16]}:spo56_;           
assign spo57=((aplus1==0)||(aplus1==8))?{ spo57_[15:0],spo58_[31:16]}:spo57_;
assign spo58=((aplus1==1)||(aplus1==9))?{ spo58_[15:0],spo59_[31:16]}:spo58_;
assign spo59=((aplus1==0)||(aplus1==2)||(aplus1==10))?{spo59_[15:0],spo60_[31:16]}:spo59_;
assign spo60=((aplus1==3)||(aplus1==11))?{spo60_[15:0],spo61_[31:16]}:spo60_;
assign spo61=((aplus1==0)||(aplus1==4)||(aplus1==12))?{spo61_[15:0],spo62_[31:16]}:spo61_;
assign spo62=((aplus1==1)||(aplus1==5)||(aplus1==13))?{spo62_[15:0],spo63_[31:16]}:spo62_;
assign spo63=((aplus1==0)||(aplus1==2)||(aplus1==6)||(aplus1==14))?{spo63_[15:0],spo64_[31:16]}:spo63_;
assign spo64=spo64_;
*/
//第四版删除
//同时支持“kernelsize”为1和3的情况，对于为1时由于”地址空余“所以下列表达不会出错
//assign spo1 =(a[6:0]==127) ?{ spo1_[15:0], spo2_[31:16]}:spo1_;
//assign spo2 =(a[7:0]==255) ?{ spo2_[15:0], spo3_[31:16]}:spo2_;
//assign spo3 =((a[6:0]==127)||(a[8:0]==383)) ?{ spo3_[15:0], spo4_[31:16]}:spo3_;
//assign spo4 =spo4_;
//
//assign spo5 =(a[6:0]==127) ?{ spo5_[15:0], spo6_[31:16]}:spo1_;
//assign spo6 =(a[7:0]==255) ?{ spo6_[15:0], spo7_[31:16]}:spo2_;
//assign spo7 =((a[6:0]==127)||(a[8:0]==383)) ?{ spo7_[15:0], spo8_[31:16]}:spo3_;
//assign spo8 =spo8_;
//
//assign spo9 =(a[6:0]==127) ?{ spo9_[15:0], spo10_[31:16]}:spo1_;
//assign spo10 =(a[7:0]==255) ?{ spo10_[15:0], spo11_[31:16]}:spo2_;
//assign spo11 =((a[6:0]==127)||(a[8:0]==383)) ?{ spo11_[15:0], spo12_[31:16]}:spo3_;
//assign spo12 =spo12_;
//
//assign spo13 =(a[6:0]==127) ?{ spo13_[15:0], spo14_[31:16]}:spo1_;
//assign spo14 =(a[7:0]==255) ?{ spo14_[15:0], spo15_[31:16]}:spo2_;
//assign spo15 =((a[6:0]==127)||(a[8:0]==383)) ?{ spo15_[15:0], spo16_[31:16]}:spo3_;
//assign spo16 =spo16_;



//第一版删除
/*
always@(*)
	case(paralism_op)
	0:begin	
			spo1 =spo1_ ;spo11=spo11_;spo21=spo21_;spo31=spo31_;spo41=spo41_;spo51=spo51_;spo61=spo61_;
	        spo2 =spo2_ ;spo12=spo12_;spo22=spo22_;spo32=spo32_;spo42=spo42_;spo52=spo52_;spo62=spo62_;
	        spo3 =spo3_ ;spo13=spo13_;spo23=spo23_;spo33=spo33_;spo43=spo43_;spo53=spo53_;spo63=spo63_;
	        spo4 =spo4_ ;spo14=spo14_;spo24=spo24_;spo34=spo34_;spo44=spo44_;spo54=spo54_;spo64=spo64_;
	        spo5 =spo5_ ;spo15=spo15_;spo25=spo25_;spo35=spo35_;spo45=spo45_;spo55=spo55_;
	        spo6 =spo6_ ;spo16=spo16_;spo26=spo26_;spo36=spo36_;spo46=spo46_;spo56=spo56_;
	        spo7 =spo7_ ;spo17=spo17_;spo27=spo27_;spo37=spo37_;spo47=spo47_;spo57=spo57_;
	        spo8 =spo8_ ;spo18=spo18_;spo28=spo28_;spo38=spo38_;spo48=spo48_;spo58=spo58_;
	        spo9 =spo9_ ;spo19=spo19_;spo29=spo29_;spo39=spo39_;spo49=spo49_;spo59=spo59_;
	        spo10=spo10_;spo20=spo20_;spo30=spo30_;spo40=spo40_;spo50=spo50_;spo60=spo60_;
	  end
	1:begin 
		if(a[4:0]==31) begin
			spo1 ={ spo1_[15:0], spo2_[31:16]}; spo33={spo33_[15:0],spo34_[31:16]};
			spo3 ={ spo3_[15:0], spo4_[31:16]}; spo35={spo35_[15:0],spo36_[31:16]};
			spo5 ={ spo5_[15:0], spo6_[31:16]}; spo37={spo37_[15:0],spo38_[31:16]};
			spo7 ={ spo7_[15:0], spo8_[31:16]}; spo39={spo39_[15:0],spo40_[31:16]};
			spo9 ={ spo9_[15:0],spo10_[31:16]}; spo41={spo41_[15:0],spo42_[31:16]};
			spo11={spo11_[15:0],spo12_[31:16]}; spo43={spo43_[15:0],spo44_[31:16]};
			spo13={spo13_[15:0],spo14_[31:16]}; spo45={spo45_[15:0],spo46_[31:16]};
			spo15={spo15_[15:0],spo16_[31:16]}; spo47={spo47_[15:0],spo48_[31:16]};
			spo17={spo17_[15:0],spo18_[31:16]}; spo49={spo49_[15:0],spo50_[31:16]};
			spo19={spo19_[15:0],spo20_[31:16]}; spo51={spo51_[15:0],spo52_[31:16]};
			spo21={spo21_[15:0],spo22_[31:16]}; spo53={spo53_[15:0],spo54_[31:16]};
			spo23={spo23_[15:0],spo24_[31:16]}; spo55={spo55_[15:0],spo56_[31:16]};
			spo25={spo25_[15:0],spo26_[31:16]}; spo57={spo57_[15:0],spo58_[31:16]};
			spo27={spo27_[15:0],spo28_[31:16]}; spo59={spo59_[15:0],spo60_[31:16]};
			spo29={spo29_[15:0],spo30_[31:16]}; spo61={spo61_[15:0],spo62_[31:16]};
			spo31={spo31_[15:0],spo32_[31:16]}; spo63={spo63_[15:0],spo64_[31:16]};
			end
		else begin
			spo1 = spo1_; spo33=spo33_;
			spo3 = spo3_; spo35=spo35_;
			spo5 = spo5_; spo37=spo37_;
			spo7 = spo7_; spo39=spo39_;
			spo9 = spo9_; spo41=spo41_;
			spo11=spo11_; spo43=spo43_;
			spo13=spo13_; spo45=spo45_;
			spo15=spo15_; spo47=spo47_;
			spo17=spo17_; spo49=spo49_;
			spo19=spo19_; spo51=spo51_;
			spo21=spo21_; spo53=spo53_;
			spo23=spo23_; spo55=spo55_;
			spo25=spo25_; spo57=spo57_;
			spo27=spo27_; spo59=spo59_;
			spo29=spo29_; spo61=spo61_;
			spo31=spo31_; spo63=spo63_;			
			end
			spo2 =spo2_ ;spo4 =spo4_ ;spo6 =spo6_ ;spo8 =spo8_ ;
			spo18=spo18_;spo20=spo20_;spo22=spo22_;spo24=spo24_;
			spo34=spo34_;spo36=spo36_;spo38=spo38_;spo40=spo40_;
			spo50=spo50_;spo52=spo52_;spo54=spo54_;spo56=spo56_;
	        spo10=spo10_;spo12=spo12_;spo14=spo14_;spo16=spo16_;
	        spo26=spo26_;spo28=spo28_;spo30=spo30_;spo32=spo32_;
	        spo42=spo42_;spo44=spo44_;spo46=spo46_;spo48=spo48_;
	        spo58=spo58_;spo60=spo60_;spo62=spo62_;spo64=spo64_;
	  end
	2:begin
		if(a[4:0]==31) begin
			spo1 ={ spo1_[15:0], spo2_[31:16]};  
			spo5 ={ spo5_[15:0], spo6_[31:16]};  
			spo9 ={ spo9_[15:0],spo10_[31:16]};  
            spo13={spo13_[15:0],spo14_[31:16]};  
            spo17={spo17_[15:0],spo18_[31:16]};  
            spo21={spo21_[15:0],spo22_[31:16]};  
            spo25={spo25_[15:0],spo26_[31:16]};  
            spo29={spo29_[15:0],spo30_[31:16]};  
			spo33={spo33_[15:0],spo34_[31:16]};	
			spo37={spo37_[15:0],spo38_[31:16]};  
			spo41={spo41_[15:0],spo42_[31:16]};	
			spo45={spo45_[15:0],spo46_[31:16]};  
			spo49={spo49_[15:0],spo50_[31:16]};  
			spo53={spo53_[15:0],spo54_[31:16]};  
			spo57={spo57_[15:0],spo58_[31:16]};  
			spo61={spo61_[15:0],spo62_[31:16]};  
			end
		else if(a[5:0]==63)	begin
			spo2 ={spo2_[15:0], spo3_[31:16]};
			spo6 ={spo6_[15:0], spo7_[31:16]};
			spo10={spo10_[15:0],spo11_[31:16]};
			spo14={spo14_[15:0],spo15_[31:16]};
			spo18={spo18_[15:0],spo19_[31:16]};
			spo22={spo22_[15:0],spo23_[31:16]};
			spo26={spo26_[15:0],spo27_[31:16]};
			spo30={spo30_[15:0],spo31_[31:16]};
			spo34={spo34_[15:0],spo35_[31:16]};	
			spo38={spo38_[15:0],spo39_[31:16]};
			spo42={spo42_[15:0],spo43_[31:16]};	
			spo46={spo46_[15:0],spo47_[31:16]};
			spo50={spo50_[15:0],spo51_[31:16]};
			spo54={spo54_[15:0],spo55_[31:16]};
			spo58={spo58_[15:0],spo59_[31:16]};
			spo62={spo62_[15:0],spo63_[31:16]};
			end
		else if(a[6:0]==95) begin		
			spo3 ={spo3_[15:0], spo4_[31:16]};  
			spo7 ={spo7_[15:0], spo8_[31:16]};  
            spo11={spo11_[15:0],spo12_[31:16]}; 
            spo15={spo15_[15:0],spo16_[31:16]}; 
            spo19={spo19_[15:0],spo20_[31:16]}; 
            spo23={spo23_[15:0],spo24_[31:16]}; 
            spo27={spo27_[15:0],spo28_[31:16]}; 
            spo31={spo31_[15:0],spo32_[31:16]}; 
            spo35={spo35_[15:0],spo36_[31:16]}; 
            spo39={spo39_[15:0],spo40_[31:16]}; 
            spo43={spo43_[15:0],spo44_[31:16]}; 
            spo47={spo47_[15:0],spo48_[31:16]}; 
            spo51={spo51_[15:0],spo52_[31:16]}; 
            spo55={spo55_[15:0],spo56_[31:16]}; 
            spo59={spo59_[15:0],spo60_[31:16]}; 
            spo63={spo63_[15:0],spo64_[31:16]}; 
			end
		else begin
			  spo3 =spo3_; 
            spo7 =spo7_; 
            spo11=spo11_;
            spo15=spo15_;
            spo19=spo19_;
            spo23=spo23_;
            spo27=spo27_;
            spo31=spo31_;
            spo35=spo35_;
            spo39=spo39_;
            spo43=spo43_;
            spo47=spo47_;
            spo51=spo51_;
            spo55=spo55_;
            spo59=spo59_;
            spo63=spo63_;
			end
			  spo4 =spo4_ ;
            spo8 =spo8_ ;
            spo12=spo12_;
            spo16=spo16_;
            spo20=spo20_;
            spo24=spo24_;
            spo28=spo28_;
            spo32=spo32_;
            spo36=spo36_;
            spo40=spo40_;
            spo44=spo44_;
            spo48=spo48_;
            spo52=spo52_;
            spo56=spo56_;
            spo60=spo60_;
            spo64=spo64_;		
	  end
	3:begin if(a[4:0]==31) begin
			spo1 ={ spo1_[15:0],   spo2_[31:16]};   
            spo9 ={ spo9_[15:0],  spo10_[31:16]};   
            spo17={ spo17_[15:0], spo18_[31:16]};  
            spo25={ spo25_[15:0], spo26_[31:16]};  
            spo33={ spo33_[15:0], spo34_[31:16]};  
            spo41={ spo41_[15:0], spo42_[31:16]};  
            spo49={ spo49_[15:0], spo50_[31:16]};  
            spo57={ spo57_[15:0], spo58_[31:16]};
			end
			else  begin
			spo1 =spo1_ ;   
            spo9 =spo9_ ;   
            spo17=spo17_;  
            spo25=spo25_;  
            spo33=spo33_;  
            spo41=spo41_;  
            spo49=spo49_;  
            spo57=spo57_;
			end
			if(a[5:0]==63) begin
			  spo2 ={ spo2_[15:0],  spo3_[31:16]};
			  spo10={ spo10_[15:0], spo11_[31:16]};
              spo18={ spo18_[15:0], spo19_[31:16]};
              spo26={ spo26_[15:0], spo27_[31:16]};
              spo34={ spo34_[15:0], spo35_[31:16]};
              spo42={ spo42_[15:0], spo43_[31:16]};
              spo50={ spo50_[15:0], spo51_[31:16]};
              spo58={ spo58_[15:0], spo59_[31:16]};
			end
	 		else begin
			  spo2 =spo2_;
			  spo10=spo10_;
              spo18=spo18_;
              spo26=spo26_;
              spo34=spo34_;
              spo42=spo42_;
              spo50=spo50_;
              spo58=spo58_;
			end
			if(a[6:0]==95) begin
			spo3 ={ spo3_[15:0],  spo4_[31:16]}; 
            spo11={ spo11_[15:0], spo12_[31:16]}; 
            spo19={ spo19_[15:0], spo20_[31:16]}; 
            spo27={ spo27_[15:0], spo28_[31:16]}; 
            spo35={ spo35_[15:0], spo36_[31:16]}; 
            spo43={ spo43_[15:0], spo44_[31:16]}; 
            spo51={ spo51_[15:0], spo52_[31:16]}; 
            spo59={ spo59_[15:0], spo60_[31:16]};
			end
			else begin
			spo3 =spo3_ ; 
            spo11=spo11_; 
            spo19=spo19_; 
            spo27=spo27_; 
            spo35=spo35_; 
            spo43=spo43_; 
            spo51=spo51_; 
            spo59=spo59_;
			end
			if(a[6:0]==127) begin
			  spo4 ={ spo4_[15:0],  spo5_[31:16]} ;
			  spo12={ spo12_[15:0], spo13_[31:16]};
			  spo20={ spo20_[15:0], spo21_[31:16]};
			  spo28={ spo28_[15:0], spo29_[31:16]};
			  spo36={ spo36_[15:0], spo37_[31:16]};
			  spo44={ spo44_[15:0], spo45_[31:16]};
			  spo52={ spo52_[15:0], spo53_[31:16]};
			  spo60={ spo60_[15:0], spo61_[31:16]};
			end	
			else begin
			  spo4 =spo4_ ;
			  spo12=spo12_;
			  spo20=spo20_;
			  spo28=spo28_;
			  spo36=spo36_;
			  spo44=spo44_;
			  spo52=spo52_;
			  spo60=spo60_;
			end	
			if(a[7:0]==159) begin
			spo5 ={ spo5_[15:0],  spo6_[31:16]} ; 
            spo13={ spo13_[15:0], spo14_[31:16]}; 
            spo21={ spo21_[15:0], spo22_[31:16]}; 
            spo29={ spo29_[15:0], spo30_[31:16]}; 
            spo37={ spo37_[15:0], spo38_[31:16]}; 
            spo45={ spo45_[15:0], spo46_[31:16]}; 
            spo53={ spo53_[15:0], spo54_[31:16]}; 
            spo61={ spo61_[15:0], spo62_[31:16]}; 
			end 
			else  begin
			spo5 =spo5_ ; 
            spo13=spo13_; 
            spo21=spo21_; 
            spo29=spo29_; 
            spo37=spo37_; 
            spo45=spo45_; 
            spo53=spo53_; 
            spo61=spo61_; 
			end
			if(a[7:0]==191) begin
			spo6 ={ spo6_ [15:0], spo6_[31:16]} ; 
            spo14={ spo14_[15:0], spo14_[31:16]}; 
            spo22={ spo22_[15:0], spo22_[31:16]}; 
            spo30={ spo30_[15:0], spo30_[31:16]}; 
            spo38={ spo38_[15:0], spo38_[31:16]}; 
            spo46={ spo46_[15:0], spo46_[31:16]}; 
            spo54={ spo54_[15:0], spo54_[31:16]}; 
            spo62={ spo62_[15:0], spo62_[31:16]}; 
			end 
			else  begin
			spo6 =spo6_ ; 
            spo14=spo14_; 
            spo22=spo22_; 
            spo30=spo30_; 
            spo38=spo38_; 
            spo46=spo46_; 
            spo54=spo54_; 
            spo62=spo62_; 
			end
			if(a[7:0==223]) begin
			spo7 ={ spo7_ [15:0], spo8_[31:16]}; 
            spo15={ spo15_[15:0], spo16_[31:16]};
            spo23={ spo23_[15:0], spo24_[31:16]};
            spo31={ spo31_[15:0], spo32_[31:16]};
            spo39={ spo39_[15:0], spo40_[31:16]};
            spo47={ spo47_[15:0], spo48_[31:16]};
            spo55={ spo55_[15:0], spo56_[31:16]};
            spo63={ spo63_[15:0], spo64_[31:16]};
			end
			else begin
			spo7 =spo7_ ; 
            spo15=spo15_; 
            spo23=spo23_; 
            spo31=spo31_; 
            spo39=spo39_; 
            spo47=spo47_; 
            spo55=spo55_; 
            spo63=spo63_; 
			end
			begin
			spo8 =spo8_; 
			spo16=spo16_;
			spo24=spo24_;
			spo32=spo32_;
			spo40=spo40_;
			spo48=spo48_;
			spo56=spo56_;
			spo64=spo64_;
			end
		end			
  	4:begin if(a[4:0]==31) begin
  			spo1 ={ spo1_[15:0],  spo2_[31:16]};  
            spo17={ spo17_[15:0], spo18_[31:16]};  
            spo33={ spo33_[15:0], spo34_[31:16]};  
            spo49={ spo49_[15:0], spo50_[31:16]}; 
			end
			else begin
			spo1 =spo1_ ;
			spo17=spo17_;
			spo33=spo33_;
			spo49=spo49_;
			end
			if(a[5:0]==63) begin
  			spo2 ={ spo2_[15:0],  spo3_[31:16]}; 
            spo18={ spo18_[15:0], spo19_[31:16]};  
            spo34={ spo34_[15:0], spo35_[31:16]};  
            spo50={ spo50_[15:0], spo51_[31:16]}; 
			end
			else begin
			spo2 =spo2_ ;
			spo18=spo18_;
			spo34=spo34_;
			spo50=spo50_;
			end
			if(a[6:0]==95) begin
  			spo3 ={ spo3_[15:0],  spo4_[31:16]} ;
            spo19={ spo19_[15:0], spo20_[31:16]};  
            spo35={ spo35_[15:0], spo36_[31:16]};  
            spo51={ spo51_[15:0], spo52_[31:16]}; 
			end
			else begin
			spo3 =spo3_ ;
			spo19=spo19_;
			spo35=spo35_;
			spo51=spo51_;
			end
			if(a[6:0]==127) begin
  			spo4 ={ spo4_[15:0],  spo5_[31:16]};
            spo20={ spo20_[15:0], spo21_[31:16]};  
            spo36={ spo36_[15:0], spo37_[31:16]};  
            spo52={ spo52_[15:0], spo53_[31:16]}; 
			end
			else begin
			spo4 =spo4_ ;
			spo20=spo20_;
			spo36=spo36_;
			spo52=spo52_;
			end
			if(a[7:0]==159) begin
  			spo5 ={ spo5_[15:0],  spo6_[31:16]};
            spo21={ spo21_[15:0], spo22_[31:16]};  
            spo37={ spo37_[15:0], spo38_[31:16]};  
            spo53={ spo53_[15:0], spo54_[31:16]}; 
			end
			else begin
			spo5 =spo5_ ;
			spo21=spo21_;
			spo37=spo37_;
			spo53=spo53_;
			end
			if(a[7:0]==191) begin
  			spo6 ={ spo6_[15:0],  spo7_[31:16]};
            spo22={ spo22_[15:0], spo23_[31:16]};  
            spo38={ spo38_[15:0], spo39_[31:16]};  
            spo54={ spo54_[15:0], spo55_[31:16]}; 
			end
			else begin
			spo6 =spo6_ ;
			spo22=spo22_;
			spo38=spo38_;
			spo54=spo54_;
			end
			if(a[7:0]==223) begin
  			spo7 ={ spo7_[15:0],  spo8_[31:16]};
            spo23={ spo23_[15:0], spo24_[31:16]};  
            spo39={ spo39_[15:0], spo40_[31:16]};  
            spo55={ spo55_[15:0], spo56_[31:16]}; 
			end
			else begin
			spo7 =spo7_ ;
			spo23=spo23_;
			spo39=spo39_;
			spo55=spo55_;
			end
			if(a[7:0]==255) begin
  			spo8 ={ spo8_[15:0],  spo9_[31:16]};
            spo24={ spo24_[15:0], spo25_[31:16]};  
            spo40={ spo40_[15:0], spo41_[31:16]};  
            spo56={ spo56_[15:0], spo57_[31:16]}; 
			end
			else begin
			spo8 =spo8_ ;
			spo24=spo24_;
			spo40=spo40_;
			spo56=spo56_;
			end
			if(a[8:0]==287) begin
  			spo9 ={ spo9_[15:0],  spo10_[31:16]};
            spo25={ spo25_[15:0], spo26_[31:16]};  
            spo41={ spo41_[15:0], spo42_[31:16]};  
            spo57={ spo57_[15:0], spo58_[31:16]}; 
			end
			else begin
			spo9 = spo9_;
			spo25=spo25_;
			spo41=spo41_;
			spo57=spo57_;
			end
			if(a[8:0]==319) begin
  			spo10={ spo10_[15:0], spo11_[31:16]};
            spo26={ spo26_[15:0], spo27_[31:16]};  
            spo42={ spo42_[15:0], spo43_[31:16]};  
            spo58={ spo58_[15:0], spo59_[31:16]}; 
			end
			else begin
			spo10=spo10_;
			spo26=spo26_;
			spo42=spo42_;
			spo58=spo58_;
			end
			if(a[8:0]==351) begin
  			spo11={ spo11_[15:0], spo12_[31:16]};
            spo27={ spo27_[15:0], spo28_[31:16]};  
            spo43={ spo43_[15:0], spo44_[31:16]};  
            spo59={ spo59_[15:0], spo60_[31:16]}; 
			end
			else begin
			spo11=spo11_;
			spo27=spo27_;
			spo43=spo43_;
			spo59=spo59_;
			end
			if(a[8:0]==383) begin
  			spo12={ spo12_[15:0], spo13_[31:16]};
            spo28={ spo28_[15:0], spo29_[31:16]};  
            spo44={ spo44_[15:0], spo45_[31:16]};  
            spo60={ spo60_[15:0], spo61_[31:16]}; 
			end
			else begin
			spo12=spo12_;
			spo28=spo28_;
			spo44=spo44_;
			spo60=spo60_;
			end
			if(a[8:0]==415) begin
  			spo13={ spo13_[15:0], spo14_[31:16]};
            spo29={ spo29_[15:0], spo30_[31:16]};  
            spo45={ spo45_[15:0], spo46_[31:16]};  
            spo61={ spo61_[15:0], spo62_[31:16]}; 
			end
			else begin
			spo13=spo13_;
			spo29=spo29_;
			spo45=spo45_;
			spo61=spo61_;
			end
			if(a[8:0]==447) begin
  			spo14={ spo14_[15:0], spo15_[31:16]};
            spo30={ spo30_[15:0], spo31_[31:16]}; 
            spo46={ spo46_[15:0], spo47_[31:16]}; 
            spo62={ spo62_[15:0], spo63_[31:16]};
			end
			else begin
			spo14=spo14_;
			spo30=spo30_;
			spo46=spo46_;
			spo62=spo62_;
			end
			if(a[8:0]==479) begin
  			spo15={ spo15_[15:0], spo16_[31:16]};
            spo31={ spo31_[15:0], spo32_[31:16]};  
            spo47={ spo47_[15:0], spo48_[31:16]};  
            spo63={ spo63_[15:0], spo64_[31:16]}; 
			end
			else begin
			spo15=spo15_ ;
			spo31=spo31_; 
			spo47=spo47_; 
			spo63=spo63_; 
			end 
			spo16=spo16_;
  			spo32=spo32_;
  			spo48=spo48_;
  			spo64=spo64_;
  	  end		
	endcase

reg [2047:0] spo_kernelsize3;
reg [2047:0] spo_kernelsize1;


	
always@(posedge clk)
	casex({paralism_op,a[8:3]})   //synopsys parallel_case
	9'b000_xxxx: spo_kernelsize3={spo1,spo2,spo3,spo4,spo5,spo6,spo7,spo8, 
						spo9 ,spo10,spo11,spo12,spo13,spo14,spo15,spo16,
						spo17,spo18,spo19,spo20,spo21,spo22,spo23,spo24,
						spo25,spo26,spo27,spo28,spo29,spo30,spo31,spo32,
						spo33,spo34,spo35,spo36,spo37,spo38,spo39,spo40,
						spo41,spo42,spo43,spo44,spo45,spo46,spo47,spo48,
						spo49,spo50,spo51,spo52,spo53,spo54,spo55,spo56,
						spo57,spo58,spo59,spo60,spo61,spo62,spo63,spo64};
						
	9'b001_xxx0: spo_kernelsize3={1024'b0,spo1,spo3,spo5,spo7,spo9,spo11,spo13,spo15,
						spo17,spo19,spo21,spo23,spo25,spo27,spo29,spo31,spo33,
						spo35,spo37,spo39,spo41,spo43,spo45,spo47,spo49,spo51,
						spo53,spo55,spo57,spo59,spo61,spo63};
	9'b001_xxx1: spo_kernelsize3={1024'b0,spo2,spo4,spo6,spo8,spo10,spo12,spo14,spo16,
						spo18,spo20,spo22,spo24,spo26,spo28,spo30,spo32,
						spo34,spo36,spo38,spo40,spo42,spo44,spo46,spo48,
						spo50,spo52,spo54,spo56,spo58,spo60,spo62,spo64};
						
	9'b010_xx00: spo_kernelsize3={1536'b0,spo1,spo5,spo9,spo13,spo17,spo21,spo25,spo29, 
						spo33,spo37,spo41,spo45,spo49,spo53,spo57,spo61};
	9'b010_xx01: spo_kernelsize3={1536'b0,spo2,spo6,spo10,spo14,spo18,spo22,spo26,spo30,
						spo34,spo38,spo42,spo46,spo50,spo54,spo58,spo62};
	9'b010_xx10: spo_kernelsize3={1536'b0,spo3,spo7,spo11,spo15,spo19,spo23,spo27,spo31,
						spo35,spo39,spo43,spo47,spo51,spo55,spo59,spo63};
	9'b010_xx11: spo_kernelsize3={1536'b0,spo4,spo8,spo12,spo16,spo20,spo24,spo28,spo32,
						spo36,spo40,spo44,spo48,spo52,spo56,spo60,spo64};	

	9'b011_x000: spo_kernelsize3={1792'b0,spo1,spo9 ,spo17,spo25,spo33,spo41,spo49,spo57};					
	9'b011_x001: spo_kernelsize3={1792'b0,spo2,spo10,spo18,spo26,spo34,spo42,spo50,spo58};	
	9'b011_x010: spo_kernelsize3={1792'b0,spo3,spo11,spo19,spo27,spo35,spo43,spo51,spo59};	
	9'b011_x011: spo_kernelsize3={1792'b0,spo4,spo12,spo20,spo28,spo36,spo44,spo52,spo60};	
	9'b011_x100: spo_kernelsize3={1792'b0,spo5,spo13,spo21,spo29,spo37,spo45,spo53,spo61};	
	9'b011_x101: spo_kernelsize3={1792'b0,spo6,spo14,spo22,spo30,spo38,spo46,spo54,spo62};
	9'b011_x110: spo_kernelsize3={1792'b0,spo7,spo15,spo23,spo31,spo39,spo47,spo55,spo63};
	9'b011_x111: spo_kernelsize3={1792'b0,spo8,spo16,spo24,spo32,spo40,spo48,spo56,spo64};
	
	9'b100_0000: spo_kernelsize3={1920'b0,spo1 ,spo17,spo33,spo49};	
	9'b100_0001: spo_kernelsize3={1920'b0,spo2 ,spo18,spo34,spo50};	                               
	9'b100_0010: spo_kernelsize3={1920'b0,spo3 ,spo19,spo35,spo51};                            
	9'b100_0011: spo_kernelsize3={1920'b0,spo4 ,spo20,spo36,spo52};                            
	9'b100_0100: spo_kernelsize3={1920'b0,spo5 ,spo21,spo37,spo53};                            
	9'b100_0101: spo_kernelsize3={1920'b0,spo6 ,spo22,spo38,spo54};                            
	9'b100_0110: spo_kernelsize3={1920'b0,spo7 ,spo23,spo39,spo55};                            
	9'b100_0111: spo_kernelsize3={1920'b0,spo8 ,spo24,spo40,spo56};                            
	9'b100_1000: spo_kernelsize3={1920'b0,spo9 ,spo25,spo41,spo57};                            
	9'b100_1001: spo_kernelsize3={1920'b0,spo10,spo26,spo42,spo58};                            
	9'b100_1010: spo_kernelsize3={1920'b0,spo11,spo27,spo43,spo59};                            
	9'b100_1011: spo_kernelsize3={1920'b0,spo12,spo28,spo44,spo60};                            
	9'b100_1100: spo_kernelsize3={1920'b0,spo13,spo29,spo45,spo61};                            
	9'b100_1101: spo_kernelsize3={1920'b0,spo14,spo30,spo46,spo62};                            
	9'b100_1110: spo_kernelsize3={1920'b0,spo15,spo31,spo47,spo63};                            
	9'b100_1111: spo_kernelsize3={1920'b0,spo16,spo32,spo48,spo64};  
	default: spo_kernelsize3=0;
	endcase
 

//256    //read_addr:  kernelsize=1@ 0-3   
//128    //read_addr:  kernelsize=1@ 0-7   
//64	 //read_addr:  kernelsize=1@ 0-15   
//32	 //read_addr:  kernelsize=1@ 0-31   
//16	 //read_addr:  kernelsize=1@ 0-63   
//8	     //read_addr:  kernelsize=1@ 0-127   
//4	     //read_addr:  kernelsize=1@ 0-255  

always@(posedge clk)
	casex({paralism_op,a[7:2]})   //synopsys parallel_case
	9'b000_xxxx: spo_kernelsize1={spo1_,spo2_,spo3_,spo4_,spo5_,spo6_,spo7_,spo8_, 
						spo9_, spo10_,spo11_,spo12_,spo13_,spo14_,spo15_,spo16_,
						spo17_,spo18_,spo19_,spo20_,spo21_,spo22_,spo23_,spo24_,
						spo25_,spo26_,spo27_,spo28_,spo29_,spo30_,spo31_,spo32_,
						spo33_,spo34_,spo35_,spo36_,spo37_,spo38_,spo39_,spo40_,
						spo41_,spo42_,spo43_,spo44_,spo45_,spo46_,spo47_,spo48_,
						spo49_,spo50_,spo51_,spo52_,spo53_,spo54_,spo55_,spo56_,
						spo57_,spo58_,spo59_,spo60_,spo61_,spo62_,spo63_,spo64_};
						
	9'b001_xxx0: spo_kernelsize1={1024'b0,spo1_,spo3_,spo5_,spo7_,spo9_,spo11_,spo13_,spo15_,
						spo17_,spo19_,spo21_,spo23_,spo25_,spo27_,spo29_,spo31_,spo33_,
						spo35_,spo37_,spo39_,spo41_,spo43_,spo45_,spo47_,spo49_,spo51_,
						spo53_,spo55_,spo57_,spo59_,spo61_,spo63_};
	9'b001_xxx1: spo_kernelsize1={1024'b0,spo2_,spo4_,spo6_,spo8_,spo10_,spo12_,spo14_,spo16_,
						spo18_,spo20_,spo22_,spo24_,spo26_,spo28_,spo30_,spo32_,
						spo34_,spo36_,spo38_,spo40_,spo42_,spo44_,spo46_,spo48_,
						spo50_,spo52_,spo54_,spo56_,spo58_,spo60_,spo62_,spo64_};
						
	9'b010_xx00: spo_kernelsize1={1536'b0,spo1_,spo5_,spo9_,spo13_,spo17_,spo21_,spo25_,spo29_, 
						spo33_,spo37_,spo41_,spo45_,spo49_,spo53_,spo57_,spo61_};
	9'b010_xx01: spo_kernelsize1={1536'b0,spo2,spo6_,spo10_,spo14_,spo18_,spo22_,spo26_,spo30_,
						spo34_,spo38_,spo42_,spo46_,spo50_,spo54_,spo58_,spo62_};
	9'b010_xx10: spo_kernelsize1={1536'b0,spo3,spo7_,spo11_,spo15_,spo19_,spo23_,spo27_,spo31_,
						spo35_,spo39_,spo43_,spo47_,spo51_,spo55_,spo59_,spo63_};
	9'b010_xx11: spo_kernelsize1={1536'b0,spo4,spo8_,spo12_,spo16_,spo20_,spo24_,spo28_,spo32_,
						spo36_,spo40_,spo44_,spo48_,spo52_,spo56_,spo60_,spo64_};	

	9'b011_x000: spo_kernelsize1={1792'b0,spo1_,spo9_ ,spo17_,spo25_,spo33_,spo41_,spo49_,spo57_};					
	9'b011_x001: spo_kernelsize1={1792'b0,spo2_,spo10_,spo18_,spo26_,spo34_,spo42_,spo50_,spo58_};	
	9'b011_x010: spo_kernelsize1={1792'b0,spo3_,spo11_,spo19_,spo27_,spo35_,spo43_,spo51_,spo59_};	
	9'b011_x011: spo_kernelsize1={1792'b0,spo4_,spo12_,spo20_,spo28_,spo36_,spo44_,spo52_,spo60_};	
	9'b011_x100: spo_kernelsize1={1792'b0,spo5_,spo13_,spo21_,spo29_,spo37_,spo45_,spo53_,spo61_};	
	9'b011_x101: spo_kernelsize1={1792'b0,spo6_,spo14_,spo22_,spo30_,spo38_,spo46_,spo54_,spo62_};
	9'b011_x110: spo_kernelsize1={1792'b0,spo7_,spo15_,spo23_,spo31_,spo39_,spo47_,spo55_,spo63_};
	9'b011_x111: spo_kernelsize1={1792'b0,spo8_,spo16_,spo24_,spo32_,spo40_,spo48_,spo56_,spo64_};
	
	9'b100_0000: spo_kernelsize1={1920'b0,spo1_ ,spo17_,spo33_,spo49_};	
	9'b100_0001: spo_kernelsize1={1920'b0,spo2_ ,spo18_,spo34_,spo50_};	                               
	9'b100_0010: spo_kernelsize1={1920'b0,spo3_ ,spo19_,spo35_,spo51_};                            
	9'b100_0011: spo_kernelsize1={1920'b0,spo4_ ,spo20_,spo36_,spo52_};                            
	9'b100_0100: spo_kernelsize1={1920'b0,spo5_ ,spo21_,spo37_,spo53_};                            
	9'b100_0101: spo_kernelsize1={1920'b0,spo6_ ,spo22_,spo38_,spo54_};                            
	9'b100_0110: spo_kernelsize1={1920'b0,spo7_ ,spo23_,spo39_,spo55_};                            
	9'b100_0111: spo_kernelsize1={1920'b0,spo8_ ,spo24_,spo40_,spo56_};                            
	9'b100_1000: spo_kernelsize1={1920'b0,spo9_ ,spo25_,spo41_,spo57_};                            
	9'b100_1001: spo_kernelsize1={1920'b0,spo10_,spo26_,spo42_,spo58_};                            
	9'b100_1010: spo_kernelsize1={1920'b0,spo11_,spo27_,spo43_,spo59_};                            
	9'b100_1011: spo_kernelsize1={1920'b0,spo12_,spo28_,spo44_,spo60_};                            
	9'b100_1100: spo_kernelsize1={1920'b0,spo13_,spo29_,spo45_,spo61_};                            
	9'b100_1101: spo_kernelsize1={1920'b0,spo14_,spo30_,spo46_,spo62_};                            
	9'b100_1110: spo_kernelsize1={1920'b0,spo15_,spo31_,spo47_,spo63_};                            
	9'b100_1111: spo_kernelsize1={1920'b0,spo16_,spo32_,spo48_,spo64_};
	
	default: spo_kernelsize1=0;
	endcase

*/
          
 










































































































































































	