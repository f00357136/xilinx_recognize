module image_process_test(
	input [7:0] camera_data,
	input href,
	input vsync,
	
	input rst,
	
	input  pclk_dev,
	input  pclk,
	
	output wire [7:0] gray1,
	output reg [7:0] gray_word1,
	
	output  wire [7:0] image_gray,
	output reg  [10:0] gray_word1_index,//娴嬭瘯淇″彿
	 
	output reg [31:0] gray_two_byte,
	output CamWr_en	,
//	CamEmpty,
     output reg [3:0] counter,
     output reg [7:0] FIFO_COUNT,
	output reg byte_flag,
//	vsync_rise,
//	frame_cnt,
//	frame0_flag,
output 	wire frame3_flag,
output 	wire frame4_flag,
//
//	q,
   output  reg [13:0] address,
  output reg [15:0] m_data//rgb565
 //byte_flag_neg
	

//	byte_flag_cnt,
//	wire_rden,
//	wire_wren,
//	wire_im_data//娴嬭瘯淇″彿

);



	
	 
//	output wire 	CamEmpty;

      
	

	wire   	[15:0]  q		/* synthesis keep = 1 */;
	
	reg [3:0] frame_cnt;
	wire frame0_flag;

	
	
	wire  [13:0] wire_address;
   

	reg [15:0] byte_flag_cnt;
	wire  vsync_rise;
	wire 	  wire_rden;
	wire 	  wire_wren;

	wire [15:0] wire_im_data;//娴嬭瘯淇″彿
	


always  @(posedge pclk )
	begin
        if(!rst )
                byte_flag       <=      1'b0;
        else if(href == 1'b1 && frame3_flag==1'b1)
                byte_flag       <=      ~byte_flag;
        else
                byte_flag       <=      1'b0;
	end


// wire byte_flag_neg;
//	assign  byte_flag_neg=~byte_flag;
	 

always @ (posedge pclk)
	begin
		if(!rst )
			byte_flag_cnt<=1;
		else if(href==1'b0)
			byte_flag_cnt<=16'd1;
		else if((frame3_flag==1'b1) && (byte_flag_cnt>16'd1280))
			byte_flag_cnt<=16'd1;
//		else if((frame3_flag==1'b1) && (href==1'b1) && ( byte_flag_neg ==1'b1)&&((byte_flag_cnt <= 16'd1280)) )
else if((frame3_flag==1'b1) && (href==1'b1) && ( byte_flag ==1'b1)&&((byte_flag_cnt <= 16'd1280)) )
			byte_flag_cnt<=byte_flag_cnt+1'b1;

	end



always  @(posedge pclk )
	begin
        if(!rst)
                m_data  <=      16'b0;
        else if(byte_flag == 1'b1 && frame3_flag==1'b1)
                m_data  <=      {m_data[15:8], camera_data};
        else
                m_data  <=      {camera_data, m_data[7:0]};
	end




//采集的整个图像灰度
wire  [7:0] im_r;
wire  [7:0] im_g;
wire  [7:0] im_b;


assign 				im_r=(m_data[15:11]*527+23)>>6;
assign 		     	im_g=(m_data[10:5]*259+33)>>6;
assign 				im_b=(m_data[4:0]*527+23)>>6;
assign 	           image_gray=(im_r *38  +    im_g*75+    im_b*15)>>8;

//采集的整个图像灰度
//reg [7:0] im_r;
//reg [7:0] im_g;
//reg [7:0] im_b;
//reg [7:0] im_gray;
//always @ (posedge pclk)
//	begin
//		if(!rst | frame0_flag==1'b1)
//			begin
//				im_r<=0;
//				im_g<=0;
//				im_b<=0;
//				im_gray<=0;
//			end
//		else if(frame3_flag==1  && byte_flag == 1'b1 )
//			begin
//				im_r<=(m_data[15:11]*527+23)>>6;
//				im_g<=(m_data[10:5]*259+33)>>6;
//				im_b<=(m_data[4:0]*527+23)>>6;
//	           im_gray<=(im_r *38  +    im_g*75+    im_b*15)>>8;
//			end
//	end
	
//	always @(posedge pclk_dev)
//	if(!rst)
//	image_gray<=8'b0;
//	else 
//	image_gray<=im_gray;
	
	
//assign image_gray=im_gray;
// always  @(posedge pclk )
//    	begin
//        if(!rst)
//              m_data  <=   16'b0;
//       else if(byte_flag == 1'b1 && frame3_flag==1'b1)
//                m_data  <=    {camera_data, m_data[7:0]};
//       else
//               m_data  <=   {m_data[15:8], camera_data};   
//	end


//鎹曡幏vsync涓婂崌娌?
reg [1:0] vsync_r;
always @(posedge pclk  or negedge rst)
	begin
		if(!rst)
			vsync_r<=2'b0;
		else 
			vsync_r<={vsync_r[0],vsync};
			
	end



 assign vsync_rise =(~ vsync_r[1]  &  vsync_r[0] )? 1'b1 :1'b0;
 



always  @( posedge pclk) 
begin
        if(!rst )
                frame_cnt  <=0;
        else if( vsync_rise==1)
                frame_cnt <= frame_cnt + 1'b1;
end

assign frame0_flag=(frame_cnt==0) ? 1'b1 : 1'b0;
assign frame3_flag=(frame_cnt==3) ? 1'b1 : 1'b0;
assign frame4_flag=(frame_cnt==4) ? 1'b1 :1'b0;

//block ram鎺ュ彛


reg	  rden;
reg 	  wren;



assign wire_im_data=m_data;


assign wire_address=address	/* synthesis keep = 1 */;
assign 	  wire_rden=rden;
assign 	  wire_wren=wren;

 block_ram  inst_block(
	.a(wire_address),
	.clk(pclk),
	.d(wire_im_data),
	//.rden( ),
	.we(wire_wren),
	.spo(q));




reg [13:0] address1;
reg [13:0] address2;


//灏嗙涓夊抚鍥惧儚璇昏繘block ram涓?
//block ram鐨勫湴鍧?鍙兘鍦ㄦ椂閽熶笅闄嶆部鏃惰绠?
always @(negedge pclk)
	begin
		if(!rst | frame0_flag==1'b1)
			address1<=14'd0;
		else if(frame3_flag==1'b0)
			address1<=14'd1;
		
//	else if(frame3_flag==1'b1 && (byte_flag_cnt %6==0) && (byte_flag_neg==1'b1) && address1<=14'd11948)//1280/6*2*28
else if(frame3_flag==1'b1 && (byte_flag_cnt %6==0) && (byte_flag==1'b1) && address1<=14'd11948)//1280/6*2*28
//			else if(frame3_flag==1'b1 &&  (byte_flag==1'b1) && address1<=14'd11948)//1280/6*2*28

		begin
				address1<=address1+1'b1;
				wren<=1'b1;
			end
		else 
			wren<=1'b0;
	end




//鍦板潃澶氳矾閫夋嫨鍣?
//block ram鐨勫湴鍧?鍙兘鍦ㄤ笅闄嶆部鏃惰绠?
always @(negedge pclk)
	begin
		if(!rst | frame0_flag==1'b1)
			address<=14'd0;
		else if(frame3_flag==1'b1)//绗?3甯у皢鍥惧儚鐨勬暟鎹啓鍒皉am涓?
			begin
				address<=address1;
				rden<=1'b0;    		//绗?3甯т笉鍏佽璇绘暟鎹?
			end
		else if(frame4_flag==1'b1)//绗?4甯у紑濮嬪绗?1涓瓧閲囨牱
			begin
				address<=address2;
				rden<=1'b1;
			end
	end

//对一个字采样
//[784:1];




//第4帧开始对第1个字采样
reg [7:0] r1;
reg [7:0] g1;
reg [7:0] b1;

always @(posedge pclk)
	begin
		if(!rst | frame0_flag==1'b1)
			gray_word1_index<=10'd0;
	//	else if(frame4_flag==1'b1 && gray_word1_index<=10'd784 )
	
	
	//20190930gai
	else if(frame4_flag==1'b1 && gray_word1_index<=11'd1024 )
	
	
			gray_word1_index<=gray_word1_index+1;
	end

//reg [13:0] word1_index_delay;
//always @(posedge pclk)
//	begin
//		if(!rst | frame0_flag)
//			word1_index_delay<=10'd0;
//		else if(frame4_flag==1'b1  && cankao_word1_index<=785)
//			begin
//				word1_index_delay<=gray_word1_index;
//				cankao_word1_index<=cankao_word1_index+1'b1;
//			end
//	end
	
always @ (posedge pclk)
	begin
		if(!rst | frame0_flag==1'b1)
			begin
				r1<=0;
				g1<=0;
				b1<=0;
				gray_word1<=0;
			end
		else if(frame4_flag==1 && gray_word1_index<=10'd784)
			begin
				r1<=(q[15:11]*527+23)>>6;
				g1<=(q[10:5]*259+33)>>6;
				b1<=(q[4:0]*527+23)>>6;
				gray_word1<=(r1*38+g1*75+b1*15)>>8;
			end
	end

//左上角第一个数
//always @(negedge pclk)
//	begin
//		if(!rst | frame0_flag==1'b1)
//			address2<=10'd1;
//		else if(frame4_flag==1'b1 &&  (gray_word1_index +1) %28==0    )
//			address2<=address2+399;//213*2-27
//		else if(frame4_flag==1'b1 && ( gray_word1_index<=784))
//			address2<=address2+1'b1;
//	end

	
//扣第1个数字，原始的
//always @(negedge pclk)
//	begin
//		if(!rst | frame0_flag==1'b1)
//			address2<=10'd73;
//		else if(frame4_flag==1'b1 &&  (gray_word1_index +1) %28==0    )
//			address2<=address2+399;//213*2-27
//		else if(frame4_flag==1'b1 && ( gray_word1_index<=784))
//			address2<=address2+1'b1;
//	end
	
//	扣第2个数字，原始的
always @(negedge pclk)
	begin
		if(!rst | frame0_flag==1'b1)
			address2<=10'd101;
		else if(frame4_flag==1'b1 &&  (gray_word1_index +1) %28==0    )
			address2<=address2+399;//213*2-27
		else if(frame4_flag==1'b1 && ( gray_word1_index<=784))
			address2<=address2+1'b1;
	end


//第四个数字
//	always @(negedge pclk)
//	begin
//		if(!rst | frame0_flag==1'b1)
//			address2<=10'd157;
//		else if(frame4_flag==1'b1 &&  (gray_word1_index +1) %28==0    )
//			address2<=address2+399;//213*2-27
//		else if(frame4_flag==1'b1 && ( gray_word1_index<=784))
//			address2<=address2+1'b1;
//	end
	
	//第5个数字
//	always @(negedge pclk)
//	begin
//		if(!rst | frame0_flag==1'b1)
//			address2<=10'd185;
//		else if(frame4_flag==1'b1 &&  (gray_word1_index +1) %28==0    )
//			address2<=address2+399;//213*2-27
//		else if(frame4_flag==1'b1 && ( gray_word1_index<=784))
//			address2<=address2+1'b1;
//	end
	//第三个数字
//		always @(negedge pclk)
//	begin
//		if(!rst | frame0_flag==1'b1)
//			address2<=10'd129;
//		else if(frame4_flag==1'b1 &&  (gray_word1_index +1) %28==0    )
//			address2<=address2+399;//213*2-27
//		else if(frame4_flag==1'b1 && ( gray_word1_index<=784))
//			address2<=address2+1'b1;
//	end
assign gray1=gray_word1;

always  @(posedge pclk )
	begin
        if(!rst)
			     begin
              //       gray_two_byte <=   32'b0;
					 counter<=4'b0;
				end	 
        else  if( frame4_flag==1'b1 && (gray_word1_index<=784))
		       begin
					
						if(counter<3)
							begin
						//	gray_two_byte<={gray_two_byte[23:0], gray_word1};
							counter<=counter+1'b1;
							
							end
				        else 
							begin
						//	gray_two_byte<={gray_two_byte[23:0], gray_word1};
							counter<=0;
							end
				end					
		 
					
 end
		
		//原始的2019.9.22写的
		always@(posedge pclk)
    begin
        if(!rst)
        gray_two_byte<=32'b0;
        
        //20190930gai
        else if(gray_word1_index==10'd786) 
        gray_two_byte<=32'b0;
     
        
    else  if( frame4_flag==1'b1 && (gray_word1_index<=784)  &&  (gray_word1_index>=10'd1)  )
    begin
    if((gray_word1_index % 4)==4'd1)
     gray_two_byte <={gray_two_byte[31:8],gray_word1};
     
     
     else if  ((gray_word1_index % 4)==4'd2)
     gray_two_byte<={gray_two_byte[31:16],gray_word1,gray_two_byte[7:0]};
     
     
        else if((gray_word1_index % 4)==4'd3)
     gray_two_byte<={gray_two_byte[31:24],gray_word1,gray_two_byte[15:0]};
     
        else if((gray_word1_index % 4)==4'd0)
     gray_two_byte<={gray_word1,gray_two_byte[23:0]};
    end
 end

 
//assign CamWr_en=((gray_word1_index -1)  %4 ==1'b0   && (frame4_flag==1'b1)  )  ?1'b1  :1'b0;  原始的
//assign CamWr_en=((gray_word1_index -1)  %4 ==1'b0   && (frame4_flag==1'b1) &&(gray_word1_index<=10'd785) )  ?1'b1  :1'b0; //修改的2019.9.22

//20190930gai		
assign CamWr_en=((gray_word1_index -1)  %4 ==1'b0   && (frame4_flag==1'b1) &&(gray_word1_index<=11'd1024) )  ?1'b1  :1'b0; //修改的2019.9.22	
		

		
//    wire CamWr_en_delay; 
//  assign CamWr_en_delay=  (counter ==4'd3) ? 1'b1 :1'b0;
//  reg CamWr_en_delay_dd,CamWr_en_ddd,CamWr_en_dddd;
//  always @(posedge pclk)
    
//    begin
//        if(!rst)
//        begin
      
        
//        CamWr_en_delay_dd<=1'b0;
        
//        CamWr_en_ddd<=1'b0;
//        CamWr_en_dddd<=1'b0;
//        end
        
//        else 
//        begin
//            CamWr_en_delay_dd<=CamWr_en_delay;
//            CamWr_en_ddd<=CamWr_en_delay_dd;
//            CamWr_en_dddd<=CamWr_en_ddd;
//        end
        
//    end
    
//        assign       CamWr_en= CamWr_en_dddd;




endmodule
