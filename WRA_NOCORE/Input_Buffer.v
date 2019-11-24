`include "define.v"
`define channel_switch 2
`define inputB_start   1
`define clear          3
`define idle           0
module Input_Buffer(a, d, we, clk, inputb_spo, rst, stride_op, kernelsize_op, numslideH_op ,numslideV_op,
BtInB_Save_Done, en_accord_inputbstart, ex_we, ex_addr, ex_d1, ex_d2, current_state, Channel_Switch_Done_6d, Layer_Finish,
numswitchH_op, poolingen_op, cellnum_op, linenum_op, ex_we_padding, WRA_FeatureData);//readaddr_cnt=>verification
// --------------------------------------------------------------------------
// Parameter Declarations
// --------------------------------------------------------------------------
parameter InBuAddrWidth=8;
parameter InBuLineoutDW=4*`PEArraySize_DF*8; //128=4*1(element)*4(PEArraySize_DF)*8(DataWidth)
parameter ShareStackDep=`NumBuLine>>1-1;
parameter NonShStackDep=`NumBuLine>>2;

input clk, we, rst;	
input en_accord_inputbstart, Channel_Switch_Done_6d, poolingen_op;
input [7:0] cellnum_op, linenum_op;
input [`AyInFIFOWidth-1:0]d;
input [`InBuInDaWidthMax-1:0]ex_d1, ex_d2;
input [`NumBuLine-1:0]ex_we, ex_we_padding; 
input [3:0]current_state;
input [4:0] numswitchH_op; 
output[`InBuOutDaWidth-1:0]inputb_spo; //256*4
output[`InBuOutDaWidth-1:0]WRA_FeatureData;
input [InBuAddrWidth-1:0]ex_addr;
input [InBuAddrWidth-1:0]a; // write:0-255(8*32); read_max:0-15;

output BtInB_Save_Done;
output Layer_Finish;
input stride_op;
input kernelsize_op; //1->3*3 0->1*1
input [8:0] numslideH_op; //max=510 大小�?1024，多个输入�?�道组成 
input [4:0] numslideV_op; //max=31


wire we1 ; wire we17; 
wire we2 ; wire we18; 
wire we3 ; wire we19; 
wire we4 ; wire we20; 
wire we5 ; wire we21; 
wire we6 ; wire we22; 
wire we7 ; wire we23; 
wire we8 ; wire we24; 
wire we9 ; wire we25; 
wire we10; wire we26; 
wire we11; wire we27; 
wire we12; wire we28; 
wire we13; wire we29; 
wire we14; wire we30; 
wire we15; wire we31; 
wire we16; wire we32; 

//修改((a[11:6])==0 &&(we==1))?1:(current_state==`channel_switch)?ex_we[0 ]:0;//
reg [InBuAddrWidth-1:0] cell_cnt;
reg [`NumBuLineDW-1:0] line_cnt;
always@(posedge clk)
	if((~rst)||(cell_cnt==cellnum_op))
		cell_cnt<=0;
	else if(we)
		cell_cnt<=cell_cnt+1'b1;
		
always@(posedge clk)
	if((~rst)||((line_cnt==linenum_op)&&(cell_cnt==cellnum_op)))
		line_cnt<=0;
	else if(cell_cnt==cellnum_op)
		line_cnt<=line_cnt+1'b1;

/************************************************************************/

//第二个判断用于检测是否属于exchange状�??
assign we1  =((line_cnt==0 )&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[0 ]:(current_state==`inputB_start)?ex_we_padding[0 ]:1'b0;//修正增加padding功能
assign we2  =((line_cnt==1 )&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[1 ]:(current_state==`inputB_start)?ex_we_padding[1 ]:1'b0;
assign we3  =((line_cnt==2 )&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[2 ]:(current_state==`inputB_start)?ex_we_padding[2 ]:1'b0;
assign we4  =((line_cnt==3 )&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[3 ]:(current_state==`inputB_start)?ex_we_padding[3 ]:1'b0;
assign we5  =((line_cnt==4 )&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[4 ]:(current_state==`inputB_start)?ex_we_padding[4 ]:1'b0;
assign we6  =((line_cnt==5 )&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[5 ]:(current_state==`inputB_start)?ex_we_padding[5 ]:1'b0;
assign we7  =((line_cnt==6 )&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[6 ]:(current_state==`inputB_start)?ex_we_padding[6 ]:1'b0;
assign we8  =((line_cnt==7 )&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[7 ]:(current_state==`inputB_start)?ex_we_padding[7 ]:1'b0;
assign we9  =((line_cnt==8 )&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[8 ]:(current_state==`inputB_start)?ex_we_padding[8 ]:1'b0;
assign we10 =((line_cnt==9 )&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[9 ]:(current_state==`inputB_start)?ex_we_padding[9 ]:1'b0;
assign we11 =((line_cnt==10)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[10]:(current_state==`inputB_start)?ex_we_padding[10]:1'b0;
assign we12 =((line_cnt==11)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[11]:(current_state==`inputB_start)?ex_we_padding[11]:1'b0;
assign we13 =((line_cnt==12)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[12]:(current_state==`inputB_start)?ex_we_padding[12]:1'b0;
assign we14 =((line_cnt==13)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[13]:(current_state==`inputB_start)?ex_we_padding[13]:1'b0;
assign we15 =((line_cnt==14)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[14]:(current_state==`inputB_start)?ex_we_padding[14]:1'b0;
assign we16 =((line_cnt==15)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[15]:(current_state==`inputB_start)?ex_we_padding[15]:1'b0;
assign we17 =((line_cnt==16)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[16]:(current_state==`inputB_start)?ex_we_padding[16]:1'b0;
assign we18 =((line_cnt==17)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[17]:(current_state==`inputB_start)?ex_we_padding[17]:1'b0;
assign we19 =((line_cnt==18)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[18]:(current_state==`inputB_start)?ex_we_padding[18]:1'b0;
assign we20 =((line_cnt==19)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[19]:(current_state==`inputB_start)?ex_we_padding[19]:1'b0;
assign we21 =((line_cnt==20)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[20]:(current_state==`inputB_start)?ex_we_padding[20]:1'b0;
assign we22 =((line_cnt==21)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[21]:(current_state==`inputB_start)?ex_we_padding[21]:1'b0;
assign we23 =((line_cnt==22)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[22]:(current_state==`inputB_start)?ex_we_padding[22]:1'b0;
assign we24 =((line_cnt==23)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[23]:(current_state==`inputB_start)?ex_we_padding[23]:1'b0;
assign we25 =((line_cnt==24)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[24]:(current_state==`inputB_start)?ex_we_padding[24]:1'b0;
//20190926gai
assign we26 =((line_cnt==25)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[25]:(current_state==`inputB_start)?ex_we_padding[25]:1'b0;
assign we27 =((line_cnt==26)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[26]:(current_state==`inputB_start)?ex_we_padding[26]:1'b0;
assign we28 =((line_cnt==27)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[27]:(current_state==`inputB_start)?ex_we_padding[27]:1'b0;
//assign we29 =((line_cnt==28)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[28]:(current_state==`inputB_start)?ex_we_padding[28]:1'b0; // 32*32------>28*28 
//assign we30 =((line_cnt==29)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[29]:(current_state==`inputB_start)?ex_we_padding[29]:1'b0; // 32*32------>28*28 
//assign we31 =((line_cnt==30)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[30]:(current_state==`inputB_start)?ex_we_padding[30]:1'b0; // 32*32------>28*28 
//assign we32 =((line_cnt==31)&&(we==1))?1'b1:((current_state==`channel_switch)|(current_state==`clear))?ex_we[31]:(current_state==`inputB_start)?ex_we_padding[31]:1'b0; // 32*32------>28*28 


          
wire [InBuLineoutDW-1:0] spo1 ; wire [InBuLineoutDW-1:0] vspo1 ;
wire [InBuLineoutDW-1:0] spo2 ; wire [InBuLineoutDW-1:0] vspo2 ;
wire [InBuLineoutDW-1:0] spo3 ; wire [InBuLineoutDW-1:0] vspo3 ;
wire [InBuLineoutDW-1:0] spo4 ; wire [InBuLineoutDW-1:0] vspo4 ;
wire [InBuLineoutDW-1:0] spo5 ; wire [InBuLineoutDW-1:0] wspo1 ;
wire [InBuLineoutDW-1:0] spo6 ; wire [InBuLineoutDW-1:0] wspo2 ;
wire [InBuLineoutDW-1:0] spo7 ; wire [InBuLineoutDW-1:0] wspo3 ;
wire [InBuLineoutDW-1:0] spo8 ; wire [InBuLineoutDW-1:0] wspo4 ;
wire [InBuLineoutDW-1:0] spo9 ; 
wire [InBuLineoutDW-1:0] spo10; 
wire [InBuLineoutDW-1:0] spo11; 
wire [InBuLineoutDW-1:0] spo12; 
wire [InBuLineoutDW-1:0] spo13; 
wire [InBuLineoutDW-1:0] spo14; 
wire [InBuLineoutDW-1:0] spo15; 
wire [InBuLineoutDW-1:0] spo16; 
wire [InBuLineoutDW-1:0] spo17; 
wire [InBuLineoutDW-1:0] spo18; 
wire [InBuLineoutDW-1:0] spo19; 
wire [InBuLineoutDW-1:0] spo20; 
wire [InBuLineoutDW-1:0] spo21; 
wire [InBuLineoutDW-1:0] spo22; 
wire [InBuLineoutDW-1:0] spo23; 
wire [InBuLineoutDW-1:0] spo24; 
wire [InBuLineoutDW-1:0] spo25; 
wire [InBuLineoutDW-1:0] spo26; 
wire [InBuLineoutDW-1:0] spo27; 
wire [InBuLineoutDW-1:0] spo28; 
wire [InBuLineoutDW-1:0] spo29; 
wire [InBuLineoutDW-1:0] spo30; 
wire [InBuLineoutDW-1:0] spo31; 
wire [InBuLineoutDW-1:0] spo32; 

wire [`InBuOutDaWidth-1:0] stack [ShareStackDep-1:0]; //[14:0]
wire [`InBuOutDaWidth-1:0] stack1[NonShStackDep-1:0]; //[7 :0](kernelsize==1by1)

assign stack[0 ]={spo4  ,spo3  ,spo2  ,spo1  };
assign stack[1 ]={spo6  ,spo5  ,spo4  ,spo3  };
assign stack[2 ]={spo8  ,spo7  ,spo6  ,spo5  };
assign stack[3 ]={spo10 ,spo9  ,spo8  ,spo7  };
assign stack[4 ]={spo12 ,spo11 ,spo10 ,spo9  };
assign stack[5 ]={spo14 ,spo13 ,spo12 ,spo11 };
assign stack[6 ]={spo16 ,spo15 ,spo14 ,spo13 };
assign stack[7 ]={spo18 ,spo17 ,spo16 ,spo15 };
assign stack[8 ]={spo20 ,spo19 ,spo18 ,spo17 };
assign stack[9 ]={spo22 ,spo21 ,spo20 ,spo19 };
assign stack[10]={spo24 ,spo23 ,spo22 ,spo21 };
assign stack[11]={spo26 ,spo25 ,spo24 ,spo23 };
assign stack[12]={spo28 ,spo27 ,spo26 ,spo25 };
//assign stack[13]={spo30 ,spo29 ,spo28 ,spo27 }; // 32*32------>28*28
//assign stack[14]={spo32 ,spo31 ,spo30 ,spo29 }; // 32*32------>28*28

assign stack1[0 ]={spo4  ,spo3  ,spo2  ,spo1  };
assign stack1[1 ]={spo8  ,spo7  ,spo6  ,spo5  };
assign stack1[2 ]={spo12 ,spo11 ,spo10 ,spo9  };
assign stack1[3 ]={spo16 ,spo15 ,spo14 ,spo13 };
assign stack1[4 ]={spo20 ,spo19 ,spo18 ,spo17 };
assign stack1[5 ]={spo24 ,spo23 ,spo22 ,spo21 };
assign stack1[6 ]={spo28 ,spo27 ,spo26 ,spo25 };
//assign stack1[7 ]={spo32 ,spo31 ,spo30 ,spo29 }; // 32*32------>28*28                                                                                
/*---------------------------addr control signal--------------------------*/	
reg [4:0]jumpaddr_cnt;
always@(posedge clk)// 横向地址生成，暂未�?�虑输入通道间地�?跳变
	if((~rst)||(BtInB_Save_Done)||(jumpaddr_cnt==numswitchH_op))
		jumpaddr_cnt<=0;
	else if(en_accord_inputbstart)
		jumpaddr_cnt<=jumpaddr_cnt+1'b1;	
		
reg [3:0]readaddr_cnt;//自动读出数据地址生成
always@(posedge clk)// 横向地址生成，暂未�?�虑输入通道间地�?跳变
	if((~rst)||(BtInB_Save_Done))
		readaddr_cnt<=1'b0;
	else if((en_accord_inputbstart)&&(jumpaddr_cnt==numswitchH_op))
		readaddr_cnt<=readaddr_cnt+2'b10; //Jump
	else if(en_accord_inputbstart)
		readaddr_cnt<=readaddr_cnt+1'b1;
assign BtInB_Save_Done=(readaddr_cnt==numslideH_op)?1'b1:1'b0; 

reg [3:0]spoindex_cnt;	
always@(posedge clk)// 纵向地址生成
	if((~rst)||(Layer_Finish))
		spoindex_cnt<=1'b0;
	else if(BtInB_Save_Done) //等待第一层运算完成后计数
		spoindex_cnt<=spoindex_cnt+1'b1;  
		
assign Layer_Finish=((spoindex_cnt==numslideV_op)&&(Channel_Switch_Done_6d==1))?1'b1:1'b0;		
/*-----------------------------------------------------------------------*/
wire [`InBuOutDaWidth-1 :0] inputb_spo0;
wire [`InBuOutDaWidth-1 :0] inputb_spo1;
wire [`WRAOutDataWidth-1:0] WRA_spo;
assign inputb_spo0=stack [spoindex_cnt];
assign inputb_spo1=stack1[spoindex_cnt];
assign WRA_spo    =stack1[a[6:4]];  //FOR AHB READ:8*16 RAM BLOAK a[3:0] determines VOL NUMBER; a[6:4] determines COL LINENUMBER


assign vspo1 =(kernelsize_op==1)?{inputb_spo0[415:384],inputb_spo0[287:256],inputb_spo0[159:128],inputb_spo0[31:0]}:
{inputb_spo1[415:384],inputb_spo1[287:256],inputb_spo1[159:128],inputb_spo1[31:0]};

assign vspo2 =(kernelsize_op==1)?{inputb_spo0[447:416],inputb_spo0[319:288],inputb_spo0[191:160],inputb_spo0[63:32]}:
{inputb_spo1[447:416],inputb_spo1[319:288],inputb_spo1[191:160],inputb_spo1[63:32]};

assign vspo3 =(kernelsize_op==1)?{inputb_spo0[479:448],inputb_spo0[351:320],inputb_spo0[223:192],inputb_spo0[95:64]}:
{inputb_spo1[479:448],inputb_spo1[351:320],inputb_spo1[223:192],inputb_spo1[95:64]};

assign vspo4 =(kernelsize_op==1)?{inputb_spo0[511:480],inputb_spo0[383:352],inputb_spo0[255:224],inputb_spo0[127:96]}:
{inputb_spo1[511:480],inputb_spo1[383:352],inputb_spo1[255:224],inputb_spo1[127:96]};

assign wspo1 ={WRA_spo[415:384],WRA_spo[287:256],WRA_spo[159:128],WRA_spo[31:0]};
assign wspo2 ={WRA_spo[447:416],WRA_spo[319:288],WRA_spo[191:160],WRA_spo[63:32]};
assign wspo3 ={WRA_spo[479:448],WRA_spo[351:320],WRA_spo[223:192],WRA_spo[95:64]};
assign wspo4 ={WRA_spo[511:480],WRA_spo[383:352],WRA_spo[255:224],WRA_spo[127:96]};

reg [`InBuOutDaWidth-1:0] spo_kernelsize3;
reg [`InBuOutDaWidth-1:0] spo_kernelsize1;           								  //bypass系列信号

always@(posedge clk) begin		
	spo_kernelsize3<={vspo4 ,vspo3 ,vspo2 ,vspo1};
	spo_kernelsize1<=spo_kernelsize3;  								  //bypass系列信号
	end
	
assign inputb_spo=(kernelsize_op==1)?spo_kernelsize3:spo_kernelsize1; //bypass系列信号
assign WRA_FeatureData={wspo4 ,wspo3 ,wspo2 ,wspo1};                  //AHB READ: NO DELAY
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
wire [InBuAddrWidth-1  :0] addr_wr;	 
wire [`AyInFIFOWidth-1 :0] input_buffer_d1, input_buffer_d2; 
//第二个判断用于检测是否属于exchange状�??
//修改a[11:0]->cell_cnt
assign addr_wr=(we==1)?cell_cnt:((current_state==`channel_switch)||(current_state==`clear))?ex_addr:(current_state==`inputB_start)?readaddr_cnt:a;//
assign input_buffer_d1=((current_state==`channel_switch)||(current_state==`clear))?ex_d1:(current_state==`inputB_start)?0:d;//修正增加padding功能
assign input_buffer_d2=((current_state==`channel_switch)||(current_state==`clear))?ex_d2:(current_state==`inputB_start)?0:d;//修正增加padding功能
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/

//第四版删�?
//InputBuffer_wraddr InputBuffer_wraddr0(addr_wr,we,kernelsize_op,
//a1_ ,a2_ ,a3_ ,a4_ ,a5_ ,a6_ ,a7_ ,a8_,a9_ ,a10_,a11_,a12_,a13_,a14_,a15_,a16_);

                    
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit1  (poolingen_op, current_state, spo1  , addr_wr, input_buffer_d1, we1  , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit2  (poolingen_op, current_state, spo2  , addr_wr, input_buffer_d2, we2  , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit3  (poolingen_op, current_state, spo3  , addr_wr, input_buffer_d1, we3  , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit4  (poolingen_op, current_state, spo4  , addr_wr, input_buffer_d2, we4  , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit5  (poolingen_op, current_state, spo5  , addr_wr, input_buffer_d1, we5  , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit6  (poolingen_op, current_state, spo6  , addr_wr, input_buffer_d2, we6  , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit7  (poolingen_op, current_state, spo7  , addr_wr, input_buffer_d1, we7  , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit8  (poolingen_op, current_state, spo8  , addr_wr, input_buffer_d2, we8  , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit9  (poolingen_op, current_state, spo9  , addr_wr, input_buffer_d1, we9  , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit10 (poolingen_op, current_state, spo10 , addr_wr, input_buffer_d2, we10 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit11 (poolingen_op, current_state, spo11 , addr_wr, input_buffer_d1, we11 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit12 (poolingen_op, current_state, spo12 , addr_wr, input_buffer_d2, we12 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit13 (poolingen_op, current_state, spo13 , addr_wr, input_buffer_d1, we13 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit14 (poolingen_op, current_state, spo14 , addr_wr, input_buffer_d2, we14 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit15 (poolingen_op, current_state, spo15 , addr_wr, input_buffer_d1, we15 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit16 (poolingen_op, current_state, spo16 , addr_wr, input_buffer_d2, we16 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit17 (poolingen_op, current_state, spo17 , addr_wr, input_buffer_d1, we17 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit18 (poolingen_op, current_state, spo18 , addr_wr, input_buffer_d2, we18 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit19 (poolingen_op, current_state, spo19 , addr_wr, input_buffer_d1, we19 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit20 (poolingen_op, current_state, spo20 , addr_wr, input_buffer_d2, we20 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit21 (poolingen_op, current_state, spo21 , addr_wr, input_buffer_d1, we21 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit22 (poolingen_op, current_state, spo22 , addr_wr, input_buffer_d2, we22 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit23 (poolingen_op, current_state, spo23 , addr_wr, input_buffer_d1, we23 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit24 (poolingen_op, current_state, spo24 , addr_wr, input_buffer_d2, we24 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit25 (poolingen_op, current_state, spo25 , addr_wr, input_buffer_d1, we25 , clk, stride_op, kernelsize_op);
//20190926gai
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit26 (poolingen_op, current_state, spo26 , addr_wr, input_buffer_d2, we26 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit27 (poolingen_op, current_state, spo27 , addr_wr, input_buffer_d1, we27 , clk, stride_op, kernelsize_op);
(* DONT_TOUCH= "TRUE" *)Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit28 (poolingen_op, current_state, spo28 , addr_wr, input_buffer_d2, we28 , clk, stride_op, kernelsize_op);
//Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit29 (poolingen_op, current_state, spo29 , addr_wr, input_buffer_d1, we29 , clk, stride_op, kernelsize_op);
//Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit30 (poolingen_op, current_state, spo30 , addr_wr, input_buffer_d2, we30 , clk, stride_op, kernelsize_op);
//Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit31 (poolingen_op, current_state, spo31 , addr_wr, input_buffer_d1, we31 , clk, stride_op, kernelsize_op);
//Buffer_Grain_16_32_32bit Buffer_Grain_16_32_32bit32 (poolingen_op, current_state, spo32 , addr_wr, input_buffer_d2, we32 , clk, stride_op, kernelsize_op);


/************************************************************************/
/************************************************************************/

/************************************************************************/



endmodule




































































































































