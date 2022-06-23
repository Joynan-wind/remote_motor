/************分频器*****************
-说明-
FPGA实验四分频器元器件,通过参数传递实例化
200HZ和1HZ分频，此实验开发板外接晶振为48MHZ
-接口-
输入：分频前的时钟信号-clk_in，
输出：分频后的实际信号-clk_osht
-参数-
divdFACTOR：分频参数，分频系数为divdFACTOR*2
divdWIDTH:计数寄存器的宽度参数，实际宽度为divdWIDTH+1
-版本-
2022/4/15 v1.0 
-作者-
NAN
***********************************/
module Gen_Divd(clk_in,rst,clk_out);
	input clk_in,rst;
	output clk_out;
	parameter divdWIDTH=1,divdFACTOR=1;
	reg[divdWIDTH:0] cnt;
	reg clk_out;
	always @(posedge clk_in or negedge rst)
		begin
		if(!rst)
			cnt=0;
		else begin
			cnt=cnt+1'b1;
				if(cnt>=divdFACTOR)begin
					cnt=0;
					clk_out=~clk_out;
				end 
			end
		end
endmodule