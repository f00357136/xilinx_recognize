`define idle           0
`define channel_switch 2
`define inputB_start   1
`include "define.v"
module Ram_Grain_32_32bit(clk, we, a, d, spo, stride_op, kernelsize_op, current_state, poolingen_op);
input [3:0]current_state;
input clk, we, poolingen_op;
input [InBuAddrWidth-1:0] a; //write: 0-63; read: 0-126@kernelsize_op=3, 0-63@kernelsize_op=1 
input [31:0] d;	
output[31:0] spo;
input stride_op;
input kernelsize_op;

parameter InBuAddrWidth=8;	
parameter ram_depth=2**`ram_addr_width;
	
reg [7:0] ram1 [ram_depth-1:0];
reg [7:0] ram2 [ram_depth-1:0];
reg [7:0] ram3 [ram_depth-1:0];
reg [7:0] ram4 [ram_depth-1:0];

//always@(posedge clk) //write
//	begin 
//		if((we)&&(current_state==`idle))
//			begin 
//			 ram1[a[5:0]] <= d[7:0];
//			 ram2[a[5:0]] <= d[15:8];
//			 ram3[a[5:0]] <= d[23:16];
//			 ram4[a[5:0]] <= d[31:24];
//			end
//		else if((we)&&(a[0]==0))
//			begin
//			 ram1[a[6:1]] <= d[7:0];
//			 ram2[a[6:1]] <= d[15:8];
//			end
//		else if((we)&&(a[0]==1))
//			begin
//			 ram3[a[6:1]] <= d[7:0];
//			 ram4[a[6:1]] <= d[15:8];
//			end
//	end
always@(posedge clk) //write	
	begin 
		if((we)&&(current_state==`idle))
			begin 
			 ram1[a[`ram_addr_width-1:0]] <= d[7:0];
			 ram2[a[`ram_addr_width-1:0]] <= d[15:8];
			 ram3[a[`ram_addr_width-1:0]] <= d[23:16];
			 ram4[a[`ram_addr_width-1:0]] <= d[31:24];
			end	
		else if((we)&&(a[0]==0)&&((poolingen_op==1)||(current_state==`inputB_start)))
			begin
			 ram1[a[`ram_addr_width:1]] <= d[7:0];
			 ram2[a[`ram_addr_width:1]] <= d[15:8];
			end
		else if((we)&&(a[0]==1)&&((poolingen_op==1)||(current_state==`inputB_start)))
			begin
			 ram3[a[`ram_addr_width:1]] <= d[7:0];
			 ram4[a[`ram_addr_width:1]] <= d[15:8];
			end
		else if((we)&&(a[1:0]==0)&&(poolingen_op==0))     //其他版本也许修改位宽
			 ram1[a[`ram_addr_width+1:2]] <= d[7:0];                      //其他版本也许修改位宽
		else if((we)&&(a[1:0]==1)&&(poolingen_op==0))     //其他版本也许修改位宽
			 ram2[a[`ram_addr_width+1:2]] <= d[7:0];                      //其他版本也许修改位宽
		else if((we)&&(a[1:0]==2)&&(poolingen_op==0))     //其他版本也许修改位宽
			 ram3[a[`ram_addr_width+1:2]] <= d[7:0];                      //其他版本也许修改位宽
		else if((we)&&(a[1:0]==3)&&(poolingen_op==0))     //其他版本也许修改位宽
			 ram4[a[`ram_addr_width+1:2]] <= d[7:0];                      //其他版本也许修改位宽
	end

/*
always@(posedge clk) //write
	begin 
		if(we)
			begin
			 ram1[a[5:0]] <= d[7:0];
			 ram2[a[5:0]] <= d[15:8];
			 ram3[a[5:0]] <= d[23:16];
			 ram4[a[5:0]] <= d[31:24];
			end
	end
*/
reg [`ram_addr_width-1:0] read_addr1_k3,read_addr2_k3,read_addr3_k3,read_addr4_k3;
reg [`ram_addr_width-1:0] read_addr1_k1,read_addr2_k1,read_addr3_k1,read_addr4_k1;
 
always@(*)  //0<=a<=126 @kernelsize_op=3&&stride_op=1
	if(a[0]==0) 
		begin	
			read_addr2_k3={a[`ram_addr_width:1]};
			read_addr1_k3={a[`ram_addr_width:1]};
		end
	else
		begin	
			read_addr2_k3={a[`ram_addr_width:1]}+1;
			read_addr1_k3={a[`ram_addr_width:1]}+1;
		end
		
always@(*)
	    begin
	    	read_addr4_k3={a[`ram_addr_width:1]};
	    	read_addr3_k3={a[`ram_addr_width:1]};
	    end

always@(*) //0<=a<=63 @kernelsize_op=1&&stride_op=1/2
	    begin 
	    	read_addr1_k1={a[`ram_addr_width-1:0]};
	    	read_addr2_k1={a[`ram_addr_width-1:0]};
	    	read_addr3_k1={a[`ram_addr_width-1:0]};
	    	read_addr4_k1={a[`ram_addr_width-1:0]};			
	    end

wire [31:0] spo1, spo2;
assign spo1={ram4[read_addr4_k3],ram3[read_addr3_k3],ram2[read_addr2_k3],ram1[read_addr1_k3]};
assign spo2={ram2[read_addr2_k3],ram1[read_addr1_k3],ram4[read_addr4_k3],ram3[read_addr3_k3]};
assign spo=(kernelsize_op==0)?{ram4[read_addr4_k1],
			       ram3[read_addr3_k1],
			       ram2[read_addr2_k1],
			       ram1[read_addr1_k1]}:(!a[0])?spo1:spo2;
endmodule 																					
