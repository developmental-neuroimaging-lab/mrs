# Running PRESS through LCModel
Preprocessing, quantitation, and CSF-correction of PRESS MRS sequence acquired on 3T GE MR750w system

Separate processing scripts for each dataset: Anterior Cingulate (ACG/ACC) and Left Temporo-Parietal (LAG/LTP)

## Resources
- MATLAB
	- Statistics and Machine Learning Toolbox
	- Image Processing Toolbox
- Terminal
- Text editor (use something good for code, not the Mac built-in text editor, VSCode and Sublime are good options)
- [FID-A](https://github.com/CIC-methods/FID-A)
- [Gannet](https://github.com/markmikkelsen/Gannet)
- [spm12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/)
	- Mac OS 11.4 Big Sur blocked .mexmaci64 files, I resolved following instructions here (https://en.wikibooks.org/wiki/SPM/Installation_on_64bit_Mac_OS_(Intel)#macOS_Catalina)
- LCModel
	- [SourceCode](http://s-provencher.com/lcm-test.shtml)
	- [MRSHub Instruction](https://forum.mrshub.org/t/building-lcmodel/317)

## PreProcessing

Using FID-A (suggest saving a project specific version) and MATLAB

Scripts - `PreProcess_SE_PRESS_ACG.m` , `PreProcess_SE_PRESS_LAG.m`

make sure home directory and sub-folders are writable
name folders starting with letters, not numbers

Specify PFile list

In the FID-A for loop - adjust for depth of PFiles in file path

```matlab

for i = 1:length(MRS);
file=MRS{i};
splitfolder=split(file,"/");
path=join(splitfolder(1),"/"); % Adjust this for the depth of file folders
file=splitfolder(2);
file=file{1};
cd (path{1})
[out,outw,out_noproc,outw_noproc]=run_pressproc_GEauto(file);
cd (home)
end

```

Will pop up with images of fits and ask "are you satisfied with the fit?" y/n - can hit 'return' through these or turn off this feature by setting suppressPlots to 'TRUE' in the op_getLW and op_getSNR calls in the PreProcess_SE_PRESS.m script

For `run_pressproc_GEauto` you may want to make a copy and rename the report based on which voxel you're looking at if there's multiples.
 
The coregistration and QC metrics are in this script too. 


## Processing

Completed in terminal

### Step 1 - Create Control Files

Scripts - `LCModel_Create_Control_Files_ACC.sh` , `LCModel_Create_Control_Files_LTP.sh`

List all PFiles at beginning - the initial ones ending in .7 works

Use full path

Update
- Basis set path (full path)
- Parameter specs
i.e.```bash
	echo " DELTAT= 2.000e-04" >> $filename # Sample/dwell time (time between two consecutive points)
	echo " IAVERG= 1" >> $filename
	echo " NUNFIL= 4096" >> $filename # Number of data points
```

Writes list_controlfiles.csv to local directory where the script was run from_

### Step 2 - Run LCModel 

Scripts - `LCModel_Batch_ACG.sh` , `LCModel_Batch_LAG.sh`

Make sure read/write file permissions are enabled for the .control files

Navigate to source directory of LCModel in terminal 

Run script 

You'll get a bunch of nonsense for the fortran compilation

## Tissue Correction

Back to MATLAB

Assumes you have done CoReg with Gannet

Scripts - `BatchTissCorr_acg.sh` , `BatchTissCorr_lag.sh` 

Specify the **CSV** files, and the Gannet output structure.

Runs `LCM_Met_Quant_MD_QCd.m`
