
 `include "define.v"
 `timescale 1ns/100ps
 
module WRA_NOCORE_T;



	reg [7:0] camera_data;
	reg  href;
	reg  pclk;
	reg  vsync;
	reg  rst;
	wire [7:0] gray1;
	wire [7:0] image_gray;

	wire frame3_flag;
	wire frame4_flag;
	
	
	wire  [31:0] gray_two_byte;
	wire CamWr_en;

//	wire  [31:0] gray_two_byte_test;
	wire [3:0] counter;
   wire  [13:0] address;
    wire [15:0] m_data;
	wire [10:0] gray_word1_index;
	wire byte_flag;
//wire byte_flag_neg;

initial
begin
 
  href=0;
  pclk=0;
 vsync=0;
  rst=0;

#20 rst=1;

href=1;
#50  vsync=1;
#50  vsync=0;
#50  vsync=1;
#50  vsync=0;
#50  vsync=1;
#50  vsync=0;


#286720  vsync=1;
#50 vsync=0;

#286720 vsync=1;
#50 vsync=0;
//$stop;

end


wire pclk_copy;
wire pclk_dev;
pll_pclk pll_pclk_inst(
    .clk_in1(pclk),   //79.5Mhz
    .resetn(rst), 
    .clk_out1(pclk_copy),   //79.5Mhz
    .clk_out2(pclk_dev)  //39.75Mhz
);	



always #1 pclk<=~pclk;

    reg [7:0] block_ram[143360:1];//1280*56*2=143360

  initial
  begin

  $readmemb("E:/vivado_workspace/20190930_test/WRA_NOCORE/561280_8bits.txt",block_ram,1,143360);
  //1280*56*2=
  end

//模拟摄像头给数据
//捕捉vsync的上升沿

//捕获vsync上升沿
reg [1:0] vsync_r;
always @(posedge pclk  or negedge rst)
	begin
		if(!rst)
			vsync_r<=2'b0;
		else 
			vsync_r<={vsync_r[0],vsync};
			
	end

 assign vsync_rise =(~ vsync_r[1]  &  vsync_r[0] )? 1'b1 :1'b0;
 
//帧计数器
reg [3:0] tb_frame_cnt;

//在pclk下降沿捕捉vsync_rise
always  @( negedge pclk) 
	begin
        if(!rst )
                tb_frame_cnt  <=4'd0;
        else if( vsync_rise==1'b1)
                tb_frame_cnt <= tb_frame_cnt + 1'b1;
	end

wire tb_frame3_flag;
assign tb_frame3_flag=(tb_frame_cnt==3) ? 1'b1 : 1'b0;

//reg tb_byte_flag ;


//第3帧时，通过wden=1控制写入，写入后rden=1,wden=0,只能读，不能写入
reg [17:0] tb_address;
always @(negedge pclk)
	begin
	
		if(!rst)
			tb_address<=0;
		else if(tb_frame3_flag== 1'b0)
			tb_address<=18'd1;
		else if( (tb_frame3_flag==1'b1) &&  (href==1'b1) && vsync==1'b0 && tb_address<=18'd143360)
//            else if( (tb_frame3_flag==1'b1) &&  (href==1'b1) && vsync==1'b0 && tb_address<=18'd784)
			begin
				tb_address<=tb_address+1'b1;
				
			end
	end
	
	
//	reg [7:0] block_ram_new[784:1];//1280*56*2=143360

//  initial
//  begin

//  $readmemb("C:/Users/avatar/Desktop/zhou_shibie/data/bin_784/word1.txt",block_ram_new,1,784);
//  //
//  end

	always @(posedge pclk)
		begin
			if(!rst)
				camera_data<=8'b0;
			else 
				camera_data<=block_ram[tb_address];
//                camera_data<=block_ram_new[tb_address];
		end






//输出第1个字
integer num1;
initial
begin

//num1=$fopen("D:/image_process_test/word1.txt","w");///right
//原始的
//num1=$fopen("C:/Users/avatar/Desktop/zhou_shibie/new/WRA_NOCORE/word1.txt","w");

//已修改的
num1=$fopen("E:/vivado_workspace/20190930_test/WRA_NOCORE/word_dec28.txt","w");

end

//	wire  [9:0] gray_word1_index;
	
always @(posedge pclk)
	begin
	
		if( gray_word1_index>=10'd1 )
			begin

				$fwrite(num1,"%d\n",gray1);
				if(gray_word1_index==10'd784)
				begin
                 
					$fclose(num1);
				end
			end
	end

//输出整个图像的灰度

integer num2;
initial
begin


num2=$fopen("E:/vivado_workspace/20190930_test/WRA_NOCORE/whole_image.txt","w");

end


	
always @(posedge pclk_dev)
	begin
	
		if( frame3_flag==1 )
			begin

				$fwrite(num2,"%d\n",image_gray);
				if(frame4_flag==1)
				begin
                 
					$fclose(num2);
				end
			end
	end

wire gray_word1;
image_process_new inst_image(
		.camera_data(camera_data),
		.href(href),
		.vsync(vsync),
		
		.pclk(pclk),
	//	.pclk_dev(pclk_dev),
		
		.rst(rst),
//		.q(q)
		.gray1(   gray1   ),
		.gray_word1(gray_word1),
		.image_gray(image_gray),
		. m_data(m_data),
///		 . byte_flag_neg(  byte_flag_neg),
		
	.byte_flag(byte_flag),
//		.vsync_rise(vsync_rise),
//		.frame_cnt(frame_cnt),
//		.frame0_flag(frame0_flag),
		.frame3_flag(frame3_flag),
		.frame4_flag(frame4_flag),
//	
	   .address(address),
//		.wire_address(wire_address),
	.CamWr_en( CamWr_en  ),
		. gray_word1_index(gray_word1_index),
		
	.gray_two_byte( gray_two_byte),
//	. 	CamEmpty( 	),
	.counter(counter)
//	.gray_two_byte_test(gray_two_byte_test)
//	

// 
//	  .byte_flag_cnt(byte_flag_cnt),
//	  .wire_rden(wire_rden),
//     .wire_wren(wire_wren),
//	  . wire_im_data( wire_im_data)//测试信号
);

 






////输出第1个字
//integer num1_1;
//initial
//begin

//num1_1=$fopen("C:/Users/avatar/Desktop/zhou_shibie/new/WRA_NOCORE/word_bin196.txt","w");
//end

//reg  DMARead_cnt_en;
//always @(posedge pclk)
//	begin
	
//		if(  EN==1'b1 )
//			begin

//				$fwrite(num1_1,"%b\n",CamDataIn[COUNT]);
//				if(COUNT==8'd195)
//				begin               
//					$fclose(num1_1);
//					DMARead_cnt_en<=1'b1;
//				end
//			end
//	end


	
		

wire [19:0] IdentifiedNum;
 wire CamEmpty;
WRA_NOCORE WRA_NOCORE0(
  .clk(pclk),
  .rst_n(rst),
   .CamDataIn({96'b0,gray_two_byte}),
 // .CamDataIn(DataFIFOIn),
 // .CamWr_en(DMARead_cnt_en),
    .CamWr_en(CamWr_en),
  .CamEmpty( CamEmpty),
  .IdentifiedNum(IdentifiedNum)
);

wire [3:0] result;
assign result=IdentifiedNum[3:0];


endmodule