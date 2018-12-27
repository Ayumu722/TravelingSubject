
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Description of the data
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. COR_SRPBS_ALL_ORG.mat
Functional connectivity matrix data for SRPBS dataset (After excluded subjects due to large motion)
2. COR_SRPBS_UnifiedProtocol.mat
Functional connectivity matrix data for SRPBS dataset collected by unified protocol (After excluded subjects due to large motion)
3. COR_TravelingSubject.mat
Functional connectivity matrix data for traveling-subject dataset
4. DATA_NOTUSE_TS.mat
Information of subjects who have large motion during rest in traveling-subject dataset
5. DesignMatrix.mat
Subject information matrix (Only subjects collected by unified protocol from SRPBS dataset + Traveling subject datset）
6. DesignMatrix_SRPBS_ALL.mat
Subject information matrix (All subjects from SRPBS dataset + Traveling subject datset）

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Functions order of execution for typical usage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0. modify EstimateBeta_withPA.m and MakeConnectivity_SubtractBias.m based on your folder
1. execute ../data/EstimateBeta_withPA.m to estimate each bias and factor for SRPBS datsaet + traveling-subject dataset
2. execute ../MakeConnectivity_SubtractBias.m to subtract the measuremet bias or the sampling bias from SRPBS datsaet

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Functions order of execution for figure2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0. modify BiasEstimation.m and CheckEffectAll.m based on your folder
1. execute ../code/Figure2/BiasEstimation.m to estimate each bias and factor for SRPBS datsaet (only used unified protocol data) + traveling-subject dataset
2. execute ../code/Figure2/CheckEffectAll.m to plot figure2

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Functions order of execution for figure3
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0. modify mkroi.m and plotROI_Zscore.py based on your folder
1. execute ../code/Figure3/mkroi.m to prepare nifti data
2. execute ../code/Figure3/plotROI_Zscore.py to make figure3 in ../code/Figure3/Node_Zscore

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Functions order of execution for figure4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0. modify BiasEstimation.m, Dendrogram.m, and ContributionSize.m based on your folder
1. execute ../code/Figure4/BiasEstimation.m to estimate each bias and factor for SRPBS datsaet (only used unified protocol data) + traveling-subject dataset
2. execute ../code/Figure4/Dendrogram.m to plot figure 4a
3. execute ../code/Figure4/ContributionSize.m to plot figure 4b

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Functions order of execution for figure5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0. modify FitSamplingBias.m, FitSamplingBias_CV.m, and TestCrossvalidation_SamplingBias.m based on your folder
1. execute ../code/Figure5/FitSamplingBias_CV.m to plot figure 5c
2. execute ../code/Figure5/TestCrossvalidation_SamplingBias.m to plot figures 5de

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Functions order of execution for figure6
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0. modify AnalysisPCA.m based on your folder
1. execute ../code/Figure6/AnalysisPCA.m to plot figure
2. Change variable "USEDATA" in AnalysisPCA.m from 'ORG' (figure 6a) to 'SubtractMeasurementBias' (figure 6b) or 'SubtractSamplingBias' (figure 6c)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Functions order of execution for figure7
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
0. modify MakeDesignMatrix.m, Make2FOLD.m, BiasEstimation_First.m, BiasEstimation_Second.m, run_bias.m,and CompareHarmonization.m  based on your folder
1. execute ../code/Figure7/MakeDesignMatrix.m to make design matrix
2. execute ../code/Figure7/Make2FOLD.m to make 2 fold datasets
3. execute ../code/Figure7/run_bias.m to estimate each bias and each factor in each fold dataset
4. execute ../code/Figure7/CompareHarmonization.m to plot figure7

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Additional notes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. The data from site KPM cannot be disclosed due to ethical issues.
2. make_nii.m, save_nii.m, save_nii_hdr.m were downloaded from https://jp.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image
3. ComBat functions in ../code/Figure7 were downloaded from https://github.com/Jfortin1/ComBatHarmonization
4. We used MATLAB R2016b

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Feedback & Bug report
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Any feedback and bug report are welcome. Please contact Ayumu Yamashita (ayumu@atr.jp).

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Acknowledgements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This toolbox is brought to you by ATR Computational Neuroscience laboratories in Kyoto.