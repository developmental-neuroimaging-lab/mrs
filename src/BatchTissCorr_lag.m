%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Script to perform batch tissue correction on LCM .csv files

% Script is designed to analyze LCM .csv files saved in participant folders in a 
% larger study directory (example on line below) with the ID of the csv
% folder matching that of the segmented T1.
% Users/Documents/Study_Folder/Participant_Folder/LCM.csv

% Data is saved in Output_date folder in the directory that contains
% the participant folders. Output table is saved in .mat and .csv format
% (.csv file can be directly imported into SPSS for statistical analysis)

%% Important Settings

% Voxel Details
TE = 0.030; % In seconds. So a 30MS TE is 0.030 etc.
TR = 2; % In Seconds
% Water Concentration Set in LCModel
LCM_w_CONC=55510; % LCModel default is 35880, however, you can change it in the control script. Check the PS/PDF from LCModel or control file used if you are unsure. 

% Home location
HomeFolder = '/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag';

%% Large Voxel all averages
% Coregistration for voxel of interest - taken from Gannet CoReg Function 
coreg_file = '/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/MRS_struct_CoRegStandAlone.mat';
load(coreg_file);
ID_array=MRS_struct.metabfile;
region='LTP';

% can grab from bash or by doing 
% csvfiles = '/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS*/LTP/*.csv'; ls(files) 
csv_path={
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10006_PS14_120_3301/LTP/PS10006_PS14_120_3301_P27136.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10006_PS15_061_3976/LTP/PS10006_PS15_061_3976_P14336.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10006_PS15_138_4795/LTP/PS10006_PS15_138_4795_P56320.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10006_PS19_010_11360/LTP/PS10006_PS19_010_11360_P43520.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10007_PS14_121_3300/LTP/PS10007_PS14_121_3300_P21504.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10007_PS15_062_3975/LTP/PS10007_PS15_062_3975_P08192.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10007_PS15_139_4794/LTP/PS10007_PS15_139_4794_P50176.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10007_PS19_009_11359/LTP/PS10007_PS19_009_11359_P36352.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS14_079_3157/LTP/PS10008_PS14_079_3157_P19456.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS15_040_4076/LTP/PS10008_PS15_040_4076_P07680.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS16_001_4952/LTP/PS10008_PS16_001_4952_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS16_045_5887/LTP/PS10008_PS16_045_5887_P09728.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS17_018_8126/LTP/PS10008_PS17_018_8126_P39936.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10008_PS21_032_14127/LTP/PS10008_PS21_032_14127_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10009_PS15_002_3425/LTP/PS10009_PS15_002_3425_P08704.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10009_PS16_020_5171/LTP/PS10009_PS16_020_5171_P23552.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10009_PS16_072_6081/LTP/PS10009_PS16_072_6081_P13312.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10009_PS17_029_8421/LTP/PS10009_PS17_029_8421_P26624.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS15_014_3393/LTP/PS10010_PS15_014_3393_P10240.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS15_095_4246/LTP/PS10010_PS15_095_4246_P23040.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS16_004_4975/LTP/PS10010_PS16_004_4975_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS16_046_5890/LTP/PS10010_PS16_046_5890_P26112.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS17_008_8172/LTP/PS10010_PS17_008_8172_P37888.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10010_PS21_009_13287/LTP/PS10010_PS21_009_13287_P39936.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10014_PS15_112_4740/LTP/PS10014_PS15_112_4740_P35840.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10014_PS16_030_5675/LTP/PS10014_PS16_030_5675_P50176.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10014_PS18_001_9736/LTP/PS10014_PS18_001_9736_P10240.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10014_PS19_016_11553/LTP/PS10014_PS19_016_11553_P25600.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10014_PS21_019_13433/LTP/PS10014_PS21_019_13433_P07680.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10015_PS15_066_4093/LTP/PS10015_PS15_066_4093_P58880.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS15_032_3816/LTP/PS10020_PS15_032_3816_P27648.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS15_116_4665/LTP/PS10020_PS15_116_4665_P39424.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS16_028_5677/LTP/PS10020_PS16_028_5677_P61440.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS17_013_7959/LTP/PS10020_PS17_013_7959_P77312.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS18_027_10478/LTP/PS10020_PS18_027_10478_P32768.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS19_029_11873/LTP/PS10020_PS19_029_11873_P56320.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10020_PS21_027_13902/LTP/PS10020_PS21_027_13902_P24064.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10021_PS14_081_3156/LTP/PS10021_PS14_081_3156_P13312.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10021_PS15_045_3852/LTP/PS10021_PS15_045_3852_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10021_PS15_115_4744/LTP/PS10021_PS15_115_4744_P14336.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10021_PS17_011_7719/LTP/PS10021_PS17_011_7719_P54272.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS14_094_3155/LTP/PS10022_PS14_094_3155_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS15_049_3847/LTP/PS10022_PS15_049_3847_P55808.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS15_128_4739/LTP/PS10022_PS15_128_4739_P29184.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS16_036_5632/LTP/PS10022_PS16_036_5632_P10240.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS18_032_10805/LTP/PS10022_PS18_032_10805_P24064.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10022_PS19_040_12308/LTP/PS10022_PS19_040_12308_P04608.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10025_PS14_075_3118/LTP/PS10025_PS14_075_3118_P72192.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10025_PS15_120_4709/LTP/PS10025_PS15_120_4709_P13824.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10025_PS16_034_5518/LTP/PS10025_PS16_034_5518_P05632.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10025_PS18_024_10263/LTP/PS10025_PS18_024_10263_P57344.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS15_037_3773/LTP/PS10027_PS15_037_3773_P42496.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS15_114_4731/LTP/PS10027_PS15_114_4731_P09728.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS16_057_5697/LTP/PS10027_PS16_057_5697_P25600.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS17_019_7770/LTP/PS10027_PS17_019_7770_P54784.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS18_017_10155/LTP/PS10027_PS18_017_10155_P62976.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10027_PS19_022_11634/LTP/PS10027_PS19_022_11634_P30208.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10029_PS14_119_3258/LTP/PS10029_PS14_119_3258_P10752.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10032_PS14_144_3152/LTP/PS10032_PS14_144_3152_P22016.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10032_PS15_121_4625/LTP/PS10032_PS15_121_4625_P11264.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10032_PS16_037_5603/LTP/PS10032_PS16_037_5603_P05632.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10032_PS17_006_7650/LTP/PS10032_PS17_006_7650_P25088.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10032_PS18_021_10444/LTP/PS10032_PS18_021_10444_P11264.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10037_PS14_078_3143/LTP/PS10037_PS14_078_3143_P28672.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10037_PS15_140_4790/LTP/PS10037_PS15_140_4790_P19968.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10037_PS17_014_7512/LTP/PS10037_PS17_014_7512_P74752.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10037_PS18_016_10101/LTP/PS10037_PS18_016_10101_P04096.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10037_PS19_026_11808/LTP/PS10037_PS19_026_11808_P14848.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10042_PS14_111_3119/LTP/PS10042_PS14_111_3119_P79360.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10043_PS14_135_3298/LTP/PS10043_PS14_135_3298_P09728.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10043_PS15_068_3944/LTP/PS10043_PS15_068_3944_P20992.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10043_PS15_129_4831/LTP/PS10043_PS15_129_4831_P26624.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS14_071_3219/LTP/PS10044_PS14_071_3219_P33792.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS15_103_4150/LTP/PS10044_PS15_103_4150_P14336.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS16_019_5024/LTP/PS10044_PS16_019_5024_P29696.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS16_068_5966/LTP/PS10044_PS16_068_5966_P33792.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS17_036_9934/LTP/PS10044_PS17_036_9934_P27136.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS19_012_11420/LTP/PS10044_PS19_012_11420_P37888.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10044_PS21_011_13359/LTP/PS10044_PS21_011_13359_P14336.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10045_PS14_099_3284/LTP/PS10045_PS14_099_3284_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS15_003_3383/LTP/PS10046_PS15_003_3383_P58880.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS15_099_4176/LTP/PS10046_PS15_099_4176_P58880.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS16_023_5055/LTP/PS10046_PS16_023_5055_P39936.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS17_009_7456/LTP/PS10046_PS17_009_7456_P53248.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS19_005_11188/LTP/PS10046_PS19_005_11188_P57856.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS20_003_12527/LTP/PS10046_PS20_003_12527_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10046_PS21_011_13376/LTP/PS10046_PS21_011_13376_P52224.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10047_PS14_136_3445/LTP/PS10047_PS14_136_3445_P10240.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10047_PS15_101_4413/LTP/PS10047_PS15_101_4413_P58368.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10047_PS16_018_5260/LTP/PS10047_PS16_018_5260_P19968.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10049_PS14_117_3235/LTP/PS10049_PS14_117_3235_P07168.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10049_PS15_084_4104/LTP/PS10049_PS15_084_4104_P30720.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10049_PS16_053_5610/LTP/PS10049_PS16_053_5610_P20480.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10049_PS17_023_7962/LTP/PS10049_PS17_023_7962_P13824.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10053_PS14_134_3253/LTP/PS10053_PS14_134_3253_P17408.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10053_PS15_059_4105/LTP/PS10053_PS15_059_4105_P40960.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10053_PS16_009_4972/LTP/PS10053_PS16_009_4972_P26112.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10053_PS16_049_6353/LTP/PS10053_PS16_049_6353_P52224.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10053_PS19_006_11181/LTP/PS10053_PS19_006_11181_P31744.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS14_110_3205/LTP/PS10054_PS14_110_3205_P15360.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS15_057_3797/LTP/PS10054_PS15_057_3797_P16896.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS15_110_4634/LTP/PS10054_PS15_110_4634_P23040.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS16_032_5628/LTP/PS10054_PS16_032_5628_P36864.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS17_034_8491/LTP/PS10054_PS17_034_8491_P55808.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10054_PS18_039_10868/LTP/PS10054_PS18_039_10868_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10056_PS15_009_3498/LTP/PS10056_PS15_009_3498_P36864.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10056_PS15_098_4455/LTP/PS10056_PS15_098_4455_P05632.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10057_PS14_113_3445/LTP/PS10057_PS14_113_3445_P10240.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS15_004_3390/LTP/PS10059_PS15_004_3390_P29184.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS15_082_4270/LTP/PS10059_PS15_082_4270_P30208.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS16_011_5003/LTP/PS10059_PS16_011_5003_P24064.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS16_065_6017/LTP/PS10059_PS16_065_6017_P57344.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS17_026_8577/LTP/PS10059_PS17_026_8577_P66048.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10059_PS19_039_12271/LTP/PS10059_PS19_039_12271_P24576.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS14_123_3178/LTP/PS10061_PS14_123_3178_P24064.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS15_056_3969/LTP/PS10061_PS15_056_3969_P23040.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS15_125_4857/LTP/PS10061_PS15_125_4857_P47616.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS16_054_5673/LTP/PS10061_PS16_054_5673_P35840.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS17_015_7911/LTP/PS10061_PS17_015_7911_P67584.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS18_023_10363/LTP/PS10061_PS18_023_10363_P22016.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10061_PS19_028_11861/LTP/PS10061_PS19_028_11861_P30208.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10064_PS15_109_4436/LTP/PS10064_PS15_109_4436_P05632.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10064_PS16_085_6428/LTP/PS10064_PS16_085_6428_P50688.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS15_069_4227/LTP/PS10065_PS15_069_4227_P15360.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS16_002_4959/LTP/PS10065_PS16_002_4959_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS16_043_5809/LTP/PS10065_PS16_043_5809_P08192.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS17_007_7863/LTP/PS10065_PS17_007_7863_P66560.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS18_019_10215/LTP/PS10065_PS18_019_10215_P45568.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10065_PS19_034_12106/LTP/PS10065_PS19_034_12106_P15360.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10066_PS15_102_4190/LTP/PS10066_PS15_102_4190_P24576.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10066_PS16_012_4954/LTP/PS10066_PS16_012_4954_P08704.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10066_PS16_058_5925/LTP/PS10066_PS16_058_5925_P12288.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10067_PS16_055_6000/LTP/PS10067_PS16_055_6000_P24064.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10067_PS18_009_9837/LTP/PS10067_PS18_009_9837_P38912.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10068_PS15_001_3447/LTP/PS10068_PS15_001_3447_P12800.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10068_PS15_077_4320/LTP/PS10068_PS15_077_4320_P28160.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10069_PS15_071_3826/LTP/PS10069_PS15_071_3826_P10240.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10073_PS15_013_3461/LTP/PS10073_PS15_013_3461_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10073_PS15_086_4133/LTP/PS10073_PS15_086_4133_P18944.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10073_PS16_013_5071/LTP/PS10073_PS16_013_5071_P26112.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10073_PS16_050_5984/LTP/PS10073_PS16_050_5984_P08704.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10077_PS15_012_3547/LTP/PS10077_PS15_012_3547_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10077_PS15_123_4414/LTP/PS10077_PS15_123_4414_P07680.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10077_PS16_022_5245/LTP/PS10077_PS16_022_5245_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10077_PS16_066_6217/LTP/PS10077_PS16_066_6217_P13824.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS15_029_3652/LTP/PS10079_PS15_029_3652_P20992.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS15_108_4563/LTP/PS10079_PS15_108_4563_P11776.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS16_039_5423/LTP/PS10079_PS16_039_5423_P41984.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS16_079_6439/LTP/PS10079_PS16_079_6439_P22528.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS17_056_9607/LTP/PS10079_PS17_056_9607_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10079_PS20_006_12563/LTP/PS10079_PS20_006_12563_P11264.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS15_016_3935/LTP/PS10080_PS15_016_3935_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS15_144_4883/LTP/PS10080_PS15_144_4883_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS16_059_5644/LTP/PS10080_PS16_059_5644_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS17_027_8572/LTP/PS10080_PS17_027_8572_P32768.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS20_018_12680/LTP/PS10080_PS20_018_12680_P09728.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10080_PS21_015_13330/LTP/PS10080_PS21_015_13330_P38400.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10081_PS15_044_3719/LTP/PS10081_PS15_044_3719_P38400.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10081_PS15_104_4548/LTP/PS10081_PS15_104_4548_P62464.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10082_PS15_031_3820/LTP/PS10082_PS15_031_3820_P24064.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10082_PS16_027_5724/LTP/PS10082_PS16_027_5724_P33280.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS15_053_3810/LTP/PS10083_PS15_053_3810_P27136.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS15_113_4866/LTP/PS10083_PS15_113_4866_P30720.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS16_051_6059/LTP/PS10083_PS16_051_6059_P31744.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS17_022_7749/LTP/PS10083_PS17_022_7749_P67584.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS17_038_8549/LTP/PS10083_PS17_038_8549_P53248.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS18_033_10773/LTP/PS10083_PS18_033_10773_P15872.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10083_PS21_034_14201/LTP/PS10083_PS21_034_14201_P33792.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10085_PS15_025_3680/LTP/PS10085_PS15_025_3680_P33792.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10085_PS16_041_5373/LTP/PS10085_PS16_041_5373_P35840.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10085_PS17_050_9499/LTP/PS10085_PS17_050_9499_P43008.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10085_PS19_001_11288/LTP/PS10085_PS19_001_11288_P67072.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10085_PS20_011_12671/LTP/PS10085_PS20_011_12671_P14848.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS15_030_3629/LTP/PS10087_PS15_030_3629_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS15_111_4508/LTP/PS10087_PS15_111_4508_P17408.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS16_038_5432/LTP/PS10087_PS16_038_5432_P04096.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS16_077_6445/LTP/PS10087_PS16_077_6445_P38912.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS17_024_8138/LTP/PS10087_PS17_024_8138_P21504.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS18_031_10521/LTP/PS10087_PS18_031_10521_P40448.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS19_044_12347/LTP/PS10087_PS19_044_12347_P51712.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS20_030_13121/LTP/PS10087_PS20_030_13121_P41984.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10087_PS21_030_14120/LTP/PS10087_PS21_030_14120_P28160.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS15_047_3872/LTP/PS10088_PS15_047_3872_P09728.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS15_147_4828/LTP/PS10088_PS15_147_4828_P12800.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS16_060_5743/LTP/PS10088_PS16_060_5743_P14848.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS17_001_6924/LTP/PS10088_PS17_001_6924_P24576.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS18_005_9733/LTP/PS10088_PS18_005_9733_P12800.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS19_051_12344/LTP/PS10088_PS19_051_12344_P29696.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10088_PS20_031_13118/LTP/PS10088_PS20_031_13118_P19456.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10089_PS15_023_3679/LTP/PS10089_PS15_023_3679_P23552.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10089_PS15_097_4491/LTP/PS10089_PS15_097_4491_P29184.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10089_PS16_015_5404/LTP/PS10089_PS16_015_5404_P15872.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS15_015_3568/LTP/PS10090_PS15_015_3568_P54784.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS15_096_4440/LTP/PS10090_PS15_096_4440_P35328.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS16_008_5148/LTP/PS10090_PS16_008_5148_P45056.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS16_067_6193/LTP/PS10090_PS16_067_6193_P13824.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS17_031_8539/LTP/PS10090_PS17_031_8539_P52736.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS18_034_10840/LTP/PS10090_PS18_034_10840_P26624.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10090_PS20_021_13094/LTP/PS10090_PS20_021_13094_P08704.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10094_PS15_124_4453/LTP/PS10094_PS15_124_4453_P29696.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10094_PS16_044_5447/LTP/PS10094_PS16_044_5447_P54272.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10094_PS17_045_9591/LTP/PS10094_PS17_045_9591_P29696.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10096_PS15_131_4656/LTP/PS10096_PS15_131_4656_P46080.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10096_PS16_040_5499/LTP/PS10096_PS16_040_5499_P30720.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10096_PS17_054_9541/LTP/PS10096_PS17_054_9541_P59392.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10096_PS21_026_13815/LTP/PS10096_PS21_026_13815_P15872.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS15_048_3881/LTP/PS10097_PS15_048_3881_P16896.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS15_127_4710/LTP/PS10097_PS15_127_4710_P20992.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS16_026_5513/LTP/PS10097_PS16_026_5513_P04608.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS17_017_7772/LTP/PS10097_PS17_017_7772_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS18_020_10194/LTP/PS10097_PS18_020_10194_P17408.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10097_PS21_025_13774/LTP/PS10097_PS21_025_13774_P27136.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10098_PS15_118_4818/LTP/PS10098_PS15_118_4818_P14848.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10098_PS16_070_5924/LTP/PS10098_PS16_070_5924_P05632.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10104_PS15_042_4058/LTP/PS10104_PS15_042_4058_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10104_PS16_003_5205/LTP/PS10104_PS16_003_5205_P07680.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10104_PS16_081_6390/LTP/PS10104_PS16_081_6390_P10752.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10104_PS17_028_8207/LTP/PS10104_PS17_028_8207_P51200.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10104_PS19_019_11492/LTP/PS10104_PS19_019_11492_P24064.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10107_PS15_036_3648/LTP/PS10107_PS15_036_3648_P40448.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10107_PS15_107_4519/LTP/PS10107_PS15_107_4519_P35328.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10107_PS16_042_5408/LTP/PS10107_PS16_042_5408_P45568.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10107_PS18_028_10493/LTP/PS10107_PS18_028_10493_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10107_PS19_057_12407/LTP/PS10107_PS19_057_12407_P38400.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS15_050_3688/LTP/PS10109_PS15_050_3688_P17408.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS15_119_4494/LTP/PS10109_PS15_119_4494_P15360.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS16_033_5387/LTP/PS10109_PS16_033_5387_P04608.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS16_078_6360/LTP/PS10109_PS16_078_6360_P04096.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS18_046_10923/LTP/PS10109_PS18_046_10923_P10752.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10109_PS19_052_12386/LTP/PS10109_PS19_052_12386_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10110_PS15_094_4096/LTP/PS10110_PS15_094_4096_P13824.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10110_PS16_010_4996/LTP/PS10110_PS16_010_4996_P17408.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10110_PS16_071_5908/LTP/PS10110_PS16_071_5908_P53248.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10110_PS18_012_9932/LTP/PS10110_PS18_012_9932_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10110_PS21_014_13371/LTP/PS10110_PS21_014_13371_P15872.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_CL_DEV_001_3849/LTP/PS10117_CL_DEV_001_3849_P69632.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_CL_DEV_007_4816/LTP/PS10117_CL_DEV_007_4816_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_CL_DEV_012_6379/LTP/PS10117_CL_DEV_012_6379_P52736.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_CL_DEV_034_10496/LTP/PS10117_CL_DEV_034_10496_P41472.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_PS15_033_3422/LTP/PS10117_PS15_033_3422_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10117_PS15_081_4130/LTP/PS10117_PS15_081_4130_P41984.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10118_PS15_079_4300/LTP/PS10118_PS15_079_4300_P11264.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10118_PS16_024_5167/LTP/PS10118_PS16_024_5167_P35840.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS16_006_4977/LTP/PS10121_PS16_006_4977_P17920.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS16_063_5832/LTP/PS10121_PS16_063_5832_P17408.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS17_016_7554/LTP/PS10121_PS17_016_7554_P31232.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS17_051_9182/LTP/PS10121_PS17_051_9182_P33280.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS18_043_10922/LTP/PS10121_PS18_043_10922_P04608.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS19_048_12385/LTP/PS10121_PS19_048_12385_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10121_PS21_006_13257/LTP/PS10121_PS21_006_13257_P12288.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS15_087_4370/LTP/PS10122_PS15_087_4370_P14336.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS16_014_5191/LTP/PS10122_PS16_014_5191_P07168.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS16_069_6179/LTP/PS10122_PS16_069_6179_P27136.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS17_012_7904/LTP/PS10122_PS17_012_7904_P20480.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS18_037_10874/LTP/PS10122_PS18_037_10874_P16384.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10122_PS19_045_12354/LTP/PS10122_PS19_045_12354_P47104.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10123_PS16_021_5197/LTP/PS10123_PS16_021_5197_P51712.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10123_PS16_074_6192/LTP/PS10123_PS16_074_6192_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10126_PS18_026_10468/LTP/PS10126_PS18_026_10468_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10126_PS21_004_13198/LTP/PS10126_PS21_004_13198_P10752.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10127_PS15_106_4570/LTP/PS10127_PS15_106_4570_P13312.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10127_PS18_025_10443/LTP/PS10127_PS18_025_10443_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10127_PS20_002_12521/LTP/PS10127_PS20_002_12521_P13312.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10127_PS21_002_13263/LTP/PS10127_PS21_002_13263_P36352.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10128_PS16_082_6386/LTP/PS10128_PS16_082_6386_P34816.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10133_PS15_146_4817/LTP/PS10133_PS15_146_4817_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10133_PS18_002_9738/LTP/PS10133_PS18_002_9738_P04608.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10133_PS19_004_11224/LTP/PS10133_PS19_004_11224_P40960.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10134_PS15_136_4837/LTP/PS10134_PS15_136_4837_P16384.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10134_PS16_052_5652/LTP/PS10134_PS16_052_5652_P15872.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10136_CL_DEV_011_6380/LTP/PS10136_CL_DEV_011_6380_P59904.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10136_CL_DEV_035_10519/LTP/PS10136_CL_DEV_035_10519_P22528.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10137_PS17_002_6900/LTP/PS10137_PS17_002_6900_P44544.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10137_PS17_033_8465/LTP/PS10137_PS17_033_8465_P25088.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10137_PS18_008_9799/LTP/PS10137_PS18_008_9799_P28672.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10137_PS19_014_11547/LTP/PS10137_PS19_014_11547_P17408.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10139_PS18_006_9818/LTP/PS10139_PS18_006_9818_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10140_PS18_010_9939/LTP/PS10140_PS18_010_9939_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10140_PS21_021_13814/LTP/PS10140_PS21_021_13814_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10142_PS19_008_11543/LTP/PS10142_PS19_008_11543_P17920.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10147_PS17_047_9647/LTP/PS10147_PS17_047_9647_P35840.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10147_PS19_002_11282/LTP/PS10147_PS19_002_11282_P42496.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10147_PS21_007_13306/LTP/PS10147_PS21_007_13306_P30208.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10148_PS18_036_10866/LTP/PS10148_PS18_036_10866_P18432.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10148_PS19_036_12155/LTP/PS10148_PS19_036_12155_P18944.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10148_PS21_033_14103/LTP/PS10148_PS21_033_14103_P40960.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10149_PS18_022_10218/LTP/PS10149_PS18_022_10218_P04096.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10149_PS19_030_11909/LTP/PS10149_PS19_030_11909_P40960.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10149_PS21_028_14110/LTP/PS10149_PS21_028_14110_P45568.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10150_PS17_035_8537/LTP/PS10150_PS17_035_8537_P40448.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10150_PS19_025_11792/LTP/PS10150_PS19_025_11792_P37888.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10151_PS17_042_9351/LTP/PS10151_PS17_042_9351_P16896.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10151_PS19_058_12420/LTP/PS10151_PS19_058_12420_P11264.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10152_PS17_037_8556/LTP/PS10152_PS17_037_8556_P34816.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10152_PS19_056_12383/LTP/PS10152_PS19_056_12383_P05632.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10153_PS18_011_9893/LTP/PS10153_PS18_011_9893_P34304.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10154_PS19_031_12026/LTP/PS10154_PS19_031_12026_P22528.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10155_PS18_004_9706/LTP/PS10155_PS18_004_9706_P30720.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10159_PS17_039_8962/LTP/PS10159_PS17_039_8962_P25088.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10159_PS18_044_10940/LTP/PS10159_PS18_044_10940_P36352.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10159_PS19_059_12469/LTP/PS10159_PS19_059_12469_P28672.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10160_PS18_041_10910/LTP/PS10160_PS18_041_10910_P41472.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10160_PS19_053_12449/LTP/PS10160_PS19_053_12449_P25088.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10161_PS17_032_9263/LTP/PS10161_PS17_032_9263_P94720.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10161_PS18_042_10919/LTP/PS10161_PS18_042_10919_P10752.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10161_PS19_054_12399/LTP/PS10161_PS19_054_12399_P25600.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10162_PS18_015_10068/LTP/PS10162_PS18_015_10068_P33280.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10163_PS17_041_8859/LTP/PS10163_PS17_041_8859_P28672.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10163_PS18_040_10894/LTP/PS10163_PS18_040_10894_P29696.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10163_PS20_008_12526/LTP/PS10163_PS20_008_12526_P29184.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10164_PS20_004_12533/LTP/PS10164_PS20_004_12533_P07168.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10164_PS21_005_13210/LTP/PS10164_PS21_005_13210_P11776.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10166_CL_DEV_049_14205/LTP/PS10166_CL_DEV_049_14205_P19968.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10168_PS19_055_12417/LTP/PS10168_PS19_055_12417_P35840.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10168_PS21_035_14147/LTP/PS10168_PS21_035_14147_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10172_PS21_018_13443/LTP/PS10172_PS21_018_13443_P23040.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10175_PS19_027_11853/LTP/PS10175_PS19_027_11853_P52224.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10178_PS20_005_12549/LTP/PS10178_PS20_005_12549_P20480.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10179_PS20_022_13086/LTP/PS10179_PS20_022_13086_P12800.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10180_PS20_023_13106/LTP/PS10180_PS20_023_13106_P11776.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10181_PS19_038_12260/LTP/PS10181_PS19_038_12260_P11264.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10181_PS21_029_14142/LTP/PS10181_PS21_029_14142_P18432.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10182_PS20_007_12569/LTP/PS10182_PS20_007_12569_P47104.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10182_PS21_003_13188/LTP/PS10182_PS21_003_13188_P14336.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10184_PS20_019_13120/LTP/PS10184_PS20_019_13120_P32768.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10187_PS20_025_13119/LTP/PS10187_PS20_025_13119_P26112.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10187_PS21_031_14183/LTP/PS10187_PS21_031_14183_P36352.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_lag/PS10190_PS21_013_13380/LTP/PS10190_PS21_013_13380_P07680.csv'
};


% Loop that reads in .csv file and MRS_struct and runs in through LCM_Met_Quant


j = [];
for p = 1:numel(csv_path)   
    
    % You will get an error " Warning: Table variable names were modified to make them valid MATLAB identifiers. The original names are saved in the VariableDescriptions property."
    % This is because of all the symbols in the LCModel output
    LCM_Table = readtable(csv_path{p}); %reads in LCM .csv file
    LCM_Table.Row = {csv_path{p}}; %changes first variable to be LCM file ID
    LCM_Table.Properties.VariableNames{'Row'} = 'FullPath'; %adds LCM file ID to table
    LCM_Table.Properties.VariableNames{'Col'} = 'File_ID'; %adds LCM file ID to table

    
    % MD use file name to identify row for inclusion
    % Identifies the row that the metabolite file 
    target_name=csv_path{p};
    target_name=split(target_name,"/");
    target_length=numel(target_name);
    target_name=target_name(target_length);
    target_name=split(target_name,".");
    target_name=target_name(1);
    row_no=contains(ID_array,target_name);
    row_no=find(row_no);
    LCM_Table.File_ID=target_name;
    
    % Add name of T1 nifti and PFile that were used
    LCM_Table.PFile_Seg= MRS_struct.metabfile(row_no);
    LCM_Table.T1_nii = MRS_struct.mask.vox1.T1image(row_no);
    LCM_Table.MRS_mask = MRS_struct.mask.vox1.outfile(row_no);
    
    % Add tissue fractions to the individual LCModel table 
    % These are used to tissue correct and called in the function
    % You may need to adapt the MRS_struct... naming depending on your defaults
    LCM_Table.fGM = MRS_struct.out.vox1.tissue.fGM(row_no);
    LCM_Table.fWM = MRS_struct.out.vox1.tissue.fWM(row_no);
    LCM_Table.fCSF = MRS_struct.out.vox1.tissue.fCSF(row_no);

    % Run LCM_Met_Quant and save output in table
    LCM_Met_Quant_MD_QCd(LCM_Table,TE,TR,LCM_w_CONC);
    LCM_CorrectedTable = [j;ans]; % adds new LCM_Met_Quant output to existing output table
    j = LCM_CorrectedTable;
end

%% Returns to study folder, makes output folder and output.csv file

cd(HomeFolder)
OutputDir = (strcat('Output_',date));
mkdir(OutputDir)
cd(strcat(HomeFolder,strcat('/',OutputDir)))
writetable(LCM_CorrectedTable,strcat(region,'_LCM_CorrectedTable_',strcat(datestr(now,'mm-dd-yyyy-HH-MM'),'.csv')))
save LCM_CorrectedTable.mat

% SPM12 is not compatible with the 'writetable' function and will need to
% (sometimes)
% be removed from your path for this script to work
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

