`timescale 1ns/100ps


module no_core_test_1016;

	
	reg  pclk_in;
	
	reg  rst;



initial
begin
 

  pclk_in=0;

  rst=0;

#20 rst=1;


//$stop;

end


wire pclk;
wire pclk_dev;
pll_pclk pll_pclk_inst(
    .clk_in1(pclk_in),   //79.5Mhz
    .resetn(rst), 
    .clk_out1(pclk),   //79.5Mhz
    .clk_out2(pclk_dev)  //39.75Mhz
);	

always #1 pclk_in<=~pclk_in;



endmodule
