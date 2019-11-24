

module seg_display(
   //input
   input                  clk    ,        // ʱ���ź�
   input                  rst_n  ,        // ��λ�ź�

     input       [3:0]    num    ,        //1�������Ҫ��ʾ����ֵ

   output  reg   [7:0]   sel    ,        // �����λѡ
   output  reg  [6:0]     seg_led         // ����ܶ�ѡ
);


//�������ʾ����
always @ (posedge clk) begin
    if(!rst_n )
        begin
            seg_led <= 7'b000_0001;   //��λ�����������ʾ0
            sel <= 8'b0111_1111;     //�߲�ѡͨ
        end
    else begin
                 sel <= 8'b1111_1110;
                case(num)
                    4'd0: seg_led <= 7'b000_0001;   //�� ����
                    4'd1: seg_led <= 7'b100_1111;
                    4'd2: seg_led <= 7'b001_0010;
                    4'd3: seg_led <= 7'b000_0110;
                    4'd4: seg_led <= 7'b100_1100;
                    4'd5: seg_led <= 7'b010_0100;
                    4'd6: seg_led <= 7'b010_0000;
                    4'd7: seg_led <= 7'b000_1111;
                    4'd8: seg_led <= 7'b000_0000;
                    4'd9: seg_led <= 7'b000_0100;
                    default: seg_led <= 7'b111_1111;
                endcase
           end
end
endmodule
