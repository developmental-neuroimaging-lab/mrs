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

ACG_PFiles="
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10001_PS14_006_2058/PS10001_PS14_006_2058_P39936.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10006_PS14_053_2563/PS10006_PS14_053_2563_P17408.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10007_PS14_054_2562/PS10007_PS14_054_2562_P11264.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10008_PS14_046_2386/PS10008_PS14_046_2386_P13824.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10009_PS14_070_2651/PS10009_PS14_070_2651_P31744.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10010_PS14_056_2647/PS10010_PS14_056_2647_P09728.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10012_PS14_009_2165/PS10012_PS14_009_2165_P08192.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10014_PS14_014_2259/PS10014_PS14_014_2259_P22528.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10014_PS14_076_3008/PS10014_PS14_076_3008_P23552.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10015_PS14_015_2504/PS10015_PS14_015_2504_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10020_PS14_017_2274/PS10020_PS14_017_2274_P29696.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10020_PS14_073_3069/PS10020_PS14_073_3069_P35328.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10021_PS14_018_2275/PS10021_PS14_018_2275_P35840.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10022_PS14_019_2429/PS10022_PS14_019_2429_P11264.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10024_PS14_022_2369/PS10024_PS14_022_2369_P45568.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10025_PS14_021_2314/PS10025_PS14_021_2314_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10027_PS14_027_2296/PS10027_PS14_027_2296_P40448.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10027_PS14_074_3062/PS10027_PS14_074_3062_P43520.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10028_PS14_028_2346/PS10028_PS14_028_2346_P36352.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10029_PS14_026_2527/PS10029_PS14_026_2527_P08192.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10032_PS14_029_2426/PS10032_PS14_029_2426_P23552.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10039_PS14_036_2609/PS10039_PS14_036_2609_P37888.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10042_PS14_039_2420/PS10042_PS14_039_2420_P50688.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10043_PS14_043_2516/PS10043_PS14_043_2516_P19456.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10044_PS14_041_2398/PS10044_PS14_041_2398_P31744.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10045_PS14_042_2514/PS10045_PS14_042_2514_P05632.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10046_PS14_040_2652/PS10046_PS14_040_2652_P38400.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10047_PS14_044_2576/PS10047_PS14_044_2576_P21504.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10048_PS14_045_2512/PS10048_PS14_045_2512_P34304.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10049_PS14_047_2498/PS10049_PS14_047_2498_P11776.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10051_PS14_050_2510/PS10051_PS14_050_2510_P21504.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10056_PS14_058_2723/PS10056_PS14_058_2723_P05632.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10057_PS14_057_2579/PS10057_PS14_057_2579_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10058_PS14_059_2654/PS10058_PS14_059_2654_P15872.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10059_PS14_068_2668/PS10059_PS14_068_2668_P41984.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10061_PS14_060_2574/PS10061_PS14_060_2574_P11264.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10062_PS14_065_2675/PS10062_PS14_065_2675_P17408.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10064_PS14_067_2600/PS10064_PS14_067_2600_P27648.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10065_PS14_066_2658/PS10065_PS14_066_2658_P08192.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10067_PS16_005_5032/PS10067_PS16_005_5032_P25600.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10068_PS14_069_2676/PS10068_PS14_069_2676_P22528.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10070_PS14_083_2933/PS10070_PS14_083_2933_P11264.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10073_PS14_086_2838/PS10073_PS14_086_2838_P12288.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10077_PS14_091_2837/PS10077_PS14_091_2837_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10078_PS14_090_2898/PS10078_PS14_090_2898_P07680.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10080_PS14_092_2907/PS10080_PS14_092_2907_P27648.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10082_PS14_097_3009/PS10082_PS14_097_3009_P29184.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10083_PS14_098_2980/PS10083_PS14_098_2980_P47104.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10086_PS14_101_3039/PS10086_PS14_101_3039_P24064.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10087_PS14_105_2940/PS10087_PS14_105_2940_P15872.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10088_PS14_103_3036/PS10088_PS14_103_3036_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10089_PS14_104_2918/PS10089_PS14_104_2918_P13824.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10089_PS16_015_5404/PS10089_PS16_015_5404_P12800.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10090_PS14_102_2920/PS10090_PS14_102_2920_P23040.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10094_PS14_106_3690/PS10094_PS14_106_3690_P14336.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10096_PS14_115_3154/PS10096_PS14_115_3154_P34816.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10097_PS14_080_3158/PS10097_PS14_080_3158_P26624.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10098_PS14_118_3001/PS10098_PS14_118_3001_P37376.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10104_PS14_129_3089/PS10104_PS14_129_3089_P26112.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10106_PS14_131_3147/PS10106_PS14_131_3147_P54784.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10107_PS14_132_3019/PS10107_PS14_132_3019_P16384.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10109_PS14_138_3031/PS10109_PS14_138_3031_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10110_PS14_139_3173/PS10110_PS14_139_3173_P26624.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10114_PS14_145_3213/PS10114_PS14_145_3213_P46080.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10116_PS18_1537_10238/PS10116_PS18_1537_10238_P27648.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_CL_DEV_007_4816/PS10117_CL_DEV_007_4816_P04096.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_CL_DEV_007_4816/PS10117_CL_DEV_007_4816_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_CL_DEV_015_6899/PS10117_CL_DEV_015_6899_P33280.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_CL_DEV_020_7942/PS10117_CL_DEV_020_7942_P45568.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_CL_DEV_022_8528/PS10117_CL_DEV_022_8528_P47104.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_Cl_DEV_024_9622/PS10117_Cl_DEV_024_9622_P36864.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10117_PS15_010_3244/PS10117_PS15_010_3244_P03584.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10118_PS15_017_3419/PS10118_PS15_017_3419_P16896.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10121_PS15_020_3361/PS10121_PS15_020_3361_P12800.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10121_PS15_020_3361/PS10121_PS15_020_3361_P08704.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10122_PS15_021_3324/PS10122_PS15_021_3324_P74752.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10123_PS15_022_3512/PS10123_PS15_022_3512_P40960.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10128_PS15_046_3717/PS10128_PS15_046_3717_P22528.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10131_PS16_084_6529/PS10131_PS16_084_6529_P34816.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10132_PS15_072_3897/PS10132_PS15_072_3897_P36864.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10133_PS15_085_3960/PS10133_PS15_085_3960_P26624.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10134_CL_DEV_002_3959/PS10134_CL_DEV_002_3959_P18432.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10135_PS16_025_5247/PS10135_PS16_025_5247_P19968.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10136_CL_DEV_014_6898/PS10136_CL_DEV_014_6898_P27136.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10136_CL_DEV_021_7943/PS10136_CL_DEV_021_7943_P53248.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10136_CL_DEV_023_8529/PS10136_CL_DEV_023_8529_P53248.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10136_Cl_DEV_025_9623/PS10136_Cl_DEV_025_9623_P43008.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10137_PS16_061_5746/PS10137_PS16_061_5746_P40448.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10140_PS1064-10-1_5210/PS10140_PS1064-10-1_5210_P51712.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10141_PS0969-10-1_5271/PS10141_PS0969-10-1_5271_P12288.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10142_PS1120-10-1_5303/PS10142_PS1120-10-1_5303_P38400.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10143_PS0935-10-1_5316/PS10143_PS0935-10-1_5316_P14336.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10144_PS1168-10-1_5422/PS10144_PS1168-10-1_5422_P36864.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10147_PS1183-10-1_5847/PS10147_PS1183-10-1_5847_P29696.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10147_PS1183-10-1_5847/PS10147_PS1183-10-1_5847_P28672.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10148_PS0143-10-1_6078/PS10148_PS0143-10-1_6078_P30208.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10149_PS0536-10-1_6187/PS10149_PS0536-10-1_6187_P76800.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10150_PS0548-10-1_6203/PS10150_PS0548-10-1_6203_P59904.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10151_PS1184-10-1_6321/PS10151_PS1184-10-1_6321_P14336.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10153_PS1395-10-1_6780/PS10153_PS1395-10-1_6780_P55808.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10155_PS1313-10-1_6440/PS10155_PS1313-10-1_6440_P28160.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10156_PS1432-10-1_6910/PS10156_PS1432-10-1_6910_P37888.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10157_PS1360-10-1_6974/PS10157_PS1360-10-1_6974_P43520.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10164_PS17_0434101_9614/PS10164_PS17_0434101_9614_P47616.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10165_PS17_1575101_9600/PS10165_PS17_1575101_9600_P10240.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10166_CL_DEV_033_10495/PS10166_CL_DEV_033_10495_P36352.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10167_PS18_014_9892/PS10167_PS18_014_9892_P26112.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10168_PS18_013_9869/PS10168_PS18_013_9869_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10169_PS17_8094101_9871/PS10169_PS17_8094101_9871_P20480.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10171_PS18_1558_9967/PS10171_PS18_1558_9967_P27648.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10173_PS18_1519_10117/PS10173_PS18_1519_10117_P12800.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10174_PS18_1549_10170/PS10174_PS18_1549_10170_P38400.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10176_PS18_1554_10292/PS10176_PS18_1554_10292_P28672.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10178_PS18_1497_10507/PS10178_PS18_1497_10507_P14336.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10179_PS18_5157_10554/PS10179_PS18_5157_10554_P18944.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10181_PS18_1567_10879/PS10181_PS18_1567_10879_P24064.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10182_PS18_1601_10920/PS10182_PS18_1601_10920_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10182_PS18_1601_10920/PS10182_PS18_1601_10920_P06144.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10183_PS18_1608_10942/PS10183_PS18_1608_10942_P12288.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10184_PS18_1616_11008/PS10184_PS18_1616_11008_P06656.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10186_PS18_1605_11026/PS10186_PS18_1605_11026_P31744.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10187_PS18_1614_11019/PS10187_PS18_1614_11019_P17920.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10188_PS19_1214_11335/PS10188_PS19_1214_11335_P05120.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10189_PS19_1261_11299/PS10189_PS19_1261_11299_P23040.7
/Volumes/catherine_team/mvperdue/preschool/mrs/data_acg/PS10190_PS19_0077_11448/PS10190_PS19_0077_11448_P44032.7
"


Control_File_List=

region=ACC

for file in $ACG_PFiles
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
	
	
	echo " DOECC= T" >> $filename #Do eddy current correction turn off if done in FID-A
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