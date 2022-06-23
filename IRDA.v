/******************************************
模块：红外接收头解码
说明：将红外接收器接收的信号解码为32位的NEC码，Dout为
		解码后的NEC码，持续两个CLK10kHz后归零。
输入：10kHz时钟频率-CLK10kHZ，红外接收头信号-Din，
		复位信号-RST
输出：高低位翻转的NEC码-Dout
过程：过程1-解码
		根据红外线遥控的编码原理，通过计算两个Din
		下降沿之间的时间间隔，判断红外接受器接收到的信号
		为引导码、数据“1”或“0”（不考虑连发码）.接收到
		引导码后，将接收到的数据“1”或“0”移位寄存到Data。
		当Data寄存到32位后接收完成。Data里的数据为高低位翻转的
		接收到的NEC码。
		过程2-发送
		高低位翻转的NEC码发送两个CLK10kHz周期后归零。		
*****************************************/
module IRDA(CLK10kHz,Din,Dout,RST);
	input CLK10kHz,Din,RST;
	output reg[31:0] Dout;
	reg[31:0] Data;
	reg DataTmp0;//--当前值
	reg DataTmp1;//--前一刻的值
	reg ShortFinish0;//--当前值
	reg ShortFinish1;//--前一刻的值
	reg FinishShort;//--持续一个clk1k周期
	reg FinishFlag;
	reg DinTmp,a;
	reg [5:0] BitCnt;
	reg StartFlag;
	reg [7:0] Cnt;


always @ (posedge CLK10kHz or negedge RST)
	begin
		if (!RST) 
			DinTmp<=1'b1;
		else 
			DinTmp<=Din;
	end
	
//过程1 TTL电平信号转化为高低位翻转的NEC码，寄存在Data中	
	always @ (posedge CLK10kHz or negedge RST)

	begin
		if (!RST) 
			begin
				Cnt<=1'b0;
				BitCnt<=1'b0;
				FinishFlag<=1'b0;
				StartFlag<=1'b0;
			end
		else
			begin
				DataTmp0<=DinTmp;
				DataTmp1<=DataTmp0;
				if (DataTmp0==1'b0 && DataTmp1==1'b1) //--下降沿
					begin
					if(Cnt==1'b0) //--刚进入的第一次，舍去
						StartFlag<=1'b1;//--开始计数
					else if (Cnt>9 && Cnt<13)  //--'0',1.125ms
						begin
							Data[BitCnt]<=1'b0;
							BitCnt<=BitCnt+1'b1;
						end
					else if (Cnt>20 && Cnt<24)  //--'1',2.25ms
						begin
						Data[BitCnt]<=1'b1;
						BitCnt<=BitCnt+1'b1;
					
						end
					else if (Cnt>90 && Cnt<150)  //--起始码+结果码(9ms+4.5ms=13.5ms) 时间稍微宽一些
						begin
						BitCnt<=1'b0;
						FinishFlag<=1'b0;//--清完成标志
						end
					else
						StartFlag<=1'b0;//--其他情况不计数，即只识别以上几种间隔
					
					if(BitCnt==6'd32) //--一帧数据接收完毕
						begin
							FinishFlag<=1'b1;
							BitCnt<=1'b0;
						end
				
					Cnt<=1'b0;//--清零，准备计数下面两个下降沿之间的间隔
					end
				else
					if (StartFlag==1'b1) 
						Cnt<=Cnt+1'b1;
			end
			
end

//过程2：Dout输出红外接收信号持续两个Clk10k周期
always @ (negedge CLK10kHz or negedge RST)
	begin
		if (!RST) 
			FinishShort<=1'b0;
		else  
			begin
				ShortFinish0<=FinishFlag;
				ShortFinish1<=ShortFinish0;
				if (ShortFinish0==1'b1 && ShortFinish1==1'b0) //--上升沿
				begin	Dout<=Data;a<=1'b1;end
				else
				begin if(a)begin Dout<=Data;a<=1'b0;end else begin Dout<=0;a<=1'b0; end end
			end 
	end

endmodule