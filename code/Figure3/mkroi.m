clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/'; %% CHANGE HERE!!
PAR.path = [PATH,'code/Figure3'];

%% set parameter
sub_num = 9; % participant
mea_num = 12; % measurement bias
diag_num = 3; % diagnosis factor
sah_num = 6; % sampling bias (HC)
sam_num = 3; % sampling bias (MDD)
sas_num = 3; % samplibg bias (SCZ)
lambda = 14;
load([PATH,'code/Figure2/BIAS_Lambda',num2str(lambda),'.mat'])
FACTOR{1} = 'ParticipantFactor';
FACTOR{2} = 'MeasurementBias';
FACTOR{3} = 'SamplingBiasHC';
FACTOR{4} = 'SamplingBiasMDD';
FACTOR{5} = 'SamplingBiasSCZ';
FACTOR{6} = 'ASD';
FACTOR{7} = 'MDD';
FACTOR{8} = 'SCZ';

BIAS{1} = mn(1:sub_num,:); % participant factor
BIAS{2} = mn(sub_num+1:sub_num+mea_num,:); % measurement bias
BIAS{3} = mn(sub_num+mea_num+diag_num+1:sub_num+mea_num+diag_num+sah_num,:); % sampling bias of HC
BIAS{4} = mn(sub_num+mea_num+diag_num+sah_num+1:sub_num+mea_num+diag_num+sah_num+sam_num,:);% sampling bias of MDD
BIAS{5} = mn(sub_num+mea_num+diag_num+sah_num+sam_num+1:sub_num+mea_num+diag_num+sah_num+sam_num+sas_num,:); % sampling bias of SCZ
BIAS{6} = mn(sub_num+mea_num+1,:); % Effect of ASD
BIAS{7} = mn(sub_num+mea_num+2,:); % Effect of MDD
BIAS{8} = mn(sub_num+mea_num+3,:); % Effect of SCZ

LABEL_ALL{1} = LABEL(1:sub_num); % participant factor
LABEL_ALL{2} = LABEL(sub_num+1:sub_num+mea_num); % measurement bias
LABEL_ALL{3} = LABEL(sub_num+mea_num+diag_num+1:sub_num+mea_num+diag_num+sah_num); % sampling bias of HC
LABEL_ALL{4} = LABEL(sub_num+mea_num+diag_num+sah_num+1:sub_num+mea_num+diag_num+sah_num+sam_num); % sampling bias of MDD
LABEL_ALL{5} = LABEL(sub_num+mea_num+diag_num+sah_num+sam_num+1:sub_num+mea_num+diag_num+sah_num+sam_num+sas_num); % sampling bias of SCZ
LABEL_ALL{6} = LABEL(sub_num+mea_num+1); % Effect of ASD
LABEL_ALL{7} = LABEL(sub_num+mea_num+2); % Effect of MDD
LABEL_ALL{8} = LABEL(sub_num+mea_num+3); % Effect of SCZ

% ROI information
PAR.roi = 'ROI268';
PAR.roitbl     = [PAR.path,'/ROITBL_I268.mat']; % table listing regions of interest (roi) [141215]

PAR.out = [PAR.path,'/Node_Zscore/'];
mkdir(PAR.out)

% Use data
for USENUM = 1:8

PAR.uselabel = FACTOR{USENUM};
PAR.dat = BIAS{USENUM};
PAR.label = LABEL_ALL{USENUM};
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load( PAR.roitbl );         % Read in MAP, ROI, LAB, NUM, mdx
NEWMAP = zeros(size(MAP,1),size(MAP,2),size(MAP,3));
NR = length( ROI );               % Number of regions defined in this atlas
DATA = PAR.dat;
LABEL = PAR.label;
NC = size(DATA,2);
if size(DATA,1) == 1
    USEDATA = abs(DATA);
else
%     USEDATA = max(abs(DATA));
    USEDATA = median(abs(DATA));
end

for i = 1:NR
    ROIDAT(i) = mean(USEDATA(mdx.mx ==i | mdx.my==i));
end
2.33*std(ROIDAT)+mean(ROIDAT);

for i = 1:NR
        ROIZ = zscore(ROIDAT);
        NEWMAP(ROI{i}.idx) = ROIZ(i);
end


IMAGE = NEWMAP;
nii = make_nii(IMAGE,[2,2,2],[46,64,37]);
save_nii(nii,[PAR.out,PAR.uselabel,'.nii'])
end




