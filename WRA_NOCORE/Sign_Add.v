module Sign_Add(A,B,C);
parameter width1=8;
parameter width2=9;
input  [width1*16-1:0] A,B;
output [width2*16-1:0] C;
wire signed [width1-1:0] a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16;
wire signed [width1-1:0] b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16;
wire signed [width2-1:0] c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16;
assign a1 =A[width1-1    :0        ];assign b1 =B[width1-1    :0        ];
assign a2 =A[width1*2 -1 :width1*1 ];assign b2 =B[width1*2 -1 :width1*1 ];
assign a3 =A[width1*3 -1 :width1*2 ];assign b3 =B[width1*3 -1 :width1*2 ];
assign a4 =A[width1*4 -1 :width1*3 ];assign b4 =B[width1*4 -1 :width1*3 ];
assign a5 =A[width1*5 -1 :width1*4 ];assign b5 =B[width1*5 -1 :width1*4 ];
assign a6 =A[width1*6 -1 :width1*5 ];assign b6 =B[width1*6 -1 :width1*5 ];
assign a7 =A[width1*7 -1 :width1*6 ];assign b7 =B[width1*7 -1 :width1*6 ];
assign a8 =A[width1*8 -1 :width1*7 ];assign b8 =B[width1*8 -1 :width1*7 ];
assign a9 =A[width1*9 -1 :width1*8 ];assign b9 =B[width1*9 -1 :width1*8 ];
assign a10=A[width1*10-1 :width1*9 ];assign b10=B[width1*10-1 :width1*9 ];
assign a11=A[width1*11-1 :width1*10];assign b11=B[width1*11-1 :width1*10];
assign a12=A[width1*12-1 :width1*11];assign b12=B[width1*12-1 :width1*11];
assign a13=A[width1*13-1 :width1*12];assign b13=B[width1*13-1 :width1*12];
assign a14=A[width1*14-1 :width1*13];assign b14=B[width1*14-1 :width1*13];
assign a15=A[width1*15-1 :width1*14];assign b15=B[width1*15-1 :width1*14];
assign a16=A[width1*16-1 :width1*15];assign b16=B[width1*16-1 :width1*15];

assign c1 = a1 +b1  ; assign C[width2-1    :0        ]=c1 ;
assign c2 = a2 +b2  ; assign C[width2*2 -1 :width2*1 ]=c2 ;
assign c3 = a3 +b3  ; assign C[width2*3 -1 :width2*2 ]=c3 ;
assign c4 = a4 +b4  ; assign C[width2*4 -1 :width2*3 ]=c4 ;
assign c5 = a5 +b5  ; assign C[width2*5 -1 :width2*4 ]=c5 ;
assign c6 = a6 +b6  ; assign C[width2*6 -1 :width2*5 ]=c6 ;
assign c7 = a7 +b7  ; assign C[width2*7 -1 :width2*6 ]=c7 ;
assign c8 = a8 +b8  ; assign C[width2*8 -1 :width2*7 ]=c8 ;
assign c9 = a9 +b9  ; assign C[width2*9 -1 :width2*8 ]=c9 ;
assign c10= a10+b10 ; assign C[width2*10-1 :width2*9 ]=c10;
assign c11= a11+b11 ; assign C[width2*11-1 :width2*10]=c11;
assign c12= a12+b12 ; assign C[width2*12-1 :width2*11]=c12;
assign c13= a13+b13 ; assign C[width2*13-1 :width2*12]=c13;
assign c14= a14+b14 ; assign C[width2*14-1 :width2*13]=c14;
assign c15= a15+b15 ; assign C[width2*15-1 :width2*14]=c15;
assign c16= a16+b16 ; assign C[width2*16-1 :width2*15]=c16;
endmodule
