`include "define.v"
module BtInB_Buffer(BtInB_spo,inputb_spo,a_Bt,clk,we_Bt,spo,kernelsize_op);
input [`BtBuDaWidth-1:0] BtInB_spo, inputb_spo;
input clk, we_Bt, kernelsize_op;
output[`BtBuDaWidth-1:0] spo;
input [3:0] a_Bt;

parameter BankDaDep=`BtBuDaWidth>>2;

wire [`BtBuDaWidth-1:0] d;
reg  wea0,wea1,wea2,wea3;
wire [3:0] addra0,addra1,addra2,addra3;
wire [BankDaDep-1:0] dina0 ,dina1 ,dina2 ,dina3 ;
wire [BankDaDep-1:0] douta0,douta1,douta2,douta3 ;

assign d=(kernelsize_op==1)?BtInB_spo:inputb_spo;

always@(*)
	if(we_Bt)
	begin wea0=we_Bt; wea1=we_Bt; wea2=we_Bt; wea3=we_Bt; end
	else
	begin wea0=0; wea1=0; wea2=0; wea3=0; end
	
assign addra0=a_Bt[3:0]; assign addra1=a_Bt[3:0]; assign addra2=a_Bt[3:0]; assign addra3=a_Bt[3:0];

assign dina0=d[127:0]; assign dina1=d[255:128]; assign dina2=d[383:256]; assign dina3=d[511:384]; 

`ifdef Xilinx_vivado
blk_mem  blk_mem0(clk,wea0,addra0,dina0,douta0);
blk_mem  blk_mem1(clk,wea1,addra1,dina1,douta1);
blk_mem  blk_mem2(clk,wea2,addra2,dina2,douta2);
blk_mem  blk_mem3(clk,wea3,addra3,dina3,douta3);
`else
blk_mem  blk_mem0(addra0,clk,dina0,wea0,douta0);
blk_mem  blk_mem1(addra1,clk,dina1,wea1,douta1);
blk_mem  blk_mem2(addra2,clk,dina2,wea2,douta2);
blk_mem  blk_mem3(addra3,clk,dina3,wea3,douta3);
`endif

assign spo={douta3, douta2, douta1, douta0};

endmodule