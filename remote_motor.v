/**********************************************
模块：遥控电机
说明：遥控电机的顶层文件，运行逻辑如下：
		将红外接收头接收到的信号送入解码模块（IRDA），解码后
		得到的高低位反转的NEC码送入电机控制模块（MotorCrl）,
		控制模块根据接收到的信号输出开占空比设置信号到PWM信号发
		生模块（PWM），并输出开关控制信号SW。PWM发生模块根据接收
		到的信号输出对应占空比的PWM信号。
		另实例化了两个分频器。
输入：开发板时钟信号-CLK，复位-RST，红外接收器接收信号-Din，

输出：电机输出-DriveOut，数码管段码-dataout，点阵行信号-col，
		点阵列信号-row
		
遥控按键：设置了4个按键，开/关键，电机加/减速键。

P.S.1.数码管和点阵信号是为了使其熄灭，降低功率消耗；
	 2.实验室配套的电机占空比很低时依然转速很快，并且可能因为
	 开发板电源供电能力有限，电机启动后红外遥控会失效，所以用的是
	 我们自己另一个功率较小的电机。
	 3.我们开发板套件少了一个遥控器，我们用的是普中科技的遥控器，
	 因为普中科技的遥控器设置了连发码，所以有时按键失灵。经测试实验室配
	 套的遥控器有三个按键的键值是我们实验用的遥控器按键键值是一样的，并且
	 因为没有连发码设置没有按键失效的情况。
***********************************************/
module remote_motor(CLK,RST,Din,DriveOut,dataout,row,col,en);
	input CLK,RST,Din;
	output[1:0] DriveOut;
	output[3:0] en;
	output[7:0] dataout,row,col;
	wire CLK10kHz,CLK100kHz;
	wire[31:0] DataNet;
	wire[6:0] RateSet;
	wire PWMOut,SW,FinishShort;
	Gen_Divd #(.divdFACTOR(2400),.divdWIDTH(12))                       //10kHz
				Divd10kHz(.clk_in(CLK),.rst(RST),.clk_out(CLK10kHz));
	Gen_Divd #(.divdFACTOR(240),.divdWIDTH(7))
				Divd100kHz(.clk_in(CLK),.rst(RST),.clk_out(CLK100kHz));       //为PWM的时钟信号做预分频处理
	IRDA U1(.CLK10kHz(CLK10kHz),.Din(Din),.Dout(DataNet),.RST(RST));
	MotorCrl U2(.DataIn(DataNet),.SW(SW),.RateSet(RateSet),.CLK(CLK10kHz));
	PWM U3(.Rst(RST),.Clk(CLK100kHz),.RateSet(RateSet),.PWMOut(PWMOut));
	nixie_tube U4(.rate_set(RateSet),.dataout(dateout));
	
	assign DriveOut[0]=SW?PWMOut:1'b0;
	assign DriveOut[1]=1'b0;
	assign en=4'b0111;
	//assign dataout=8'b11111111;
	assign row=8'b11111111;
	assign col=8'b11111111;
endmodule