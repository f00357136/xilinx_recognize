`include "define.v"
`define idle           0
`define inputB_start   1
`define channel_switch 2
`define clear          3
`define layer_finish   4
module WRA_ctl(clk, rst, BtInB_Save_Done, Layer_Finish, Channel_Switch_Done_6d, inputbstart_op, numslideH_op, numswitchH_op, numslideV_op, 
NInch_D_PInch_op, NOuch_D_POuch_op, en_accord_inputbstart, we_Bt, a_Bt, a_Gt, current_state_5d, current_state, current_state_d, current_state_4d);
input clk, rst;
input BtInB_Save_Done;
input Layer_Finish;
input Channel_Switch_Done_6d;

input inputbstart_op;
input [8:0] numslideH_op; //max=510 大小为1024 多个输入通道组成 
input [4:0] numswitchH_op; //横向窗口滑动通道转换距离
input [4:0] numslideV_op; //max=31

input [4:0] NInch_D_PInch_op; //max=512/16=32
input [4:0] NOuch_D_POuch_op; //max=512/16=32

output reg en_accord_inputbstart;
output reg [3:0] current_state_5d;
output reg [3:0] current_state;
output reg [3:0] current_state_d;

reg [3:0] next_state;
reg [3:0] current_state_2d;
reg [3:0] current_state_3d;
output reg [3:0] current_state_4d;
wire Channel_Switch_Done;

reg [3:0]a_bt_switch;
reg [3:0]a_bt_start;
reg a_bt_start_en1,a_bt_start_en;

always@(posedge clk) 
	if(~rst)
	begin
	current_state_d <=0;
	current_state_2d<=0;
	current_state_3d<=0;
	current_state_4d<=0;
	current_state_5d<=0;
	end	
	else
	begin
	current_state_d<=current_state;
	current_state_2d<=current_state_d;
	current_state_3d<=current_state_2d;
	current_state_4d<=current_state_3d;
	current_state_5d<=current_state_4d;
	end

always@(posedge clk)
	if(~rst)
		current_state<=`idle;
	else
		current_state<=next_state;
		
/*BtInB_Save_Done来自于input_buffer, Channel_Switch_Done来自于*/		
always@(*)
	case(current_state)
	`idle            : if(inputbstart_op) next_state=`inputB_start; else next_state=`idle;
	`inputB_start    : if(BtInB_Save_Done) next_state=`channel_switch; else next_state=`inputB_start;
	`channel_switch  : if(Channel_Switch_Done) next_state=`clear; else next_state=`channel_switch;
	`clear		     : if(Layer_Finish) next_state=`layer_finish; else if(Channel_Switch_Done_6d) next_state=`inputB_start; else next_state=`clear;
	`layer_finish	 : next_state=`idle;
	default          : next_state=`idle;
	endcase	

output wire we_Bt;
output reg [15:0] a_Gt;
output reg [3 :0] a_Bt;
	
always@(*)
	case(current_state)
	`idle			: begin en_accord_inputbstart=0; end
	`inputB_start   : begin en_accord_inputbstart=1; end
	`channel_switch : begin en_accord_inputbstart=0; end
	`clear			: begin en_accord_inputbstart=0; end
    `layer_finish	: begin en_accord_inputbstart=0; end
    default         : begin en_accord_inputbstart=0; end
	endcase

assign 	we_Bt=a_bt_start_en;
//assign  we_Gt=(current_state_d==`channel_switch)?0:0;  // GFGt_Ram的使能信号需要与总线相关
//a_Bt在inputB_start状态下自增，在channel_switch状态下规律循环增长，在Channel_Switch_Done信号下置零准备写入下一“行”数据

always@(*)
	if(~rst)
		a_Bt=0;
	else if(a_bt_start_en)
		a_Bt=a_bt_start;
	else if(current_state_d==`channel_switch)
		a_Bt=a_bt_switch;
	else 
		a_Bt=0;
		
always@(posedge clk)
	if(~rst) 
		a_bt_start_en1<=0;
	else if(current_state==`inputB_start)
		a_bt_start_en1<=1;
	else 
		a_bt_start_en1<=0;
		
always@(posedge clk)
	a_bt_start_en<=a_bt_start_en1;
		
always@(posedge clk)
	if((~rst)||(a_bt_start==numslideH_op))
		a_bt_start<=0;
	else if(a_bt_start_en)
		a_bt_start<=a_bt_start+1'b1;
	else 
		a_bt_start<=0;
		
reg [6:0] NInch_D_PInch_cnt;	
reg [6:0] Nouch_D_Pouch_cnt;
reg [8:0] NslideH_cnt;
reg [4:0] NslideV_cnt;
/*----------------------------------------------------------------*/
/*----------------------------------------------------------------*/
always@(posedge clk)
	if((~rst)||(NInch_D_PInch_cnt==NInch_D_PInch_op)||(current_state==`clear)) 
		NInch_D_PInch_cnt<=0;
	else if(current_state_d==`channel_switch)
		NInch_D_PInch_cnt<=NInch_D_PInch_cnt+1'b1;

always@(posedge clk)
	if((~rst)||((Nouch_D_Pouch_cnt==NOuch_D_POuch_op)&&(NInch_D_PInch_cnt==NInch_D_PInch_op)))
		Nouch_D_Pouch_cnt<=0;
	else if((current_state_d==`channel_switch)&&(NInch_D_PInch_cnt==NInch_D_PInch_op))
		Nouch_D_Pouch_cnt<=Nouch_D_Pouch_cnt+1'b1;
		
always@(posedge clk)
	if((~rst)||((NslideH_cnt==numswitchH_op)&&(NInch_D_PInch_cnt==NInch_D_PInch_op)&&(Nouch_D_Pouch_cnt==NOuch_D_POuch_op)))
		NslideH_cnt<=0;
	else if((current_state_d==`channel_switch)&&(current_state==`channel_switch)&&(NInch_D_PInch_cnt==NInch_D_PInch_op)&&(Nouch_D_Pouch_cnt==NOuch_D_POuch_op))
		NslideH_cnt<=NslideH_cnt+1'b1;		
//修改&&(current_state==`channel_switch)

assign Channel_Switch_Done=((NslideH_cnt==numswitchH_op)&&(NInch_D_PInch_cnt==NInch_D_PInch_op)
&&(Nouch_D_Pouch_cnt==NOuch_D_POuch_op))?1:0;
/*----------------------------------------------------------------*/
/*----------------------------------------------------------------*/
always@(posedge clk)
	if(~rst)
		a_bt_switch<=0;
	else if(current_state==`channel_switch)
		a_bt_switch<=NInch_D_PInch_cnt*(numswitchH_op+1'b1)+NslideH_cnt;
	else 
		a_bt_switch<=0;
		
always@(posedge clk)
	if(~rst)
		a_Gt<=0;
	else if(current_state_d==`channel_switch)
		a_Gt<=NInch_D_PInch_cnt+Nouch_D_Pouch_cnt*(NInch_D_PInch_op+1'b1);
	else 
		a_Gt<=0;
endmodule