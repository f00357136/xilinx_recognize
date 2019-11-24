`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/25 13:17:55
// Design Name: 
// Module Name: mult_lut_t
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module mult_lut_t;
    reg  [7:0] a, b;
    wire [15:0] c;
    mult_lut m(clk, a, b, c);
    initial begin
        clk<=0;
        a<=0;
        b<=0;
        #20
        a<=3;
        b<=8;
    end
    reg clk;
    always #10 clk=~clk;
endmodule
