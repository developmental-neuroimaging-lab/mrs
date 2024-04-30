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
HomeFolder = '/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg';

%% Large Voxel all averages
% Coregistration for voxel of interest - taken from Gannet CoReg Function 
coreg_file = '/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/MRS_struct_CoRegStandAlone.mat';
load(coreg_file);
ID_array=MRS_struct.metabfile;
region='ACC';

% can grab from bash or by doing 
% csvfiles = '/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS*/ACC/*.csv'; ls(files) 
csv_path={
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10001_PS14_006_2058/ACC/PS10001_PS14_006_2058_P39936.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10006_PS14_053_2563/ACC/PS10006_PS14_053_2563_P17408.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10007_PS14_054_2562/ACC/PS10007_PS14_054_2562_P11264.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10008_PS14_046_2386/ACC/PS10008_PS14_046_2386_P13824.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10009_PS14_070_2651/ACC/PS10009_PS14_070_2651_P31744.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10010_PS14_056_2647/ACC/PS10010_PS14_056_2647_P09728.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10012_PS14_009_2165/ACC/PS10012_PS14_009_2165_P08192.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10014_PS14_014_2259/ACC/PS10014_PS14_014_2259_P22528.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10014_PS14_076_3008/ACC/PS10014_PS14_076_3008_P23552.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10015_PS14_015_2504/ACC/PS10015_PS14_015_2504_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10020_PS14_017_2274/ACC/PS10020_PS14_017_2274_P29696.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10020_PS14_073_3069/ACC/PS10020_PS14_073_3069_P35328.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10021_PS14_018_2275/ACC/PS10021_PS14_018_2275_P35840.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10022_PS14_019_2429/ACC/PS10022_PS14_019_2429_P11264.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10024_PS14_022_2369/ACC/PS10024_PS14_022_2369_P45568.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10025_PS14_021_2314/ACC/PS10025_PS14_021_2314_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10027_PS14_027_2296/ACC/PS10027_PS14_027_2296_P40448.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10027_PS14_074_3062/ACC/PS10027_PS14_074_3062_P43520.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10028_PS14_028_2346/ACC/PS10028_PS14_028_2346_P36352.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10029_PS14_026_2527/ACC/PS10029_PS14_026_2527_P08192.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10032_PS14_029_2426/ACC/PS10032_PS14_029_2426_P23552.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10039_PS14_036_2609/ACC/PS10039_PS14_036_2609_P37888.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10042_PS14_039_2420/ACC/PS10042_PS14_039_2420_P50688.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10043_PS14_043_2516/ACC/PS10043_PS14_043_2516_P19456.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10044_PS14_041_2398/ACC/PS10044_PS14_041_2398_P31744.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10045_PS14_042_2514/ACC/PS10045_PS14_042_2514_P05632.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10046_PS14_040_2652/ACC/PS10046_PS14_040_2652_P38400.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10047_PS14_044_2576/ACC/PS10047_PS14_044_2576_P21504.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10048_PS14_045_2512/ACC/PS10048_PS14_045_2512_P34304.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10049_PS14_047_2498/ACC/PS10049_PS14_047_2498_P11776.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10051_PS14_050_2510/ACC/PS10051_PS14_050_2510_P21504.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10056_PS14_058_2723/ACC/PS10056_PS14_058_2723_P05632.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10057_PS14_057_2579/ACC/PS10057_PS14_057_2579_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10058_PS14_059_2654/ACC/PS10058_PS14_059_2654_P15872.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10059_PS14_068_2668/ACC/PS10059_PS14_068_2668_P41984.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10061_PS14_060_2574/ACC/PS10061_PS14_060_2574_P11264.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10062_PS14_065_2675/ACC/PS10062_PS14_065_2675_P17408.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10064_PS14_067_2600/ACC/PS10064_PS14_067_2600_P27648.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10065_PS14_066_2658/ACC/PS10065_PS14_066_2658_P08192.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10067_PS16_005_5032/ACC/PS10067_PS16_005_5032_P25600.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10068_PS14_069_2676/ACC/PS10068_PS14_069_2676_P22528.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10070_PS14_083_2933/ACC/PS10070_PS14_083_2933_P11264.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10073_PS14_086_2838/ACC/PS10073_PS14_086_2838_P12288.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10077_PS14_091_2837/ACC/PS10077_PS14_091_2837_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10078_PS14_090_2898/ACC/PS10078_PS14_090_2898_P07680.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10080_PS14_092_2907/ACC/PS10080_PS14_092_2907_P27648.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10082_PS14_097_3009/ACC/PS10082_PS14_097_3009_P29184.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10083_PS14_098_2980/ACC/PS10083_PS14_098_2980_P47104.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10086_PS14_101_3039/ACC/PS10086_PS14_101_3039_P24064.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10087_PS14_105_2940/ACC/PS10087_PS14_105_2940_P15872.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10088_PS14_103_3036/ACC/PS10088_PS14_103_3036_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10089_PS14_104_2918/ACC/PS10089_PS14_104_2918_P13824.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10089_PS16_015_5404/ACC/PS10089_PS16_015_5404_P12800.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10090_PS14_102_2920/ACC/PS10090_PS14_102_2920_P23040.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10094_PS14_106_3690/ACC/PS10094_PS14_106_3690_P14336.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10096_PS14_115_3154/ACC/PS10096_PS14_115_3154_P34816.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10097_PS14_080_3158/ACC/PS10097_PS14_080_3158_P26624.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10098_PS14_118_3001/ACC/PS10098_PS14_118_3001_P37376.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10104_PS14_129_3089/ACC/PS10104_PS14_129_3089_P26112.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10106_PS14_131_3147/ACC/PS10106_PS14_131_3147_P54784.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10107_PS14_132_3019/ACC/PS10107_PS14_132_3019_P16384.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10109_PS14_138_3031/ACC/PS10109_PS14_138_3031_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10110_PS14_139_3173/ACC/PS10110_PS14_139_3173_P26624.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10114_PS14_145_3213/ACC/PS10114_PS14_145_3213_P46080.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10116_PS18_1537_10238/ACC/PS10116_PS18_1537_10238_P27648.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_CL_DEV_007_4816/ACC/PS10117_CL_DEV_007_4816_P04096.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_CL_DEV_015_6899/ACC/PS10117_CL_DEV_015_6899_P33280.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_CL_DEV_020_7942/ACC/PS10117_CL_DEV_020_7942_P45568.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_CL_DEV_022_8528/ACC/PS10117_CL_DEV_022_8528_P47104.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_Cl_DEV_024_9622/ACC/PS10117_Cl_DEV_024_9622_P36864.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_PS15_010_3244/ACC/PS10117_PS15_010_3244_P03584.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10118_PS15_017_3419/ACC/PS10118_PS15_017_3419_P16896.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10121_PS15_020_3361/ACC/PS10121_PS15_020_3361_P08704.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10121_PS15_020_3361/ACC/PS10121_PS15_020_3361_P12800.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10122_PS15_021_3324/ACC/PS10122_PS15_021_3324_P74752.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10123_PS15_022_3512/ACC/PS10123_PS15_022_3512_P40960.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10128_PS15_046_3717/ACC/PS10128_PS15_046_3717_P22528.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10131_PS16_084_6529/ACC/PS10131_PS16_084_6529_P34816.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10132_PS15_072_3897/ACC/PS10132_PS15_072_3897_P36864.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10133_PS15_085_3960/ACC/PS10133_PS15_085_3960_P26624.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10134_CL_DEV_002_3959/ACC/PS10134_CL_DEV_002_3959_P18432.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10135_PS16_025_5247/ACC/PS10135_PS16_025_5247_P19968.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10136_CL_DEV_014_6898/ACC/PS10136_CL_DEV_014_6898_P27136.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10136_CL_DEV_021_7943/ACC/PS10136_CL_DEV_021_7943_P53248.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10136_CL_DEV_023_8529/ACC/PS10136_CL_DEV_023_8529_P53248.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10136_Cl_DEV_025_9623/ACC/PS10136_Cl_DEV_025_9623_P43008.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10137_PS16_061_5746/ACC/PS10137_PS16_061_5746_P40448.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10140_PS1064-10-1_5210/ACC/PS10140_PS1064-10-1_5210_P51712.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10141_PS0969-10-1_5271/ACC/PS10141_PS0969-10-1_5271_P12288.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10142_PS1120-10-1_5303/ACC/PS10142_PS1120-10-1_5303_P38400.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10143_PS0935-10-1_5316/ACC/PS10143_PS0935-10-1_5316_P14336.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10144_PS1168-10-1_5422/ACC/PS10144_PS1168-10-1_5422_P36864.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10147_PS1183-10-1_5847/ACC/PS10147_PS1183-10-1_5847_P28672.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10147_PS1183-10-1_5847/ACC/PS10147_PS1183-10-1_5847_P29696.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10148_PS0143-10-1_6078/ACC/PS10148_PS0143-10-1_6078_P30208.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10149_PS0536-10-1_6187/ACC/PS10149_PS0536-10-1_6187_P76800.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10150_PS0548-10-1_6203/ACC/PS10150_PS0548-10-1_6203_P59904.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10151_PS1184-10-1_6321/ACC/PS10151_PS1184-10-1_6321_P14336.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10153_PS1395-10-1_6780/ACC/PS10153_PS1395-10-1_6780_P55808.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10155_PS1313-10-1_6440/ACC/PS10155_PS1313-10-1_6440_P28160.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10156_PS1432-10-1_6910/ACC/PS10156_PS1432-10-1_6910_P37888.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10157_PS1360-10-1_6974/ACC/PS10157_PS1360-10-1_6974_P43520.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10164_PS17_0434101_9614/ACC/PS10164_PS17_0434101_9614_P47616.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10165_PS17_1575101_9600/ACC/PS10165_PS17_1575101_9600_P10240.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10166_CL_DEV_033_10495/ACC/PS10166_CL_DEV_033_10495_P36352.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10167_PS18_014_9892/ACC/PS10167_PS18_014_9892_P26112.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10168_PS18_013_9869/ACC/PS10168_PS18_013_9869_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10169_PS17_8094101_9871/ACC/PS10169_PS17_8094101_9871_P20480.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10171_PS18_1558_9967/ACC/PS10171_PS18_1558_9967_P27648.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10173_PS18_1519_10117/ACC/PS10173_PS18_1519_10117_P12800.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10174_PS18_1549_10170/ACC/PS10174_PS18_1549_10170_P38400.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10176_PS18_1554_10292/ACC/PS10176_PS18_1554_10292_P28672.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10178_PS18_1497_10507/ACC/PS10178_PS18_1497_10507_P14336.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10179_PS18_5157_10554/ACC/PS10179_PS18_5157_10554_P18944.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10181_PS18_1567_10879/ACC/PS10181_PS18_1567_10879_P24064.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10182_PS18_1601_10920/ACC/PS10182_PS18_1601_10920_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10182_PS18_1601_10920/ACC/PS10182_PS18_1601_10920_P06144.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10183_PS18_1608_10942/ACC/PS10183_PS18_1608_10942_P12288.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10184_PS18_1616_11008/ACC/PS10184_PS18_1616_11008_P06656.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10186_PS18_1605_11026/ACC/PS10186_PS18_1605_11026_P31744.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10187_PS18_1614_11019/ACC/PS10187_PS18_1614_11019_P17920.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10188_PS19_1214_11335/ACC/PS10188_PS19_1214_11335_P05120.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10189_PS19_1261_11299/ACC/PS10189_PS19_1261_11299_P23040.csv'
'/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10190_PS19_0077_11448/ACC/PS10190_PS19_0077_11448_P44032.csv'
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

