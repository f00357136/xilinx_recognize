 `include "define.v"
 `timescale 1ns/100ps
 
module WRA_NOCORE_T_NEW;
reg clk, rst_n;
always #10 clk=~clk;


reg  [15 :0] DMARead_cnt;
reg  DMARead_cnt_en;
reg  DMARead_OP;
wire [127:0] DataFIFOIn;
wire CamEmpty;
wire [19:0] IdentifiedNum;

initial begin
clk<=0;
rst_n<=1;
DMARead_OP<=0;
#20
rst_n<=0;
#20
rst_n<=1;
DMARead_OP<=1;
#20
DMARead_OP<=0;

end



parameter FIFOdepth=255;

always@(posedge clk)
	if((~rst_n)||(DMARead_cnt==FIFOdepth))
		DMARead_cnt_en<=0;
	else if(DMARead_OP)
		DMARead_cnt_en<=1;		
always@(posedge clk)
	if((~rst_n)||(DMARead_cnt==FIFOdepth))
		DMARead_cnt<=0;
	else if(DMARead_cnt_en)
		DMARead_cnt<=DMARead_cnt+1;
		
dist_mem_gen_3 dist_mem_gen_0(
  .a(DMARead_cnt[7:0]),      // input wire [7 : 0] a
  .d(),      				 // input wire [127 : 0] d
  .clk(clk),  				 // input wire clk
  .we(1'b0),   				 // input wire we
  .spo(DataFIFOIn)    		 // output wire [127 : 0] spo
);

WRA_NOCORE WRA_NOCORE0(
  .clk(clk),
  .rst_n(rst_n),
  .CamDataIn(DataFIFOIn),
  .CamWr_en(DMARead_cnt_en),
  .CamEmpty(CamEmpty),
  .IdentifiedNum(IdentifiedNum)
);

endmodule