/*
输入：PWM频率--rate_set
输出:数码管段码
*/

module nixie_tube(rate_set,dataout);
	input[6:0] rate_set;
	output[7:0] dataout;
	
	reg[7:0] dataout;
	
	always@(rate_set)
		begin
			case(rate_set)  //将要显示的数字译成段码
			  7'd0://0
					dataout=8'b0000_0011;
			  7'd10://1
					dataout=8'b1001_1111;
			  7'd20://2
					dataout=8'b0010_0101;
			  7'd30://3
					dataout=8'b0000_1101;
			  7'd40://4
					dataout=8'b1001_1001;
			  7'd50://5
					dataout=8'b0100_1001;
			  7'd60://6
					dataout=8'b0100_0001;
			  7'd70://7
					dataout=8'b0001_1111;
			  7'd80://8
					dataout=8'b0000_0001;
			  7'd90://9
					dataout=8'b0000_1001;
			 default://这里仅编译了0-9这几个数字
					dataout=8'b1111_1111;//全灭
			endcase
		
		end
endmodule
	