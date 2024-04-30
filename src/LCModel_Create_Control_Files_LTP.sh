#!/bin/bash
#Batch Processing for LCModel
#Adapted for the pre-processed data from FID-A/MM
#Orig Tiffany Bell
#Adapted M DeMayo
#2020/Aug/23

# in_path=COT0201/
# out_path=COT0201/


list_of_files=list_controlfiles.csv
basis_set_path='/Volumes/catherine_team/mvperdue/preschool/mrs/BasisSet/PRESS30.basis'
atth2o=0.7
wconc=55510

LAG_PFiles="
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10006_PS14_120_3301/PS10006_PS14_120_3301_P27136.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10006_PS15_061_3976/PS10006_PS15_061_3976_P14336.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10006_PS15_138_4795/PS10006_PS15_138_4795_P56320.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10006_PS19_010_11360/PS10006_PS19_010_11360_P43520.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10007_PS14_121_3300/PS10007_PS14_121_3300_P21504.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10007_PS15_062_3975/PS10007_PS15_062_3975_P08192.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10007_PS15_139_4794/PS10007_PS15_139_4794_P50176.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10007_PS19_009_11359/PS10007_PS19_009_11359_P36352.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS14_079_3157/PS10008_PS14_079_3157_P19456.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS15_040_4076/PS10008_PS15_040_4076_P07680.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS16_001_4952/PS10008_PS16_001_4952_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS16_045_5887/PS10008_PS16_045_5887_P09728.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS17_018_8126/PS10008_PS17_018_8126_P39936.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS21_032_14127/PS10008_PS21_032_14127_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10009_PS15_002_3425/PS10009_PS15_002_3425_P08704.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10009_PS16_020_5171/PS10009_PS16_020_5171_P23552.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10009_PS16_072_6081/PS10009_PS16_072_6081_P13312.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10009_PS17_029_8421/PS10009_PS17_029_8421_P26624.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS15_014_3393/PS10010_PS15_014_3393_P10240.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS15_095_4246/PS10010_PS15_095_4246_P23040.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS16_004_4975/PS10010_PS16_004_4975_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS16_046_5890/PS10010_PS16_046_5890_P26112.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS17_008_8172/PS10010_PS17_008_8172_P37888.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS21_009_13287/PS10010_PS21_009_13287_P39936.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10014_PS15_112_4740/PS10014_PS15_112_4740_P35840.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10014_PS16_030_5675/PS10014_PS16_030_5675_P50176.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10014_PS18_001_9736/PS10014_PS18_001_9736_P10240.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10014_PS19_016_11553/PS10014_PS19_016_11553_P25600.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10014_PS21_019_13433/PS10014_PS21_019_13433_P07680.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10015_PS15_066_4093/PS10015_PS15_066_4093_P58880.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS15_032_3816/PS10020_PS15_032_3816_P27648.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS15_116_4665/PS10020_PS15_116_4665_P39424.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS16_028_5677/PS10020_PS16_028_5677_P61440.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS17_013_7959/PS10020_PS17_013_7959_P77312.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS18_027_10478/PS10020_PS18_027_10478_P32768.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS19_029_11873/PS10020_PS19_029_11873_P56320.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS21_027_13902/PS10020_PS21_027_13902_P24064.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10021_PS14_081_3156/PS10021_PS14_081_3156_P13312.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10021_PS15_045_3852/PS10021_PS15_045_3852_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10021_PS15_115_4744/PS10021_PS15_115_4744_P14336.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10021_PS17_011_7719/PS10021_PS17_011_7719_P54272.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS14_094_3155/PS10022_PS14_094_3155_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS15_049_3847/PS10022_PS15_049_3847_P55808.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS15_128_4739/PS10022_PS15_128_4739_P29184.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS16_036_5632/PS10022_PS16_036_5632_P10240.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS18_032_10805/PS10022_PS18_032_10805_P24064.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS19_040_12308/PS10022_PS19_040_12308_P04608.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10025_PS14_075_3118/PS10025_PS14_075_3118_P72192.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10025_PS15_120_4709/PS10025_PS15_120_4709_P13824.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10025_PS16_034_5518/PS10025_PS16_034_5518_P05632.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10025_PS18_024_10263/PS10025_PS18_024_10263_P57344.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS15_037_3773/PS10027_PS15_037_3773_P42496.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS15_114_4731/PS10027_PS15_114_4731_P09728.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS16_057_5697/PS10027_PS16_057_5697_P25600.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS17_019_7770/PS10027_PS17_019_7770_P54784.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS18_017_10155/PS10027_PS18_017_10155_P62976.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS19_022_11634/PS10027_PS19_022_11634_P30208.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10029_PS14_119_3258/PS10029_PS14_119_3258_P10752.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10032_PS14_144_3152/PS10032_PS14_144_3152_P22016.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10032_PS15_121_4625/PS10032_PS15_121_4625_P11264.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10032_PS16_037_5603/PS10032_PS16_037_5603_P05632.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10032_PS17_006_7650/PS10032_PS17_006_7650_P25088.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10032_PS18_021_10444/PS10032_PS18_021_10444_P11264.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10037_PS14_078_3143/PS10037_PS14_078_3143_P28672.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10037_PS15_140_4790/PS10037_PS15_140_4790_P19968.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10037_PS17_014_7512/PS10037_PS17_014_7512_P74752.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10037_PS18_016_10101/PS10037_PS18_016_10101_P04096.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10037_PS19_026_11808/PS10037_PS19_026_11808_P14848.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10042_PS14_111_3119/PS10042_PS14_111_3119_P79360.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10043_PS14_135_3298/PS10043_PS14_135_3298_P09728.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10043_PS15_068_3944/PS10043_PS15_068_3944_P20992.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10043_PS15_129_4831/PS10043_PS15_129_4831_P26624.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS14_071_3219/PS10044_PS14_071_3219_P33792.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS15_103_4150/PS10044_PS15_103_4150_P14336.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS16_019_5024/PS10044_PS16_019_5024_P29696.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS16_068_5966/PS10044_PS16_068_5966_P33792.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS17_036_9934/PS10044_PS17_036_9934_P27136.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS19_012_11420/PS10044_PS19_012_11420_P37888.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS21_011_13359/PS10044_PS21_011_13359_P14336.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10045_PS14_099_3284/PS10045_PS14_099_3284_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS15_003_3383/PS10046_PS15_003_3383_P58880.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS15_099_4176/PS10046_PS15_099_4176_P58880.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS16_023_5055/PS10046_PS16_023_5055_P39936.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS17_009_7456/PS10046_PS17_009_7456_P53248.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS19_005_11188/PS10046_PS19_005_11188_P57856.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS20_003_12527/PS10046_PS20_003_12527_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS21_011_13376/PS10046_PS21_011_13376_P52224.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10047_PS14_136_3445/PS10047_PS14_136_3445_P10240.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10047_PS15_101_4413/PS10047_PS15_101_4413_P58368.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10047_PS16_018_5260/PS10047_PS16_018_5260_P19968.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10049_PS14_117_3235/PS10049_PS14_117_3235_P07168.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10049_PS15_084_4104/PS10049_PS15_084_4104_P30720.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10049_PS16_053_5610/PS10049_PS16_053_5610_P20480.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10049_PS17_023_7962/PS10049_PS17_023_7962_P13824.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10053_PS14_134_3253/PS10053_PS14_134_3253_P17408.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10053_PS15_059_4105/PS10053_PS15_059_4105_P40960.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10053_PS16_009_4972/PS10053_PS16_009_4972_P26112.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10053_PS16_049_6353/PS10053_PS16_049_6353_P52224.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10053_PS19_006_11181/PS10053_PS19_006_11181_P31744.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS14_110_3205/PS10054_PS14_110_3205_P15360.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS15_057_3797/PS10054_PS15_057_3797_P16896.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS15_110_4634/PS10054_PS15_110_4634_P23040.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS16_032_5628/PS10054_PS16_032_5628_P36864.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS17_034_8491/PS10054_PS17_034_8491_P55808.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS18_039_10868/PS10054_PS18_039_10868_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10056_PS15_009_3498/PS10056_PS15_009_3498_P36864.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10056_PS15_098_4455/PS10056_PS15_098_4455_P05632.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10057_PS14_113_3445/PS10057_PS14_113_3445_P10240.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS15_004_3390/PS10059_PS15_004_3390_P29184.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS15_082_4270/PS10059_PS15_082_4270_P30208.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS16_011_5003/PS10059_PS16_011_5003_P24064.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS16_065_6017/PS10059_PS16_065_6017_P57344.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS17_026_8577/PS10059_PS17_026_8577_P66048.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS19_039_12271/PS10059_PS19_039_12271_P24576.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS14_123_3178/PS10061_PS14_123_3178_P24064.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS15_056_3969/PS10061_PS15_056_3969_P23040.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS15_125_4857/PS10061_PS15_125_4857_P47616.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS16_054_5673/PS10061_PS16_054_5673_P35840.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS17_015_7911/PS10061_PS17_015_7911_P67584.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS18_023_10363/PS10061_PS18_023_10363_P22016.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS19_028_11861/PS10061_PS19_028_11861_P30208.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10064_PS15_109_4436/PS10064_PS15_109_4436_P05632.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10064_PS16_085_6428/PS10064_PS16_085_6428_P50688.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS15_069_4227/PS10065_PS15_069_4227_P15360.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS16_002_4959/PS10065_PS16_002_4959_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS16_043_5809/PS10065_PS16_043_5809_P08192.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS17_007_7863/PS10065_PS17_007_7863_P66560.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS18_019_10215/PS10065_PS18_019_10215_P45568.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS19_034_12106/PS10065_PS19_034_12106_P15360.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10066_PS15_102_4190/PS10066_PS15_102_4190_P24576.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10066_PS16_012_4954/PS10066_PS16_012_4954_P08704.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10066_PS16_058_5925/PS10066_PS16_058_5925_P12288.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10067_PS16_055_6000/PS10067_PS16_055_6000_P24064.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10067_PS18_009_9837/PS10067_PS18_009_9837_P38912.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10068_PS15_001_3447/PS10068_PS15_001_3447_P12800.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10068_PS15_077_4320/PS10068_PS15_077_4320_P28160.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10069_PS15_071_3826/PS10069_PS15_071_3826_P10240.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10073_PS15_013_3461/PS10073_PS15_013_3461_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10073_PS15_086_4133/PS10073_PS15_086_4133_P18944.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10073_PS16_013_5071/PS10073_PS16_013_5071_P26112.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10073_PS16_050_5984/PS10073_PS16_050_5984_P08704.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10077_PS15_012_3547/PS10077_PS15_012_3547_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10077_PS15_123_4414/PS10077_PS15_123_4414_P07680.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10077_PS16_022_5245/PS10077_PS16_022_5245_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10077_PS16_066_6217/PS10077_PS16_066_6217_P13824.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS15_029_3652/PS10079_PS15_029_3652_P20992.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS15_108_4563/PS10079_PS15_108_4563_P11776.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS16_039_5423/PS10079_PS16_039_5423_P41984.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS16_079_6439/PS10079_PS16_079_6439_P22528.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS17_056_9607/PS10079_PS17_056_9607_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS20_006_12563/PS10079_PS20_006_12563_P11264.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS15_016_3935/PS10080_PS15_016_3935_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS15_144_4883/PS10080_PS15_144_4883_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS16_059_5644/PS10080_PS16_059_5644_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS17_027_8572/PS10080_PS17_027_8572_P32768.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS20_018_12680/PS10080_PS20_018_12680_P09728.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS21_015_13330/PS10080_PS21_015_13330_P38400.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10081_PS15_044_3719/PS10081_PS15_044_3719_P38400.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10081_PS15_104_4548/PS10081_PS15_104_4548_P62464.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10082_PS15_031_3820/PS10082_PS15_031_3820_P24064.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10082_PS16_027_5724/PS10082_PS16_027_5724_P33280.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS15_053_3810/PS10083_PS15_053_3810_P27136.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS15_113_4866/PS10083_PS15_113_4866_P30720.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS16_051_6059/PS10083_PS16_051_6059_P31744.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS17_022_7749/PS10083_PS17_022_7749_P67584.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS17_038_8549/PS10083_PS17_038_8549_P53248.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS18_033_10773/PS10083_PS18_033_10773_P15872.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS21_034_14201/PS10083_PS21_034_14201_P33792.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10085_PS15_025_3680/PS10085_PS15_025_3680_P33792.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10085_PS16_041_5373/PS10085_PS16_041_5373_P35840.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10085_PS17_050_9499/PS10085_PS17_050_9499_P43008.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10085_PS19_001_11288/PS10085_PS19_001_11288_P67072.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10085_PS20_011_12671/PS10085_PS20_011_12671_P14848.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS15_030_3629/PS10087_PS15_030_3629_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS15_111_4508/PS10087_PS15_111_4508_P17408.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS16_038_5432/PS10087_PS16_038_5432_P04096.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS16_077_6445/PS10087_PS16_077_6445_P38912.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS17_024_8138/PS10087_PS17_024_8138_P21504.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS18_031_10521/PS10087_PS18_031_10521_P40448.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS19_044_12347/PS10087_PS19_044_12347_P51712.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS20_030_13121/PS10087_PS20_030_13121_P41984.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS21_030_14120/PS10087_PS21_030_14120_P28160.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS15_047_3872/PS10088_PS15_047_3872_P09728.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS15_147_4828/PS10088_PS15_147_4828_P12800.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS16_060_5743/PS10088_PS16_060_5743_P14848.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS17_001_6924/PS10088_PS17_001_6924_P24576.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS18_005_9733/PS10088_PS18_005_9733_P12800.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS19_051_12344/PS10088_PS19_051_12344_P29696.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS20_031_13118/PS10088_PS20_031_13118_P19456.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10089_PS15_023_3679/PS10089_PS15_023_3679_P23552.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10089_PS15_097_4491/PS10089_PS15_097_4491_P29184.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10089_PS16_015_5404/PS10089_PS16_015_5404_P15872.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS15_015_3568/PS10090_PS15_015_3568_P54784.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS15_096_4440/PS10090_PS15_096_4440_P35328.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS16_008_5148/PS10090_PS16_008_5148_P45056.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS16_067_6193/PS10090_PS16_067_6193_P13824.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS17_031_8539/PS10090_PS17_031_8539_P52736.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS18_034_10840/PS10090_PS18_034_10840_P26624.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS20_021_13094/PS10090_PS20_021_13094_P08704.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10094_PS15_124_4453/PS10094_PS15_124_4453_P29696.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10094_PS16_044_5447/PS10094_PS16_044_5447_P54272.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10094_PS17_045_9591/PS10094_PS17_045_9591_P29696.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10096_PS15_131_4656/PS10096_PS15_131_4656_P46080.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10096_PS16_040_5499/PS10096_PS16_040_5499_P30720.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10096_PS17_054_9541/PS10096_PS17_054_9541_P59392.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10096_PS21_026_13815/PS10096_PS21_026_13815_P15872.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS15_048_3881/PS10097_PS15_048_3881_P16896.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS15_127_4710/PS10097_PS15_127_4710_P20992.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS16_026_5513/PS10097_PS16_026_5513_P04608.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS17_017_7772/PS10097_PS17_017_7772_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS18_020_10194/PS10097_PS18_020_10194_P17408.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS21_025_13774/PS10097_PS21_025_13774_P27136.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10098_PS15_118_4818/PS10098_PS15_118_4818_P14848.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10098_PS16_070_5924/PS10098_PS16_070_5924_P05632.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10104_PS15_042_4058/PS10104_PS15_042_4058_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10104_PS16_003_5205/PS10104_PS16_003_5205_P07680.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10104_PS16_081_6390/PS10104_PS16_081_6390_P10752.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10104_PS17_028_8207/PS10104_PS17_028_8207_P51200.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10104_PS19_019_11492/PS10104_PS19_019_11492_P24064.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10107_PS15_036_3648/PS10107_PS15_036_3648_P40448.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10107_PS15_107_4519/PS10107_PS15_107_4519_P35328.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10107_PS16_042_5408/PS10107_PS16_042_5408_P45568.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10107_PS18_028_10493/PS10107_PS18_028_10493_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10107_PS19_057_12407/PS10107_PS19_057_12407_P38400.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS15_050_3688/PS10109_PS15_050_3688_P17408.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS15_119_4494/PS10109_PS15_119_4494_P15360.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS16_033_5387/PS10109_PS16_033_5387_P04608.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS16_078_6360/PS10109_PS16_078_6360_P04096.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS18_046_10923/PS10109_PS18_046_10923_P10752.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS19_052_12386/PS10109_PS19_052_12386_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10110_PS15_094_4096/PS10110_PS15_094_4096_P13824.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10110_PS16_010_4996/PS10110_PS16_010_4996_P17408.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10110_PS16_071_5908/PS10110_PS16_071_5908_P53248.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10110_PS18_012_9932/PS10110_PS18_012_9932_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10110_PS21_014_13371/PS10110_PS21_014_13371_P15872.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_CL_DEV_001_3849/PS10117_CL_DEV_001_3849_P69632.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_CL_DEV_007_4816/PS10117_CL_DEV_007_4816_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_CL_DEV_012_6379/PS10117_CL_DEV_012_6379_P52736.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_CL_DEV_034_10496/PS10117_CL_DEV_034_10496_P41472.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_PS15_033_3422/PS10117_PS15_033_3422_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_PS15_081_4130/PS10117_PS15_081_4130_P41984.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10118_PS15_079_4300/PS10118_PS15_079_4300_P11264.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10118_PS16_024_5167/PS10118_PS16_024_5167_P35840.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS16_006_4977/PS10121_PS16_006_4977_P17920.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS16_063_5832/PS10121_PS16_063_5832_P17408.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS17_016_7554/PS10121_PS17_016_7554_P31232.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS17_051_9182/PS10121_PS17_051_9182_P33280.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS18_043_10922/PS10121_PS18_043_10922_P04608.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS19_048_12385/PS10121_PS19_048_12385_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS21_006_13257/PS10121_PS21_006_13257_P12288.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS15_087_4370/PS10122_PS15_087_4370_P14336.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS16_014_5191/PS10122_PS16_014_5191_P07168.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS16_069_6179/PS10122_PS16_069_6179_P27136.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS17_012_7904/PS10122_PS17_012_7904_P20480.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS18_037_10874/PS10122_PS18_037_10874_P16384.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS19_045_12354/PS10122_PS19_045_12354_P47104.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10123_PS16_021_5197/PS10123_PS16_021_5197_P51712.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10123_PS16_074_6192/PS10123_PS16_074_6192_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10126_PS18_026_10468/PS10126_PS18_026_10468_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10126_PS21_004_13198/PS10126_PS21_004_13198_P10752.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10127_PS15_106_4570/PS10127_PS15_106_4570_P13312.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10127_PS18_025_10443/PS10127_PS18_025_10443_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10127_PS20_002_12521/PS10127_PS20_002_12521_P13312.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10127_PS21_002_13263/PS10127_PS21_002_13263_P36352.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10128_PS16_082_6386/PS10128_PS16_082_6386_P34816.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10133_PS15_146_4817/PS10133_PS15_146_4817_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10133_PS18_002_9738/PS10133_PS18_002_9738_P04608.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10133_PS19_004_11224/PS10133_PS19_004_11224_P40960.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10134_PS15_136_4837/PS10134_PS15_136_4837_P16384.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10134_PS16_052_5652/PS10134_PS16_052_5652_P15872.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10136_CL_DEV_011_6380/PS10136_CL_DEV_011_6380_P59904.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10136_CL_DEV_035_10519/PS10136_CL_DEV_035_10519_P22528.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10137_PS17_002_6900/PS10137_PS17_002_6900_P44544.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10137_PS17_033_8465/PS10137_PS17_033_8465_P25088.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10137_PS18_008_9799/PS10137_PS18_008_9799_P28672.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10137_PS19_014_11547/PS10137_PS19_014_11547_P17408.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10139_PS18_006_9818/PS10139_PS18_006_9818_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10140_PS18_010_9939/PS10140_PS18_010_9939_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10140_PS21_021_13814/PS10140_PS21_021_13814_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10142_PS19_008_11543/PS10142_PS19_008_11543_P17920.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10147_PS17_047_9647/PS10147_PS17_047_9647_P35840.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10147_PS19_002_11282/PS10147_PS19_002_11282_P42496.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10147_PS21_007_13306/PS10147_PS21_007_13306_P30208.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10148_PS18_036_10866/PS10148_PS18_036_10866_P18432.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10148_PS19_036_12155/PS10148_PS19_036_12155_P18944.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10148_PS21_033_14103/PS10148_PS21_033_14103_P40960.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10149_PS18_022_10218/PS10149_PS18_022_10218_P04096.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10149_PS19_030_11909/PS10149_PS19_030_11909_P40960.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10149_PS21_028_14110/PS10149_PS21_028_14110_P45568.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10150_PS17_035_8537/PS10150_PS17_035_8537_P40448.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10150_PS19_025_11792/PS10150_PS19_025_11792_P37888.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10151_PS17_042_9351/PS10151_PS17_042_9351_P16896.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10151_PS19_058_12420/PS10151_PS19_058_12420_P11264.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10152_PS17_037_8556/PS10152_PS17_037_8556_P34816.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10152_PS19_056_12383/PS10152_PS19_056_12383_P05632.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10153_PS18_011_9893/PS10153_PS18_011_9893_P34304.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10154_PS19_031_12026/PS10154_PS19_031_12026_P22528.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10155_PS18_004_9706/PS10155_PS18_004_9706_P30720.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10159_PS17_039_8962/PS10159_PS17_039_8962_P25088.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10159_PS18_044_10940/PS10159_PS18_044_10940_P36352.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10159_PS19_059_12469/PS10159_PS19_059_12469_P28672.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10160_PS18_041_10910/PS10160_PS18_041_10910_P41472.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10160_PS19_053_12449/PS10160_PS19_053_12449_P25088.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10161_PS17_032_9263/PS10161_PS17_032_9263_P94720.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10161_PS18_042_10919/PS10161_PS18_042_10919_P10752.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10161_PS19_054_12399/PS10161_PS19_054_12399_P25600.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10162_PS18_015_10068/PS10162_PS18_015_10068_P33280.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10163_PS17_041_8859/PS10163_PS17_041_8859_P28672.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10163_PS18_040_10894/PS10163_PS18_040_10894_P29696.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10163_PS20_008_12526/PS10163_PS20_008_12526_P29184.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10164_PS20_004_12533/PS10164_PS20_004_12533_P07168.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10164_PS21_005_13210/PS10164_PS21_005_13210_P11776.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10166_CL_DEV_049_14205/PS10166_CL_DEV_049_14205_P19968.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10168_PS19_055_12417/PS10168_PS19_055_12417_P35840.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10168_PS21_035_14147/PS10168_PS21_035_14147_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10172_PS21_018_13443/PS10172_PS21_018_13443_P23040.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10175_PS19_027_11853/PS10175_PS19_027_11853_P52224.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10178_PS20_005_12549/PS10178_PS20_005_12549_P20480.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10179_PS20_022_13086/PS10179_PS20_022_13086_P12800.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10180_PS20_023_13106/PS10180_PS20_023_13106_P11776.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10181_PS19_038_12260/PS10181_PS19_038_12260_P11264.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10181_PS21_029_14142/PS10181_PS21_029_14142_P18432.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10182_PS20_007_12569/PS10182_PS20_007_12569_P47104.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10182_PS21_003_13188/PS10182_PS21_003_13188_P14336.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10184_PS20_019_13120/PS10184_PS20_019_13120_P32768.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10187_PS20_025_13119/PS10187_PS20_025_13119_P26112.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10187_PS21_031_14183/PS10187_PS21_031_14183_P36352.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10190_PS21_013_13380/PS10190_PS21_013_13380_P07680.7
"


Control_File_List=

region=LTP

for file in $LAG_PFiles
do
	echo "file path = $file"
	name=$(basename "$file")
	in_path=$(dirname "$file")/
	out_path=$(dirname "$file")/${region}/
	mkdir ${out_path}
	fname="${name%.*}"
	filename="$out_path$fname.control"
	raw_path="$in_path${fname}.7_lcm"
	waterfile="$in_path${fname}.7_w_lcm"



	echo ' $LCMODL' >> $filename
	echo " TITLE='$fname'" >> $filename #add parameters for title
	echo " FILBAS='$basis_set_path'" >> $filename
	echo " FILRAW='$raw_path'" >> $filename #may need full path
	echo " FILPS='$out_path$fname.PS'" >> $filename #name of ps file
	echo " FILCSV='$out_path$fname.csv'" >> $filename #name of csv file
	echo " LCSV = 11" >> $filename
	echo " FILCOO='$out_path$fname.COORD'" >> $filename #Coordinates file for plotting own data
	echo " LCOORD= 9" >> $filename

	echo " HZPPPM= 1.2777e+02" >> $filename # Field strength in HZ
	echo " DELTAT= 2.000e-04" >> $filename # Sample/dwell time (time between two consecutive points)
	echo " IAVERG= 1" >> $filename
	echo " NUNFIL= 4096" >> $filename # Number of data points
	
	# changed ICOLEN to 4
	echo " ICOLEN= 1" >> $filename
	echo " ICOLST= 1" >> $filename
	echo " IROWEN= 1" >> $filename
	echo " ISLICE= 1" >> $filename
	echo " NDCOLS= 1" >> $filename
	echo " NDROWS= 1" >> $filename
	echo " NDSLIC= 1" >> $filename # These three will always be one for single voxel data
	
	echo ' PPMEND= 0.2' >> $filename #Lower limit of analysis window (ppm)
	echo ' PPMST= 4.0' >> $filename #Upper limit of analysis window (ppm)
	
	
	echo " DOECC= T" >> $filename #Do eddy current correction, turn off if done in FID-A
	echo " FILH2O= '$waterfile'" >> $filename

##Phase Correction - Prior knowledge	
#	echo ' DEGZER=0' >> $filename # Default is 0
	echo ' SDDEGZ=3.' >> $filename 
#	echo ' DEGPPM=0' >> $filename # Default is 0
	echo ' SDDEGP=1' >> $filename

#Water scaling options
	
	echo ' DOWS= T' >> $filename #Do water scaling
	echo ' WCONC= '$wconc'' >> $filename #Conc of NMR visible water, default 35880
	echo ' ATTH2O='$atth2o'' >> $filename #Attenuation of water signal, default 0.7, leave at default for now
	#echo ' ATTMET=1.0' >> $filename #Attenuation of singlet specified in WSMET, default 1.0
	#echo ' WSMET=NAA' >> $filename #Water scaling metabolite, default CR
	#echo ' WSPPM=2.01' >> $filename #ppm of singlet of water scaling metabolite, default 3.027
	#echo ' N1HMET=3' >> $filename #Number of protons contributing to singled, default 3

#Output
	
#	echo ' NCOMBI=1' >> $filename #Number of combinations - left at default
#	echo ' CHCOMB =  >> $filename #Specify combinations - left at default

	echo " NAMREL= 'Cr'" >> $filename #gives ratio over Cr 

	echo ' NEACH= 50' >> $filename #Number of metabolites to generate individual plots for


	echo ' $END' >> $filename

	Control_File_List=("${Control_File_List} ${filename} ","")
done

 echo $Control_File_List >> ${list_of_files}