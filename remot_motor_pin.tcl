#ע  :     ļ   һ      λ õ ʾ   ļ , ھ     Ӧ    ,Ҫ           ĳ     ޸  "-to"           , Ժ    ĳ             ƥ  
#-----------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------
#ʱ  
set_location_assignment PIN_16 -to CLK
#  λ
set_location_assignment PIN_17 -to RST


#            
set_location_assignment PIN_35 -to Din

#  һ·ֱ           ź (         ̹  ã   ϸ    ·ͼ    Ҫ    ñ    )
set_location_assignment PIN_39 -to DriveOut0
set_location_assignment PIN_40 -to DriveOut1


#点阵的控制信号
set_location_assignment PIN_128 -to col[0]
set_location_assignment PIN_131 -to col[1]
set_location_assignment PIN_129 -to col[2]
set_location_assignment PIN_120 -to col[3]
set_location_assignment PIN_123 -to col[4]
set_location_assignment PIN_122 -to col[5]
set_location_assignment PIN_132 -to col[6]
set_location_assignment PIN_134 -to col[7]

set_location_assignment PIN_114 -to row[0]
set_location_assignment PIN_130 -to row[1]
set_location_assignment PIN_119 -to row[2]
set_location_assignment PIN_124 -to row[3]
set_location_assignment PIN_139 -to row[4]
set_location_assignment PIN_121 -to row[5]
set_location_assignment PIN_133 -to row[6]
set_location_assignment PIN_125 -to row[7]

#数码管位码控制引脚
set_location_assignment PIN_6 -to en[0] 
set_location_assignment PIN_144 -to en[1] 
set_location_assignment PIN_142 -to en[2] 
set_location_assignment PIN_141 -to en[3] 

#数码管控制信号
#数码管段码控制引脚
set_location_assignment PIN_3 -to dataout[0]
set_location_assignment PIN_143 -to dataout[1]
set_location_assignment PIN_2  -to dataout[2]
set_location_assignment PIN_7  -to dataout[3]
set_location_assignment PIN_5 -to dataout[4]
set_location_assignment PIN_1 -to dataout[5]
set_location_assignment PIN_140 -to dataout[6]
set_location_assignment PIN_4 -to dataout[7]