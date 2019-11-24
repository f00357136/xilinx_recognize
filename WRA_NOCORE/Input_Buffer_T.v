`timescale 1ns/1ps
module Input_Buffer_T;
reg  clk, we,we_Gt, rst, poolingen_op;	
reg  [11:0]a; // write:0-4095(64*64); read_max:0-510; read_min:0-63
reg  [7:0]d;

reg  stride_op;
reg  [1:0] fstL;
reg  kernelsize_op;
reg  inputbstart_op;
reg  [8:0] numslideH_op; //max=64
reg  [4:0] numslideV_op; //max=31
reg  [4:0] numswitchH_op; //横向窗口滑动通道转换距离
reg  [4:0] NInch_D_PInch_op; //max=512/16=32
reg  [4:0] NOuch_D_POuch_op; //max=512/16=32
reg  [7:0] cellnum_op;
reg  [7:0] linenum_op;
reg  firstlayer_op;
reg  [1:0] fixpoint_op;
reg  padding_op;
reg  relu_op;
//--------------------------Fixpoint------------------------//(1)Input_Trans (2)DSP16 (3)Channel_Accumu1_16 (4)Output_Trans
//-----------0:Input_Trans@[ 7:0]&&DSP16@[12:5]-------------//
//-----------1:Input_Trans@[10:3]&&DSP16@[12:5]-------------//
//-----------2:Input_Trans@[ 7:0]&&DSP16@[13:6]-------------//
//-----------3:Input_Trans@[10:3]&&DSP16@[13:6]-------------// 
//----------------------------------------------------------// 

always #10 clk=~clk;
//
//initial begin
//	clk<=0;
//	rst<=0;
//	we<=1;
//	firstlayer_op<=1;
//	numswitchH_op<=30;//13;//30;//2 =(inS-2)/2-1; if NInch_D_PInch_op=0 =+1
//	stride_op<=1;
//	kernelsize_op<=1;//1; 
//	numslideH_op<=62;//13;//62; //126 =(numswitchH_op+1)*(NInch_D_PInch_op+1)
//	numslideV_op<=30;//12;//30;//8 =(inS-2)/2-1
//	inputbstart_op<=0;
//	NInch_D_PInch_op<=1;//0;//1;//31 =Inch/InP-1
//	NOuch_D_POuch_op<=1;//0;//1;//31 =Ouch/OuP-1
//	poolingen_op<=0;   //1---->No Pooling
//#20 rst<=1;
//#81910 inputbstart_op<=1;
//	we<=0;
//#40 inputbstart_op<=0; 
//		
//	end
//	
//initial begin
//	clk<=0;
//	rst<=0;
//	we<=1;
//	we_Gt<=1;
//	fstL<=0;
//	firstlayer_op<=1;
//	inputbstart_op<=0;
//	numswitchH_op<=12;//30;//2 =(inS-2)/2-1; 
//	stride_op<=1;
//	kernelsize_op<=1;//1; 	
//	numslideH_op<=12;//62; //126 =(numswitchH_op+1)*(NInch_D_PInch_op+1) if NInch_D_PInch_op==0 +1
//	numslideV_op<=13;//30;//8 =(inS-2)/2-1
//	NInch_D_PInch_op<=0;//1;//31 =Inch/InP-1
//	NOuch_D_POuch_op<=0;//1;//31 =Ouch/OuP-1
//	poolingen_op<=0;   //1---->No Pooling
//	cellnum_op<=6; //63 : InS/4-1
//	linenum_op<=27; //63: InS-1
//	fixpoint_op<=3;  //input_tran fix/DSP [12:5]
//#20 rst<=1;
//#3910 inputbstart_op<=1;
//	we<=0;
//	we_Gt<=0;
//#20 inputbstart_op<=0; 
//#8480
//	fstL<=1;
//	we_Gt<=1;
//	we_Gt<=1;
//	firstlayer_op<=0;
//	numswitchH_op<=5;
//	numslideH_op<=5;
//	numslideV_op<=6;
//	NInch_D_PInch_op<=0;
//	NOuch_D_POuch_op<=0;	
//	fixpoint_op<=3; //fixpoint_op no fix/DSP [13:6]
//#1270 we_Gt<=0;
//	inputbstart_op<=1;
//#20	inputbstart_op<=0; 		
//	end

initial begin
	clk<=0;
	rst<=0;
	we<=1;
	we_Gt<=1;
	fstL<=0;
//	firstlayer_op<=1;
	padding_op<=1;
	inputbstart_op<=0;
	numswitchH_op<=12;//30;//2 =(inS-2)/2-1; readaddr_cnt
	stride_op<=1;
	kernelsize_op<=1;//3*3; 	
	numslideH_op<=12;//62; //126 =(numswitchH_op+1)*(NInch_D_PInch_op+1) if NInch_D_PInch_op==0 -1
	numslideV_op<=13;//30;//8 =(inS-2)/2
	NInch_D_PInch_op<=0;//1;//31 =Inch/InP-1
	NOuch_D_POuch_op<=1;//1;//31 =Ouch/OuP-1
	poolingen_op<=0;   //1---->No Pooling
	cellnum_op<=6;  //63 : InS/4-1
	linenum_op<=27; //63: InS-1
	fixpoint_op<=0;  //input_tran fix/DSP [12:5]
	relu_op<=1;
#20 rst<=1;
#3910 inputbstart_op<=1;
	we<=0;
	we_Gt<=0;
#20 inputbstart_op<=0; 
#12050
	fstL<=1;
	we_Gt<=1;
//	firstlayer_op<=0;
	padding_op<=0;
	numswitchH_op<=5;
	numslideH_op<=12;
	numslideV_op<=6;
	NInch_D_PInch_op<=1;
	NOuch_D_POuch_op<=3;	
	fixpoint_op<=0; //fixpoint_op no fix/DSP [13:6]
#640 we_Gt<=0;
	inputbstart_op<=1;
#20	inputbstart_op<=0;
#9000
    fstL<=2;
	we_Gt<=1;
	padding_op<=0;
	poolingen_op<=1; 
    numswitchH_op<=1;
	numslideH_op<=10;  // 要考虑JUMP
    numslideV_op<=2;
	NInch_D_PInch_op<=3;
	NOuch_D_POuch_op<=9;
	fixpoint_op<=1; 
	relu_op<=0;
#3200
    we_Gt<=0;	
	inputbstart_op<=1;
#20	inputbstart_op<=0;	
	end
	
reg [511:0]ram_mem[4095:0];
initial
begin
$readmemb("C:/Andrew/Software/matlab2017b/mtestfile/Hverify/imagedata.txt",ram_mem);
end
reg [511:0]ram_filter[4095:0];
initial
begin
$readmemb("C:/Andrew/Software/matlab2017b/mtestfile/Hverify/filterdata.txt",ram_filter);
end
reg [511:0]ram_filter2[4095:0];
initial
begin
$readmemb("C:/Andrew/Software/matlab2017b/mtestfile/Hverify/filterdata2.txt",ram_filter2);
end
reg [511:0]ram_filter3[4095:0];
initial
begin
$readmemb("C:/Andrew/Software/matlab2017b/mtestfile/Hverify/filterfull.txt",ram_filter3);
end

always@(posedge clk)
	if((~rst)||((a==195)&&(fstL==0))||((a==31)&&(fstL==1))||((a==159)&&(fstL==2)))
		begin a<=0; d<=0; end
	else if((we)||(we_Gt))
		begin a<=a+1; d<=d+1; end
//a没用到，因为//修改a[11:0]->cell_cnt
//wire [511:0] d_512;
//assign d_512={d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d};
wire [255:0] d_ram;
wire [511:0] d_Gt, d_Gt1, d_Gt2, d_Gt3;
wire [15:0] a_Gt, a_Gt1, a_Gt2;
assign d_ram=ram_mem[a];
assign d_Gt1=ram_filter[a];
assign d_Gt2=ram_filter2[a];
assign d_Gt3=ram_filter3[a];

assign d_Gt=(fstL==0)?d_Gt1:(fstL==1)?d_Gt2:d_Gt3;
assign a_Gt1={4'b0,a};
assign a_Gt=(we_Gt==1)?a_Gt1:a_Gt2;
/*-----------------------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------------------------*/
reg  [3:0] current_state_2d;

wire [3:0] current_state;
wire [3:0] current_state_d;
wire [3:0] current_state_4d;
wire [3:0] current_state_5d;

wire [511:0] inputb_spo;
wire [31:0]ex_we, ex_we_padding; 
wire [7:0] ex_addr;	
wire [127:0] ex_d1, ex_d2;

Input_Buffer Input_Buffer0(a, d_ram, we, clk, inputb_spo, rst, stride_op, kernelsize_op, numslideH_op ,numslideV_op,
BtInB_Save_Done, en_accord_inputbstart, ex_we, ex_addr, ex_d1, ex_d2, current_state, Channel_Switch_Done_6d, Layer_Finish, 
numswitchH_op, poolingen_op, cellnum_op, linenum_op, ex_we_padding);

wire [127 :0] output16_8bit1;
wire [127 :0] output16_8bit2;
wire [127 :0] output16_8bit3;
wire [127 :0] output16_8bit4;

Input_Trans Input_Trans1 (inputb_spo[127 :0	  ], clk, rst, output16_8bit1, fixpoint_op);
Input_Trans Input_Trans2 (inputb_spo[255 :128 ], clk, rst, output16_8bit2, fixpoint_op);
Input_Trans Input_Trans3 (inputb_spo[383 :256 ], clk, rst, output16_8bit3, fixpoint_op);
Input_Trans Input_Trans4 (inputb_spo[511 :384 ], clk, rst, output16_8bit4, fixpoint_op);

wire [511:0] BtInB_spo;
assign BtInB_spo={output16_8bit4,output16_8bit3,output16_8bit2,output16_8bit1};	
			  
wire [511:0] BtInB_RAMspo;
wire [3:0] a_Bt;
BtInB_Buffer BtInB_Buffer0(BtInB_spo,inputb_spo,a_Bt,clk,we_Bt,BtInB_RAMspo,kernelsize_op);

wire [2047:0] GFGt_RAMspo;

GFGt_Ram GFGt_Ram0(clk, we_Gt, a_Gt, d_Gt, GFGt_RAMspo);  //与图像一个输入数据端口d

wire [511:0]GFGt1,GFGt2,GFGt3,GFGt4;

assign GFGt1=GFGt_RAMspo[511:0];
assign GFGt2=GFGt_RAMspo[1023:512];
assign GFGt3=GFGt_RAMspo[1535:1024];
assign GFGt4=GFGt_RAMspo[2047:1536];

wire [703:0]UpV1,UpV2,UpV3,UpV4;

DSP16_16 DSP16_1 (clk, BtInB_RAMspo, GFGt1 , UpV1 ,fixpoint_op);
DSP16_16 DSP16_2 (clk, BtInB_RAMspo, GFGt2 , UpV2 ,fixpoint_op);
DSP16_16 DSP16_3 (clk, BtInB_RAMspo, GFGt3 , UpV3 ,fixpoint_op);
DSP16_16 DSP16_4 (clk, BtInB_RAMspo, GFGt4 , UpV4 ,fixpoint_op);

wire [175:0] UpV_Accumu1_16_1,UpV_Accumu1_16_2,UpV_Accumu1_16_3,UpV_Accumu1_16_4;

Channel_Accumu1_16 Channel_Accumu1_16_1 (clk, rst, UpV1 , UpV_Accumu1_16_1 );
Channel_Accumu1_16 Channel_Accumu1_16_2 (clk, rst, UpV2 , UpV_Accumu1_16_2 );
Channel_Accumu1_16 Channel_Accumu1_16_3 (clk, rst, UpV3 , UpV_Accumu1_16_3 );
Channel_Accumu1_16 Channel_Accumu1_16_4 (clk, rst, UpV4 , UpV_Accumu1_16_4 );

wire [175:0] UpV_Accumu1_N_1,UpV_Accumu1_N_2,UpV_Accumu1_N_3,UpV_Accumu1_N_4;

Channel_Accumulator Channel_Accumulator1 (clk, rst, current_state_5d, UpV_Accumu1_16_1 , UpV_Accumu1_N_1 ,NInch_D_PInch_op,UpV_Accumu1_N_en,current_state_4d);
Channel_Accumulator Channel_Accumulator2 (clk, rst, current_state_5d, UpV_Accumu1_16_2 , UpV_Accumu1_N_2 ,NInch_D_PInch_op,                ,current_state_4d);
Channel_Accumulator Channel_Accumulator3 (clk, rst, current_state_5d, UpV_Accumu1_16_3 , UpV_Accumu1_N_3 ,NInch_D_PInch_op,                ,current_state_4d);
Channel_Accumulator Channel_Accumulator4 (clk, rst, current_state_5d, UpV_Accumu1_16_4 , UpV_Accumu1_N_4 ,NInch_D_PInch_op,                ,current_state_4d);

wire [31:0] AtUVA_B1_1; wire [31:0] AtUVA_B2_1;
wire [31:0] AtUVA_B1_2; wire [31:0] AtUVA_B2_2;
wire [31:0] AtUVA_B1_3; wire [31:0] AtUVA_B2_3;
wire [31:0] AtUVA_B1_4; wire [31:0] AtUVA_B2_4;
 
Output_Trans Output_Trans1 (clk , UpV_Accumu1_N_1 , AtUVA_B1_1 , AtUVA_B2_1 , poolingen_op , UpV1 , kernelsize_op, relu_op);
Output_Trans Output_Trans2 (clk , UpV_Accumu1_N_2 , AtUVA_B1_2 , AtUVA_B2_2 , poolingen_op , UpV2 , kernelsize_op, relu_op);
Output_Trans Output_Trans3 (clk , UpV_Accumu1_N_3 , AtUVA_B1_3 , AtUVA_B2_3 , poolingen_op , UpV3 , kernelsize_op, relu_op);
Output_Trans Output_Trans4 (clk , UpV_Accumu1_N_4 , AtUVA_B1_4 , AtUVA_B2_4 , poolingen_op , UpV4 , kernelsize_op, relu_op);

assign ex_d1=
{AtUVA_B1_4, AtUVA_B1_3, AtUVA_B1_2, AtUVA_B1_1};
assign ex_d2=
{AtUVA_B2_4, AtUVA_B2_3, AtUVA_B2_2, AtUVA_B2_1};

Buffer_Exchanger Buffer_Exchanger0(clk, rst, current_state_5d, UpV_Accumu1_N_en, ex_we, ex_addr, numslideH_op,
numswitchH_op, NInch_D_PInch_op, NOuch_D_POuch_op, Layer_Finish, Channel_Switch_Done_6d, poolingen_op,inputbstart_op, 
en_accord_inputbstart, ex_we_padding, padding_op, kernelsize_op);

WRA_ctl WRA_ctl0(clk, rst, BtInB_Save_Done, Layer_Finish, Channel_Switch_Done_6d, inputbstart_op, numslideH_op, numswitchH_op, numslideV_op, 
 NInch_D_PInch_op, NOuch_D_POuch_op, en_accord_inputbstart, we_Bt, a_Bt, a_Gt2, current_state_5d, current_state, current_state_d, current_state_4d);		

/*------------------verification------------------------*/
integer m;
initial m=$fopen("C:/Users/DELL/Desktop/Temp/Hverify/inputbspo.txt");
always@(posedge clk)
	if((current_state==1)&&(fstL==0))
		$fstrobe(m,"%b",inputb_spo);//非阻塞赋值用strobe
		
always@(posedge clk)
	current_state_2d<=current_state_d;
integer n;
initial n=$fopen("C:/Users/DELL/Desktop/Temp/Hverify/inputtran.txt");
always@(posedge clk)
	if((current_state_2d==1)&&(fstL==0))
		$fdisplay(n,"%b",BtInB_spo);//阻塞赋值用display
integer k;
initial k=$fopen("C:/Users/DELL/Desktop/Temp/Hverify/UpV_Accumu.txt");
wire [511:0] UpV_Accumu;
assign UpV_Accumu={UpV_Accumu1_N_4, UpV_Accumu1_N_3, UpV_Accumu1_N_2, UpV_Accumu1_N_1};
always@(posedge clk)
	if((UpV_Accumu1_N_en==1)&&(fstL==0))
		$fdisplay(k,"%b",UpV_Accumu);//阻塞赋值用display	
//-----------------------------------------------Second Layer--------------------------------------------------//
wire [7:0] AtUVA_avgPool1,AtUVA_avgPool2,AtUVA_avgPool3,AtUVA_avgPool4;	

assign AtUVA_avgPool1=AtUVA_B1_1[7:0];	assign AtUVA_avgPool2=AtUVA_B1_2[7:0]; assign AtUVA_avgPool3=AtUVA_B1_3[7:0];	assign AtUVA_avgPool4=AtUVA_B1_4[7:0];		
	
wire [31:0] AtUVA_avgPool;
assign 	AtUVA_avgPool={AtUVA_avgPool4,AtUVA_avgPool3,AtUVA_avgPool2,AtUVA_avgPool1};
integer i1, i2;
initial i2=$fopen("C:/Users/DELL/Desktop/Temp/Hverify/AtUVA_avgPool.txt");
initial i1=$fopen("C:/Users/DELL/Desktop/Temp/Hverify/AtUpVt_ver.txt");
always@(posedge clk)
	if((UpV_Accumu1_N_en==1)&&(fstL==1))
		$fdisplay(i2,"%b",AtUVA_avgPool);//阻塞赋值用display	
always@(posedge clk)
	if((UpV_Accumu1_N_en==1)&&(fstL==0))
		$fdisplay(i1,"%b",AtUVA_avgPool);//阻塞赋值用display		
initial begin
# 25000 $fclose(m);
		$fclose(n);
		$fclose(k);
		$fclose(i2);
		$fclose(i1);
		end
/*------------------------------------------------------*/	
 
endmodule