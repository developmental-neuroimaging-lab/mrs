# mrs
### Updated by Meaghan Perdue 17 Dec 2024

Data contained in this directory was published in:
Perdue et al., 2023, NeuroImage, <https://doi.org/10.1016/j.neuroimage.2023.120087>
Also used as source data for control subjects included in: Perdue et al., 2024, bioRxiv <https://doi.org/10.1101/2024.05.06.592786>

## Data overview
**Note that as of 17 Dec. 2024 raw and intermediate data files have been moved to Christina's iMac under /Users/Projects/mrs**
Processed and raw (p-file) MRS data from Preschool participants including data from Anterior Cingulate Cortex (ACC, in data_acg) and Left Temporo-Parietal cortex (LTP, in data_lag). \
T1 images for corresponding scans were used for voxel localization and tissue segmentation. Segmented files are stored within, MP removed raw DICOMs of the T1s for server space. \
CoRegStandAlone_output sub-folders contain PDF images showing co-registration and segmentation of MRS voxels on T1 images. \
Output_[date] sub-folders contain quantified metabolites based on LCModel quantification and Harris Lab tissue correction methods. Processing details below. \
Individual subject/session folders are named as **PSNNNNN_PSYY_XXX_P#####** (where NNNNN=subject ID, PSYY_XXX=study code, and P##### = pfile ID). These contain .nii images with the segmeneted T1s and voxel masks as .nii files, these can be deleted if necessary to free up server space. Sub-folders named by voxel that include LCModel output spectra in .PS format. These can be converted to .pdf using the pstopdf command. Keep the contents of the ACC and LTP folders. Sub-folders called "report" include FID-A outputs for QC. \

BasisSet folder includes the simulated PRESS TE=30ms basis set used for fitting in LCModel.

Tabular data derived from this dataset and more information about the project can be found in Meaghan's OneDrive Trainee folder: OneDrive/Lebel Lab/Trainee Folders/Meaghan/Metabolite Development \
and OneDrive/Lebel Lab/Trainee Folders/Meaghan/Preschool_MRS_data


## Data processing notes
Processing scripts for magnetic resonance spectroscopy data \
Workflow for processing PRESS data acquired on 3T GE MR750w scanner \
Uses tools from Gannet, FID-A, and LCModel \
Data processing workflow and scripts adapted from Harris Brain Lab, original scripts by Tiffany K. Bell, Marilena M. DeMayo & Ashley D. Harris \
For original tissue correction scripts, see: https://github.com/HarrisBrainLab/TissueCorrections

Follow workflow oulined in src/MRS_Processing_Workflow.md

There are separate sets of scripts for different MRS voxels: \
ACC=ACG=Anterior Cingulate Cortex/Gyrus (abbreviations used interchangeably) \
LTP=LAG=Left Temporo-Parietal (aka Left Angular Gyrus; abbreviations used interchangeably)