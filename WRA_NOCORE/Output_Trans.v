`include "define.v"
module Output_Trans(clk, UpV, AtUVA_B1, AtUVA_B2, poolingen_op, kernelsize_op, relu_op);
input [`ChAcNOutWidthA-1:0] UpV;   // max: 16*8=128
output [`OuTrDaWidth-1  :0] AtUVA_B1, AtUVA_B2; // max: 4*8=32
input clk, poolingen_op, kernelsize_op, relu_op;

wire signed [`ChAcNOutWidth-1:0] UpV11, UpV12, UpV13, UpV14; wire signed[`ChAcNOutWidth:0]  AtUpV11, AtUpV12, AtUpV13, AtUpV14;
wire signed [`ChAcNOutWidth-1:0] UpV21, UpV22, UpV23, UpV24; wire signed[`ChAcNOutWidth:0]  AtUpV21, AtUpV22, AtUpV23, AtUpV24;
wire signed [`ChAcNOutWidth-1:0] UpV31, UpV32, UpV33, UpV34; wire signed[`ChAcNOutWidth+1:0]  AtUpVt11, AtUpVt12; 
wire signed [`ChAcNOutWidth-1:0] UpV41, UpV42, UpV43, UpV44; wire signed[`ChAcNOutWidth+1:0]  AtUpVt21, AtUpVt22; 
wire signed [`ChAcNOutWidth+1:0] AtUpVt11_, AtUpVt12_;
wire signed [`ChAcNOutWidth+1:0] AtUpVt21_, AtUpVt22_;

wire signed [`ChAcNOutWidth-1:0] UpV_b11, UpV_b12, UpV_b13, UpV_b14;
wire signed [`ChAcNOutWidth-1:0] UpV_b21, UpV_b22, UpV_b23, UpV_b24;
wire signed [`ChAcNOutWidth-1:0] UpV_b31, UpV_b32, UpV_b33, UpV_b34;
wire signed [`ChAcNOutWidth-1:0] UpV_b41, UpV_b42, UpV_b43, UpV_b44;

	
assign UpV11=UpV[10:0   ]; assign UpV_b11=(UpV[10 ]==1)?0:UpV[10 :0  ];  //bypass’ ReLU
assign UpV12=UpV[21:11  ]; assign UpV_b12=(UpV[21 ]==1)?0:UpV[21 :11 ];  //bypass’ ReLU
assign UpV13=UpV[32:22  ]; assign UpV_b13=(UpV[32 ]==1)?0:UpV[32 :22 ];  //bypass’ ReLU
assign UpV14=UpV[43:33  ]; assign UpV_b14=(UpV[43 ]==1)?0:UpV[43 :33 ];  //bypass’ ReLU
assign UpV21=UpV[54:44  ]; assign UpV_b21=(UpV[54 ]==1)?0:UpV[54 :44 ];  //bypass’ ReLU
assign UpV22=UpV[65:55  ]; assign UpV_b22=(UpV[65 ]==1)?0:UpV[65 :55 ];  //bypass’ ReLU
assign UpV23=UpV[76:66  ]; assign UpV_b23=(UpV[76 ]==1)?0:UpV[76 :66 ];  //bypass’ ReLU
assign UpV24=UpV[87:77  ]; assign UpV_b24=(UpV[87 ]==1)?0:UpV[87 :77 ];  //bypass’ ReLU
assign UpV31=UpV[98:88  ]; assign UpV_b31=(UpV[98 ]==1)?0:UpV[98 :88 ];  //bypass’ ReLU
assign UpV32=UpV[109:99 ]; assign UpV_b32=(UpV[109]==1)?0:UpV[109:99 ];  //bypass’ ReLU
assign UpV33=UpV[120:110]; assign UpV_b33=(UpV[120]==1)?0:UpV[120:110];  //bypass’ ReLU
assign UpV34=UpV[131:121]; assign UpV_b34=(UpV[131]==1)?0:UpV[131:121];  //bypass’ ReLU
assign UpV41=UpV[142:132]; assign UpV_b41=(UpV[142]==1)?0:UpV[142:132];  //bypass’ ReLU
assign UpV42=UpV[153:143]; assign UpV_b42=(UpV[153]==1)?0:UpV[153:143];  //bypass’ ReLU
assign UpV43=UpV[164:154]; assign UpV_b43=(UpV[164]==1)?0:UpV[164:154];  //bypass’ ReLU
assign UpV44=UpV[175:165]; assign UpV_b44=(UpV[175]==1)?0:UpV[175:165];  //bypass’ ReLU

assign AtUpV11=UpV11+UpV21+UpV31; assign AtUpV12=UpV12+UpV22+UpV32; //  
assign AtUpV13=UpV13+UpV23+UpV33; assign AtUpV14=UpV14+UpV24+UpV34; // [ AtUpV11, AtUpV12, AtUpV13, AtUpV14 ]
assign AtUpV21=UpV21-UpV31+UpV41; assign AtUpV22=UpV22-UpV32+UpV42; // [ AtUpV21, AtUpV22, AtUpV23, AtUpV24 ]
assign AtUpV23=UpV23-UpV33+UpV43; assign AtUpV24=UpV24-UpV34+UpV44; // 

assign AtUpVt11= AtUpV11+AtUpV12+AtUpV13;
assign AtUpVt12= AtUpV12-AtUpV13+AtUpV14;
assign AtUpVt21= AtUpV21+AtUpV22+AtUpV23;
assign AtUpVt22= AtUpV22-AtUpV23+AtUpV24;
//------------------------激活函数--------------------------//
assign AtUpVt11_= (relu_op==0)?AtUpVt11[12:0]:(AtUpVt11[12]==1)?0:AtUpVt11[12:0]; 
assign AtUpVt12_= (relu_op==0)?AtUpVt12[12:0]:(AtUpVt12[12]==1)?0:AtUpVt12[12:0]; 
assign AtUpVt21_= (relu_op==0)?AtUpVt21[12:0]:(AtUpVt21[12]==1)?0:AtUpVt21[12:0]; 
assign AtUpVt22_= (relu_op==0)?AtUpVt22[12:0]:(AtUpVt22[12]==1)?0:AtUpVt22[12:0]; 
//----------------------------------------------------------//

wire [`ChAcNOutWidth+3:0] AtUVA_Pool;
wire [7:0] AtUVA_avgPool;
assign AtUVA_Pool=(AtUpVt11_+AtUpVt12_)+(AtUpVt21_+AtUpVt22_);
assign AtUVA_avgPool=AtUVA_Pool[10:3];//定点化操作

wire [`ChAcNOutWidth+1:0] avgP11,avgP12,avgP21,avgP22;
wire [`ChAcNOutWidth+1:0] avgP11_,avgP12_,avgP21_,avgP22_;
assign avgP11=(UpV_b11+UpV_b12)+(UpV_b21+UpV_b22);
assign avgP12=(UpV_b13+UpV_b14)+(UpV_b23+UpV_b24);
assign avgP21=(UpV_b31+UpV_b32)+(UpV_b41+UpV_b42);
assign avgP22=(UpV_b33+UpV_b34)+(UpV_b43+UpV_b44);
assign avgP11_=avgP11[10:3];
assign avgP12_=avgP12[10:3];
assign avgP21_=avgP21[10:3];
assign avgP22_=avgP22[10:3];

assign AtUVA_B1=(kernelsize_op==0)?{16'b0, avgP12_, avgP11_}:(poolingen_op==1)?{16'b0, AtUpVt12_[11:4], AtUpVt11_[11:4]}:{24'b0,AtUVA_avgPool};
assign AtUVA_B2=(kernelsize_op==0)?{16'b0, avgP22_, avgP21_}:(poolingen_op==1)?{16'b0, AtUpVt22_[11:4], AtUpVt21_[11:4]}:{24'b0,AtUVA_avgPool};

endmodule



