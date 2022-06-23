/**********************************************
模块：PWM信号产生器
说明：用来作为电机的PWM信号输出，改变输入信号RateSet
		的值可以改变占空比以达到控制电机转速的目的。
输入：复位-Rst,时钟-Clk,占空比设置-RateSet,
输出：电机的PWM信号输出-PWMOut
***********************************************/
module PWM(Rst,Clk,RateSet,PWMOut);


input Rst,Clk;
output reg PWMOut;
input[6:0] RateSet;	
reg [6:0]Cnt;
reg[6:0] rate;
	
	
always @ (negedge Rst or posedge Clk)
	if(!Rst)
		begin
			Cnt<=0;
			PWMOut<=0;
			rate<=10;
		end
	else
		begin
		rate<=RateSet;                //将占空比设置复制给占空比寄存器
		Cnt<=Cnt+1'b1;
		if (Cnt<rate)
			PWMOut<=1'b1;
		else if (Cnt>=rate && Cnt<99)
			PWMOut<=1'b0;
		else if (Cnt>=99) 
			Cnt<=0;
		end	
		
endmodule