`include "define.v"
module GFGt_Ram(clk, we, a, d, spo);
input clk;
input we;
input [`AyFiFIFOWidth-1:0] d;
output [`GtBuDaWidth-1:0] spo;

input [`FiBufferSize-1:0] a;

wire we1 ;
wire we2 ;
wire we3 ;
wire we4 ;


wire [`AyFiFIFOWidth-1:0] spo1 ; 
wire [`AyFiFIFOWidth-1:0] spo2 ; 
wire [`AyFiFIFOWidth-1:0] spo3 ; 
wire [`AyFiFIFOWidth-1:0] spo4 ; 

 
assign we1  =((a[1:0])==0&&(we==1))?1'b1:1'b0;
assign we2  =((a[1:0])==1&&(we==1))?1'b1:1'b0;
assign we3  =((a[1:0])==2&&(we==1))?1'b1:1'b0;
assign we4  =((a[1:0])==3&&(we==1))?1'b1:1'b0;

wire [9:0] a_r;
assign a_r=(we==1)?a[11:2]:a[9:0];

`ifdef Xilinx_vivado
blk_mem_gfgt blk_mem_gfgt1 (clk, we1 , a_r, d, spo1 );
blk_mem_gfgt blk_mem_gfgt2 (clk, we2 , a_r, d, spo2 );
blk_mem_gfgt blk_mem_gfgt3 (clk, we3 , a_r, d, spo3 );
blk_mem_gfgt blk_mem_gfgt4 (clk, we4 , a_r, d, spo4 );
`else
blk_mem_gfgt blk_mem_gfgt1 (a_r,clk,d,we1,spo1 );
blk_mem_gfgt blk_mem_gfgt2 (a_r,clk,d,we2,spo2 );
blk_mem_gfgt blk_mem_gfgt3 (a_r,clk,d,we3,spo3 );
blk_mem_gfgt blk_mem_gfgt4 (a_r,clk,d,we4,spo4 );
`endif

assign spo={spo4 ,spo3 ,spo2 ,spo1};

endmodule
