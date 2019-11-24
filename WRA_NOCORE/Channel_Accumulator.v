`include "define.v"
`define channel_switch 2
module Channel_Accumulator(clk, rst, current_state_5d, UpV_Accumu1_16, UpV_Accumu1_N, NInch_D_PInch_op, UpV_Accumu1_N_en, current_state_4d);
input clk, rst;
input [3:0] current_state_5d, current_state_4d;
input [`ChAcOutWidthA-1:0] UpV_Accumu1_16;
input [4:0] NInch_D_PInch_op;

output wire [`ChAcNOutWidthA-1:0]UpV_Accumu1_N;
output UpV_Accumu1_N_en;
reg  UpV_Accumu1_N_en1; //for not 0 parallel //新添修正NOuch_D_POuch_op=0；
wire UpV_Accumu1_N_en2; //for     0 parallel //新添修正NOuch_D_POuch_op=0；
reg [4:0] NInch_D_PInch_ctn;
reg [3:0] current_state_6d;

always@(posedge clk)
	current_state_6d<=current_state_5d;

wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_1 ;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_1 ;
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_2 ;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_2 ;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_3 ;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_3 ;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_4 ;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_4 ;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_5 ;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_5 ;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_6 ;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_6 ;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_7 ;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_7 ;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_8 ;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_8 ;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_9 ;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_9 ;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_10;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_10;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_11;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_11;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_12;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_12;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_13;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_13;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_14;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_14;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_15;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_15;	
wire signed [`ChAcOutWidth-1:0] UpV_Accumu1_16_16;reg signed [`ChAcNOutWidth-1:0] UpV_Accumu1_N_16;

assign UpV_Accumu1_16_1 =UpV_Accumu1_16[10:0   ];
assign UpV_Accumu1_16_2 =UpV_Accumu1_16[21:11  ];
assign UpV_Accumu1_16_3 =UpV_Accumu1_16[32:22  ];
assign UpV_Accumu1_16_4 =UpV_Accumu1_16[43:33  ];
assign UpV_Accumu1_16_5 =UpV_Accumu1_16[54:44  ];
assign UpV_Accumu1_16_6 =UpV_Accumu1_16[65:55  ];
assign UpV_Accumu1_16_7 =UpV_Accumu1_16[76:66  ];
assign UpV_Accumu1_16_8 =UpV_Accumu1_16[87:77  ];
assign UpV_Accumu1_16_9 =UpV_Accumu1_16[98:88  ];
assign UpV_Accumu1_16_10=UpV_Accumu1_16[109:99 ];
assign UpV_Accumu1_16_11=UpV_Accumu1_16[120:110];
assign UpV_Accumu1_16_12=UpV_Accumu1_16[131:121];
assign UpV_Accumu1_16_13=UpV_Accumu1_16[142:132];
assign UpV_Accumu1_16_14=UpV_Accumu1_16[153:143];
assign UpV_Accumu1_16_15=UpV_Accumu1_16[164:154];
assign UpV_Accumu1_16_16=UpV_Accumu1_16[175:165];

assign UpV_Accumu1_N[10:0   ]=UpV_Accumu1_N_1 ;
assign UpV_Accumu1_N[21:11  ]=UpV_Accumu1_N_2 ;
assign UpV_Accumu1_N[32:22  ]=UpV_Accumu1_N_3 ;
assign UpV_Accumu1_N[43:33  ]=UpV_Accumu1_N_4 ;
assign UpV_Accumu1_N[54:44  ]=UpV_Accumu1_N_5 ;
assign UpV_Accumu1_N[65:55  ]=UpV_Accumu1_N_6 ;
assign UpV_Accumu1_N[76:66  ]=UpV_Accumu1_N_7 ;
assign UpV_Accumu1_N[87:77  ]=UpV_Accumu1_N_8 ;
assign UpV_Accumu1_N[98:88  ]=UpV_Accumu1_N_9 ;
assign UpV_Accumu1_N[109:99 ]=UpV_Accumu1_N_10;
assign UpV_Accumu1_N[120:110]=UpV_Accumu1_N_11;
assign UpV_Accumu1_N[131:121]=UpV_Accumu1_N_12;
assign UpV_Accumu1_N[142:132]=UpV_Accumu1_N_13;
assign UpV_Accumu1_N[153:143]=UpV_Accumu1_N_14;
assign UpV_Accumu1_N[164:154]=UpV_Accumu1_N_15;
assign UpV_Accumu1_N[175:165]=UpV_Accumu1_N_16;

always@(posedge clk)
	if(~rst) begin
	UpV_Accumu1_N_1 <=0;
	UpV_Accumu1_N_2 <=0;
	UpV_Accumu1_N_3 <=0;
	UpV_Accumu1_N_4 <=0;
	UpV_Accumu1_N_5 <=0;
	UpV_Accumu1_N_6 <=0;
	UpV_Accumu1_N_7 <=0;
	UpV_Accumu1_N_8 <=0;
	UpV_Accumu1_N_9 <=0;
	UpV_Accumu1_N_10<=0;
	UpV_Accumu1_N_11<=0;
	UpV_Accumu1_N_12<=0;
	UpV_Accumu1_N_13<=0;
	UpV_Accumu1_N_14<=0;
	UpV_Accumu1_N_15<=0;
	UpV_Accumu1_N_16<=0;
	end
	else if(NInch_D_PInch_ctn==0) begin
	UpV_Accumu1_N_1 <=UpV_Accumu1_16_1 ;
	UpV_Accumu1_N_2 <=UpV_Accumu1_16_2 ;
	UpV_Accumu1_N_3 <=UpV_Accumu1_16_3 ;
	UpV_Accumu1_N_4 <=UpV_Accumu1_16_4 ;
	UpV_Accumu1_N_5 <=UpV_Accumu1_16_5 ;
	UpV_Accumu1_N_6 <=UpV_Accumu1_16_6 ;
	UpV_Accumu1_N_7 <=UpV_Accumu1_16_7 ;
	UpV_Accumu1_N_8 <=UpV_Accumu1_16_8 ;
	UpV_Accumu1_N_9 <=UpV_Accumu1_16_9 ;
	UpV_Accumu1_N_10<=UpV_Accumu1_16_10;
	UpV_Accumu1_N_11<=UpV_Accumu1_16_11;
	UpV_Accumu1_N_12<=UpV_Accumu1_16_12;
	UpV_Accumu1_N_13<=UpV_Accumu1_16_13;
	UpV_Accumu1_N_14<=UpV_Accumu1_16_14;
	UpV_Accumu1_N_15<=UpV_Accumu1_16_15;
	UpV_Accumu1_N_16<=UpV_Accumu1_16_16;
	end
	else if(current_state_6d==`channel_switch)
	begin 
		UpV_Accumu1_N_1 <=UpV_Accumu1_N_1 +UpV_Accumu1_16_1 ;
        UpV_Accumu1_N_2 <=UpV_Accumu1_N_2 +UpV_Accumu1_16_2 ;
        UpV_Accumu1_N_3 <=UpV_Accumu1_N_3 +UpV_Accumu1_16_3 ;
        UpV_Accumu1_N_4 <=UpV_Accumu1_N_4 +UpV_Accumu1_16_4 ;
        UpV_Accumu1_N_5 <=UpV_Accumu1_N_5 +UpV_Accumu1_16_5 ;
        UpV_Accumu1_N_6 <=UpV_Accumu1_N_6 +UpV_Accumu1_16_6 ;
        UpV_Accumu1_N_7 <=UpV_Accumu1_N_7 +UpV_Accumu1_16_7 ;
        UpV_Accumu1_N_8 <=UpV_Accumu1_N_8 +UpV_Accumu1_16_8 ;
        UpV_Accumu1_N_9 <=UpV_Accumu1_N_9 +UpV_Accumu1_16_9 ;
        UpV_Accumu1_N_10<=UpV_Accumu1_N_10+UpV_Accumu1_16_10;
        UpV_Accumu1_N_11<=UpV_Accumu1_N_11+UpV_Accumu1_16_11;
        UpV_Accumu1_N_12<=UpV_Accumu1_N_12+UpV_Accumu1_16_12;
        UpV_Accumu1_N_13<=UpV_Accumu1_N_13+UpV_Accumu1_16_13;
        UpV_Accumu1_N_14<=UpV_Accumu1_N_14+UpV_Accumu1_16_14;
        UpV_Accumu1_N_15<=UpV_Accumu1_N_15+UpV_Accumu1_16_15;
        UpV_Accumu1_N_16<=UpV_Accumu1_N_16+UpV_Accumu1_16_16;
	end
	else  begin
	UpV_Accumu1_N_1 <=0;
	UpV_Accumu1_N_2 <=0;
	UpV_Accumu1_N_3 <=0;
	UpV_Accumu1_N_4 <=0;
	UpV_Accumu1_N_5 <=0;
	UpV_Accumu1_N_6 <=0;
	UpV_Accumu1_N_7 <=0;
	UpV_Accumu1_N_8 <=0;
	UpV_Accumu1_N_9 <=0;
	UpV_Accumu1_N_10<=0;
	UpV_Accumu1_N_11<=0;
	UpV_Accumu1_N_12<=0;
	UpV_Accumu1_N_13<=0;
	UpV_Accumu1_N_14<=0;
	UpV_Accumu1_N_15<=0;
	UpV_Accumu1_N_16<=0;
	end

assign UpV_Accumu1_N_en =(NInch_D_PInch_op==0)?UpV_Accumu1_N_en2:UpV_Accumu1_N_en1; //新添修正NOuch_D_POuch_op=0；	
	
//--------------------------NInch_D_PInch_op!=0 写使能/累加使能产生电路------------------------//
assign UpV_Accumu1_N_en2=((current_state_6d==`channel_switch)&&(current_state_5d==`channel_switch))?1'b1:1'b0;
//--------------------------NInch_D_PInch_op!=0 写使能/累加使能产生电路------------------------//		
always@(posedge clk)
	if((~rst)||(NInch_D_PInch_ctn==NInch_D_PInch_op))
		NInch_D_PInch_ctn<=0;
	else if((current_state_4d==`channel_switch)&&(current_state_5d==`channel_switch))
		NInch_D_PInch_ctn<=NInch_D_PInch_ctn+1'b1;
	else
		NInch_D_PInch_ctn<=0;		
always@(posedge clk)
	if(~rst)
		UpV_Accumu1_N_en1<=1'b0;
	else if((NInch_D_PInch_ctn==NInch_D_PInch_op)&&(current_state_5d==`channel_switch))
		UpV_Accumu1_N_en1<=1'b1;
	else 
		UpV_Accumu1_N_en1<=1'b0;
		
endmodule