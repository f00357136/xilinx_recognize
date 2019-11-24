

module top(
 
    input                      sys_clk_in,
	input                       rst_n,
	output          wire           led0,
	output          reg    led1,
	output         reg   led2,
	output         reg   led3,
	output         wire   led4,
	output         wire   led5,
	output         reg   led6,
    output   [7:0]              sel               ,  //数码管位选
    output    [6:0]             seg_led   ,        //数码管段选  
	
	//COMS1
    inout                       cmos_scl,          //cmos i2c clock
    inout                       cmos_sda,          //cmos i2c data
    input                       cmos_vsync,        //cmos vsync
    input                       cmos_href,         //cmos hsync refrence,data valid
    input                       cmos_pclk,         //cmos pxiel clock
    input   [7:0]               cmos_data,           //cmos data
    output                      cmos_rst_n        //cmos reset
	 
);
parameter MEM_DATA_BITS          = 64;             //external memory user interface data width
parameter ADDR_BITS              = 27;             //external memory user interface address width
parameter BUSRT_BITS             = 10;             //external memory user interface burst width

parameter  SLAVE_ADDR = 7'h3c         ;  
parameter  BIT_CTRL   = 1'b1          ;  
parameter  CLK_FREQ   = 26'd25_000_000;  
parameter  I2C_FREQ   = 18'd250_000   ;  
parameter  CMOS_H_PIXEL = 24'd640   ;  
parameter  CMOS_V_PIXEL = 24'd480     ;  

parameter  NUM_ROW    = 1'd1          ;  //需识别的图像的行数
parameter  NUM_COL    = 3'd4          ;  //需识别的图像的列数
parameter  H_PIXEL    = 10'd640        ;  //图像的水平像素
parameter  V_PIXEL    = 9'd480        ;  //图像的垂直像素
parameter  DEPBIT     = 4'd11         ;  //数据位宽

 wire                  i2c_exec        ;  
  wire   [23:0]         i2c_data        ;       
  wire                  i2c_done        ;  
  wire                  i2c_dri_clk     ; 
   wire          cam_init_done         ;                           
  wire                  wr_en           ;  
  wire   [15:0]         wr_data         ;  
  wire                  rd_en           ;  
  wire   [15:0]         rd_data         ;  
  wire                  sdram_init_done ;  
  wire                  sys_init_done   ;  

wire                            wr_burst_data_req;
wire                            wr_burst_finish;
wire                            rd_burst_finish;
wire                            rd_burst_req;
wire                            wr_burst_req;
wire[BUSRT_BITS - 1:0]          rd_burst_len;
wire[BUSRT_BITS - 1:0]          wr_burst_len;
wire[ADDR_BITS - 1:0]           rd_burst_addr;
wire[ADDR_BITS - 1:0]           wr_burst_addr;
wire                            rd_burst_data_valid;
wire[MEM_DATA_BITS - 1 : 0]     rd_burst_data;
wire[MEM_DATA_BITS - 1 : 0]     wr_burst_data;
wire                            read_req;
wire                            read_req_ack;
wire                            read_en;
wire[15:0]                      read_data;
wire                            write_en;
wire[15:0]                      write_data;
wire                            write_req;
wire                            write_req_ack;
wire                            video_clk;         //video pixel clock
wire                            hs;
wire                             vs;
wire                            de;
wire[15:0]                      vout_data;
wire[15:0]                      cmos_16bit_data;
wire                            cmos_16bit_wr;
wire[1:0]                       write_addr_index;
wire[1:0]                       read_addr_index;
wire[9:0]                       lut_index;
wire[31:0]                      lut_data;

wire                            ui_clk;
wire                            ui_clk_sync_rst;
wire                            init_calib_complete;
// Master Write Address
wire [3:0]                      s00_axi_awid;
wire [63:0]                     s00_axi_awaddr;
wire [7:0]                      s00_axi_awlen;    // burst length: 0-255
wire [2:0]                      s00_axi_awsize;   // burst size: fixed 2'b011
wire [1:0]                      s00_axi_awburst;  // burst type: fixed 2'b01(incremental burst)
wire                            s00_axi_awlock;   // lock: fixed 2'b00
wire [3:0]                      s00_axi_awcache;  // cache: fiex 2'b0011
wire [2:0]                      s00_axi_awprot;   // protect: fixed 2'b000
wire [3:0]                      s00_axi_awqos;    // qos: fixed 2'b0000
wire [0:0]                      s00_axi_awuser;   // user: fixed 32'd0
wire                            s00_axi_awvalid;
wire                            s00_axi_awready;
// master write data
wire [63:0]                     s00_axi_wdata;
wire [7:0]                      s00_axi_wstrb;
wire                            s00_axi_wlast;
wire [0:0]                      s00_axi_wuser;
wire                            s00_axi_wvalid;
wire                            s00_axi_wready;
// master write response
wire [3:0]                      s00_axi_bid;
wire [1:0]                      s00_axi_bresp;
wire [0:0]                      s00_axi_buser;
wire                            s00_axi_bvalid;
wire                            s00_axi_bready;
// master read address
wire [3:0]                      s00_axi_arid;
wire [63:0]                     s00_axi_araddr;
wire [7:0]                      s00_axi_arlen;
wire [2:0]                      s00_axi_arsize;
wire [1:0]                      s00_axi_arburst;
wire [1:0]                      s00_axi_arlock;
wire [3:0]                      s00_axi_arcache;
wire [2:0]                      s00_axi_arprot;
wire [3:0]                      s00_axi_arqos;
wire [0:0]                      s00_axi_aruser;
wire                            s00_axi_arvalid;
wire                            s00_axi_arready;
// master read data
wire [3:0]                      s00_axi_rid;
wire [63:0]                     s00_axi_rdata;
wire [1:0]                      s00_axi_rresp;
wire                            s00_axi_rlast;
wire [0:0]                      s00_axi_ruser;
wire                            s00_axi_rvalid;
wire                            s00_axi_rready;
wire                            sys_clk;
wire                            clk_50m;
wire[9:0]                       cmos_lut_index;
wire[31:0]                      cmos_lut_data;
wire [15:0] vga_rgb565;


//assign vga_hs = hs;
//assign vga_vs = vs;
//  assign  sys_init_done = init_calib_complete & cam_init_done;
assign  sys_init_done = cam_init_done;
assign  led0 = sys_init_done?1:0;


assign cmos_rst_n = 1'b1;
assign write_en = cmos_16bit_wr;
assign write_data = {cmos_16bit_data[4:0],cmos_16bit_data[10:5],cmos_16bit_data[15:11]};

// clk_wiz_0 pll
clk_wiz_1 pll
   (
    // Clock out ports
    .clk_out1(sys_clk   ),     // output clk_out1
    .clk_out2(video_clk),     // output clk_out2
    // Status and control signals
    .resetn(rst_n), // input resetn
    .locked(),       // output locked
   // Clock in ports
    .clk_in1(sys_clk_in));      // input clk_in1

//led1   验证   sys_clk  
always @(posedge sys_clk)    
    if(!rst_n)
         led1<=1'b0;
    else
        led1<=1'b1;
 //led2   验证   video_clk
always @(posedge video_clk)    
    if(!rst_n)
         led2<=1'b0;
    else
        led2<=1'b1;
//led3 验证   cmos_pclk     
always @(posedge cmos_pclk)    
    if(!rst_n)
         led3<=1'b0;
    else
        led3<=1'b1; 


   //I2C config
    i2c_ov5640_rgb565_cfg 
       #(
         .CMOS_H_PIXEL      (CMOS_H_PIXEL),
         .CMOS_V_PIXEL      (CMOS_V_PIXEL)
        )   
       u_i2c_cfg(   
        .clk                (i2c_dri_clk),
        .rst_n              (rst_n),
        .i2c_done           (i2c_done),
        .i2c_exec           (i2c_exec),
        .i2c_data           (i2c_data),
        .init_done          (cam_init_done)
        );    
    
    //I2C
    i2c_dri 
       #(
        .SLAVE_ADDR         (SLAVE_ADDR),     
        .CLK_FREQ           (CLK_FREQ  ),              
        .I2C_FREQ           (I2C_FREQ  )                
        )   
       u_i2c_dri(   
        .clk                (video_clk),
        .rst_n              (rst_n     ),   
            
        .i2c_exec           (i2c_exec  ),   
        .bit_ctrl           (BIT_CTRL  ),   
        .i2c_rh_wl          (1'b0),         
        .i2c_addr           (i2c_data[23:8]),   
        .i2c_data_w         (i2c_data[7:0]),   
        .i2c_data_r         (),   
        .i2c_done           (i2c_done  ),   
        .scl                (cmos_scl   ),   
        .sda                (cmos_sda   ),   
            
        .dri_clk            (i2c_dri_clk)       //I2C
    );
 
 
//  (* mark_debug = "true" *) wire [7:0] image_gray;
  (* mark_debug = "true" *)  wire [7:0] gray1;
 (* mark_debug = "true" *) wire frame4_flag;
 
// ila_0 ila_inst
// (
//    .clk(cmos_pclk),
//    .probe0(gray1),
//    .probe1(frame4_flag)
 
// );

// wire pclk_copy;
//wire pclk_dev;
//pll_pclk pll_pclk_inst(
//    .clk_in1(cmos_pclk),   //79.5Mhz
//    .resetn(rst_n), 
//    .clk_out1(pclk_copy),   //79.5Mhz
//    .clk_out2(pclk_dev)  //39.75Mhz
//);	
 
  
 wire  CamWr_en;
 wire [31:0] gray_two_byte;
 wire  [9:0] gray_word1_index;

 //20191021gai
image_process_new inst_image(
		.camera_data(cmos_data),
		.href(cmos_href),
		.vsync(cmos_vsync),
		.pclk(cmos_pclk),
//		.pclk_dev(pclk_dev),
		
		.rst(rst_n),
        .gray1(   gray1   ),
  //      .image_gray(image_gray),
        
	.CamWr_en( CamWr_en  ),
		. gray_word1_index(gray_word1_index),
		
		.frame4_flag(frame4_flag),
		
	.gray_two_byte( gray_two_byte)


);

//led4   验证   CamWr_en  ,灯亮的时候输入数据；   数据输入完，灯灭

assign led4=CamWr_en;
    
wire CamEmpty;
//led5   验证   CamEmpty  开始读数据时为0，设定为灯亮
assign led5=!CamEmpty;
   
wire [19:0] IdentifiedNum;

WRA_NOCORE WRA_NOCORE0(
  .clk(cmos_pclk),
  
  
  
  
  .rst_n(rst_n),
   .CamDataIn({96'b0,gray_two_byte}),

    .CamWr_en(CamWr_en),
  .CamEmpty(CamEmpty ),
  .IdentifiedNum(IdentifiedNum)
);
wire [3:0] result;
assign result=IdentifiedNum[3:0];

//led6   验证result，显示非0数，设定为灯亮
always @(posedge cmos_pclk)    
    if(!rst_n)
         led6<=1'b0;
    else if (result)
        led6<=1'b1;
    else led6<=1'b0;
       
seg_display seg_display_inst(
//20190927gai
   .clk(cmos_pclk)    ,        // 时钟信号
//  .clk(sys_clk_in)    ,  
   .rst_n (rst_n) ,        // 复位信号
    .num (result)   ,        //1个数码管要显示的数值
//  .num (4'b0001)   , 
    .sel (sel)   ,        // 数码管位选
    .seg_led (seg_led)        // 数码管段选
    
);

endmodule