`include "define.v"
`define channel_switch 2
`define clear          3
module Buffer_Exchanger(clk, rst, current_state_5d, UpV_Accumu1_N_en, ex_we, ex_addr, numslideH_op,
numswitchH_op, NInch_D_PInch_op, NOuch_D_POuch_op, Layer_Finish, Channel_Switch_Done_6d, poolingen_op, inputbstart_op,
en_accord_inputbstart, ex_we_padding, padding_op, kernelsize_op);

input clk, rst, inputbstart_op, en_accord_inputbstart, padding_op;
input Layer_Finish,poolingen_op;
input [3:0] current_state_5d;
input UpV_Accumu1_N_en;	
output[`NumBuLine-1:0]ex_we; 
output reg [`NumBuLine-1:0] ex_we_padding;
output [InBuAddrWidth-1:0] ex_addr;
output Channel_Switch_Done_6d;

input [8:0] numslideH_op; //max=510 大小�?1024 多个输入通道组成 
input [4:0] numswitchH_op; //横向窗口滑动通道转换距离
input [4:0] NInch_D_PInch_op; //max=512/16=32
input [4:0] NOuch_D_POuch_op; //max=512/16=32
input kernelsize_op;

parameter InBuAddrWidth=8;

reg [`NumBuLine-1:0] ex_we_c;
wire [InBuAddrWidth-1:0] ex_addr1;//新添修正NOuch_D_POuch_op=0；
wire [InBuAddrWidth-1:0] ex_addr2;//新添修正NOuch_D_POuch_op=0；
reg  Channel_Switch_Done_6d_;//新添修正NOuch_D_POuch_op=0；
reg [6:0] NInch_D_PInch_cnt_5d;	
reg [6:0] Nouch_D_Pouch_cnt_5d;
reg [8:0] NslideH_cnt_5d;	

wire Channel_Switch_Done_5d;
 
always@(posedge clk)
	if((~rst)||(Layer_Finish)||(inputbstart_op))
		ex_we_c<={30'b0,poolingen_op,1'b1};//低两位为1
	else if((Channel_Switch_Done_6d)&&((poolingen_op==1)||(kernelsize_op==0)))
		ex_we_c<={ex_we_c[29:0],2'b0};   //行存储使能切花，�?�?2个步�?
	else if((Channel_Switch_Done_6d)&&(poolingen_op==0))
		ex_we_c<={ex_we_c[30:0],1'b0};   //行存储使能切花，丿欿2个步长

always@(posedge clk)
	if((~rst)||(Layer_Finish)||(inputbstart_op))
		ex_we_padding<={30'b0,1'b1,1'b1};//低两位为1
	else if(Channel_Switch_Done_6d)
		ex_we_padding<={ex_we_padding[29:0],2'b0};	
		
genvar i;
generate
       for(i=0;i<32;i=i+1)
       begin:	generate_ex_we
              assign ex_we[i]=ex_we_c[i]&(UpV_Accumu1_N_en|en_accord_inputbstart);
       end
endgenerate	

reg  [3:0] current_state_6d;
wire [3:0] current_state_6d_,current_state_5d_;
reg  [3:0] current_state_7d;//修正NInch_D_PInch_op!=0的情况
always@(posedge clk)
	if(~rst)
	begin
		current_state_6d<=0;
		current_state_7d<=0;
		Channel_Switch_Done_6d_<=0;
	end
	else	
	begin
		current_state_6d<=current_state_5d;
		current_state_7d<=current_state_6d;
		Channel_Switch_Done_6d_<=Channel_Switch_Done_5d;
	end
assign Channel_Switch_Done_6d=(NOuch_D_POuch_op==0)?Channel_Switch_Done_5d:Channel_Switch_Done_6d_;//新添修正NOuch_D_POuch_op=0；
assign Channel_Switch_Done_5d=((NslideH_cnt_5d==numswitchH_op)&&(NInch_D_PInch_cnt_5d==NInch_D_PInch_op)
&&(Nouch_D_Pouch_cnt_5d==NOuch_D_POuch_op))?1'b1:1'b0;

//--------------------------NInch_D_PInch_op!=0/NInch_D_PInch_op!=0 写使能/累加使能产生电路------------------------//
assign ex_addr=(NOuch_D_POuch_op==0)?ex_addr2:ex_addr1;//新添修正NOuch_D_POuch_op=0；
assign ex_addr1=((NInch_D_PInch_cnt_5d==0)&&(Nouch_D_Pouch_cnt_5d==0))?NslideH_cnt_5d:(UpV_Accumu1_N_en)?
NslideH_cnt_5d+(numswitchH_op+padding_op+1'b1)*Nouch_D_Pouch_cnt_5d:0; //路径延迟需要优化，修正NInch_D_PInch_op!=0的情况，多通道平分时padding
assign ex_addr2=NslideH_cnt_5d;

assign current_state_6d_=(NInch_D_PInch_op==0)?current_state_6d:current_state_7d;//修正NInch_D_PInch_op!=0的情况，多通道平分时padding,刚开始要累加，所以地址计算周期要推移
assign current_state_5d_=(NInch_D_PInch_op==0)?current_state_5d:current_state_6d;//修正NInch_D_PInch_op!=0的情况，多通道平分时padding

always@(posedge clk)
	if((~rst)||(NInch_D_PInch_cnt_5d==NInch_D_PInch_op)||(current_state_5d_==`clear)) //next_state补充�?个使得NInch_D_PInch_cnt_5d�?始计数的状�??
		NInch_D_PInch_cnt_5d<=0;
	else if(current_state_6d_==`channel_switch)
		NInch_D_PInch_cnt_5d<=NInch_D_PInch_cnt_5d+1'b1;

always@(posedge clk)
	if((~rst)||((Nouch_D_Pouch_cnt_5d==NOuch_D_POuch_op)&&(NInch_D_PInch_cnt_5d==NInch_D_PInch_op)))
		Nouch_D_Pouch_cnt_5d<=0;
	else if((current_state_6d_==`channel_switch)&&(NInch_D_PInch_cnt_5d==NInch_D_PInch_op))
		Nouch_D_Pouch_cnt_5d<=Nouch_D_Pouch_cnt_5d+1'b1;
		
always@(posedge clk)
	if((~rst)||((NslideH_cnt_5d==numswitchH_op)&&(NInch_D_PInch_cnt_5d==NInch_D_PInch_op)&&(Nouch_D_Pouch_cnt_5d==NOuch_D_POuch_op)))
		NslideH_cnt_5d<=0;
	else if((current_state_6d_==`channel_switch)&&(current_state_5d==`channel_switch)&&(NInch_D_PInch_cnt_5d==NInch_D_PInch_op)&&(Nouch_D_Pouch_cnt_5d==NOuch_D_POuch_op))
		NslideH_cnt_5d<=NslideH_cnt_5d+1'b1;	


endmodule