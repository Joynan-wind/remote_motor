/**********************************************
模块：电机控制模块
说明：
输入：红外遥控信号-DataIn，时钟-CLK
输出：开关控制信号-SW,占空比设置信号-RateSet

***********************************************/
module MotorCrl(DataIn,SW,RateSet,CLK);
	input[31:0] DataIn;
	input CLK;
	output reg SW;
	output reg[6:0]RateSet;
	reg[7:0] NEC;
	
	always @(posedge CLK )
	begin
		case (DataIn[23:16])										  //高低位反转后NEC码的16到23位为其控制码
			8'h45:begin SW<=1'b1;end                       //控制码a2，开
			8'h15:begin                                    //控制码a8，电机加速
						if(RateSet==7'd50)RateSet<=7'd10;
						else RateSet<=RateSet+7'd10;
						end
			8'h09:begin                                    //控制码90，电机减速
						if(RateSet==7'd10)RateSet<=7'd50;
						else RateSet<=RateSet-7'd10;
						end
			8'h44:begin SW<=1'b0;end                       //控制码22，关
		endcase
	end
endmodule