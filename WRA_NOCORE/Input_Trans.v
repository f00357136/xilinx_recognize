`include "define.v"
module Input_Trans(input16_8bit, clk, rst, output16_8bit, fixpoint_op);
input [`InTrInDaWidth-1:0] input16_8bit;
input clk,rst;
input [1:0] fixpoint_op;
output wire [`InTrOutDaWidth-1:0] output16_8bit;
//output reg [`InTrOutDaWidth-1:0] output16_8bit;

wire signed [8:0] I11, I12, I13, I14; wire signed [9:0] Im11, Im12, Im13, Im14; wire signed [10:0] Io11, Io12, Io13, Io14;
wire signed [8:0] I21, I22, I23, I24; wire signed [9:0] Im21, Im22, Im23, Im24; wire signed [10:0] Io21, Io22, Io23, Io24;
wire signed [8:0] I31, I32, I33, I34; wire signed [9:0] Im31, Im32, Im33, Im34; wire signed [10:0] Io31, Io32, Io33, Io34;
wire signed [8:0] I41, I42, I43, I44; wire signed [9:0] Im41, Im42, Im43, Im44; wire signed [10:0] Io41, Io42, Io43, Io44;

assign I11={1'b0,input16_8bit[7:0]    }; 
assign I21={1'b0,input16_8bit[39:32]  };  
assign I31={1'b0,input16_8bit[71:64]  };  
assign I41={1'b0,input16_8bit[103:96] }; 
                                       
assign I12={1'b0,input16_8bit[15:8]  };  
assign I22={1'b0,input16_8bit[47:40]  }; 
assign I32={1'b0,input16_8bit[79:72]  }; 
assign I42={1'b0,input16_8bit[111:104]};
                                       
assign I13={1'b0,input16_8bit[23:16]  };  
assign I23={1'b0,input16_8bit[55:48]  };  
assign I33={1'b0,input16_8bit[87:80]  };  
assign I43={1'b0,input16_8bit[119:112]}; 
                                       
assign I14={1'b0,input16_8bit[31:24]  };
assign I24={1'b0,input16_8bit[63:56]  };
assign I34={1'b0,input16_8bit[95:88]  };
assign I44={1'b0,input16_8bit[127:120]};

assign Im11=I11-I31; assign Im12=I12-I32; assign Im13=I13-I33; assign Im14=I14-I34; 
assign Im21=I21+I31; assign Im22=I22+I32; assign Im23=I23+I33; assign Im24=I24+I34;
assign Im31=I31-I21; assign Im32=I32-I22; assign Im33=I33-I23; assign Im34=I34-I24;
assign Im41=I41-I21; assign Im42=I42-I22; assign Im43=I43-I23; assign Im44=I44-I24;

assign Io11=Im11-Im13; assign Io21=Im21-Im23; assign Io31=Im31-Im33; assign Io41=Im41-Im43; 
assign Io12=Im12+Im13; assign Io22=Im22+Im23; assign Io32=Im32+Im33; assign Io42=Im42+Im43;
assign Io13=Im13-Im12; assign Io23=Im23-Im22; assign Io33=Im33-Im32; assign Io43=Im43-Im42;
assign Io14=Im14-Im12; assign Io24=Im24-Im22; assign Io34=Im34-Im32; assign Io44=Im44-Im42;

//always@(posedge clk)
//	if(~rst)
//		output16_8bit<=0;
//	else if (fixpoint_op==0) begin
//		output16_8bit[7:0]   <=Io11[10:3]; output16_8bit[15:8]   <=Io12[10:3]; output16_8bit[23:16]  <=Io13[10:3]; output16_8bit[31:24]  <=Io14[10:3];
//		output16_8bit[39:32] <=Io21[10:3]; output16_8bit[47:40]  <=Io22[10:3]; output16_8bit[55:48]  <=Io23[10:3]; output16_8bit[63:56]  <=Io24[10:3];
//		output16_8bit[71:64] <=Io31[10:3]; output16_8bit[79:72]  <=Io32[10:3]; output16_8bit[87:80]  <=Io33[10:3]; output16_8bit[95:88]  <=Io34[10:3];
//		output16_8bit[103:96]<=Io41[10:3]; output16_8bit[111:104]<=Io42[10:3]; output16_8bit[119:112]<=Io43[10:3]; output16_8bit[127:120]<=Io44[10:3];
//		end	
//    else if (fixpoint_op==1) begin
//		output16_8bit[7:0]   <=Io11[7:0]; output16_8bit[15:8]   <=Io12[7:0]; output16_8bit[23:16]  <=Io13[7:0]; output16_8bit[31:24]  <=Io14[7:0];
//		output16_8bit[39:32] <=Io21[7:0]; output16_8bit[47:40]  <=Io22[7:0]; output16_8bit[55:48]  <=Io23[7:0]; output16_8bit[63:56]  <=Io24[7:0];
//		output16_8bit[71:64] <=Io31[7:0]; output16_8bit[79:72]  <=Io32[7:0]; output16_8bit[87:80]  <=Io33[7:0]; output16_8bit[95:88]  <=Io34[7:0];
//		output16_8bit[103:96]<=Io41[7:0]; output16_8bit[111:104]<=Io42[7:0]; output16_8bit[119:112]<=Io43[7:0]; output16_8bit[127:120]<=Io44[7:0];
//		end		

	
	assign output16_8bit[7:0] = ((Io11>=-128)&&(Io11<127))?{Io11[10],Io11[6:0]}:(Io11[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[15:8] = ((Io12>=-128)&&(Io12<127))?{Io12[10],Io12[6:0]}:(Io12[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[23:16] = ((Io13>=-128)&&(Io13<127))?{Io13[10],Io13[6:0]}:(Io13[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[31:24] = ((Io14>=-128)&&(Io14<127))?{Io14[10],Io14[6:0]}:(Io14[10]==0)?8'b0111_1111:8'b1000_0000;	
	assign output16_8bit[39:32] = ((Io21>=-128)&&(Io21<127))?{Io21[10],Io21[6:0]}:(Io21[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[47:40]  = ((Io22>=-128)&&(Io22<127))?{Io22[10],Io22[6:0]}:(Io22[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[55:48] = ((Io23>=-128)&&(Io23<127))?{Io23[10],Io23[6:0]}:(Io23[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[63:56] = ((Io24>=-128)&&(Io24<127))?{Io24[10],Io24[6:0]}:(Io24[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[71:64] = ((Io31>=-128)&&(Io31<127))?{Io31[10],Io31[6:0]}:(Io31[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[79:72] = ((Io32>=-128)&&(Io32<127))?{Io32[10],Io32[6:0]}:(Io32[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[87:80] = ((Io33>=-128)&&(Io33<127))?{Io33[10],Io33[6:0]}:(Io33[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[95:88] = ((Io34>=-128)&&(Io34<127))?{Io34[10],Io34[6:0]}:(Io34[10]==0)?8'b0111_1111:8'b1000_0000;	
	assign output16_8bit[103:96] = ((Io41>=-128)&&(Io41<127))?{Io41[10],Io41[6:0]}:(Io41[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[111:104] = ((Io42>=-128)&&(Io42<127))?{Io42[10],Io42[6:0]}:(Io42[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[119:112] = ((Io43>=-128)&&(Io43<127))?{Io43[10],Io43[6:0]}:(Io43[10]==0)?8'b0111_1111:8'b1000_0000;
	assign output16_8bit[127:120] = ((Io44>=-128)&&(Io44<127))?{Io44[10],Io44[6:0]}:(Io44[10]==0)?8'b0111_1111:8'b1000_0000;

endmodule

