clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/'; %% CHANGE HERE

%% load data
load([PATH,'data/COR_TravelingSubject.mat'])
load([PATH,'data/DATA_NOTUSE_TS.mat'])
X(OUT,:) = [];
X_TS = X;
load([PATH,'data/COR_SRPBS_UnifiedProtocol.mat'])
X_MD = X;
clear X
X = [X_TS;X_MD];

%% set parameter
TARGET = {'SCAN', 'COIL', 'SM', 'PA'};

sub_num = 9; % participant
diag_num = 3; % diagnosis factor
sah_num = 6; % sampling bias (HC)
sam_num = 3; % sampling bias (MDD)
sas_num = 3; % samplibg bias (SCZ)


for i=1:length(TARGET)
    
    switch TARGET{i}
        case 'SITE'
            mea_num = 12; % measurement bias
        case 'SM'
            mea_num = 3; % manufacturer bias (Siemens, Philips, GE)
        case 'PA'
            mea_num = 2; % phase encoding direction bias (AP or PA)
        case 'COIL'
            mea_num = 4; % the number of channel per coil (8,12,24,32)
        case 'SCAN'
            mea_num = 7; % scanner (Verio, Trio, Skyra, MR750W, Achieva, Spectra, Signa)
    end
    
    lambda = 14;
    load([PATH,'code/Figure4/BIAS_Lambda',num2str(lambda),'_manyfactor_',TARGET{i},'.mat'])
    TSMN_SUB = mn(1:sub_num,:);
    TSMN_SITE = mn(sub_num+1:sub_num+mea_num,:);
    est_d = mn(sub_num+mea_num+1:sub_num+mea_num+diag_num,:);
    BPMN = mn(sub_num+mea_num+diag_num+1:sub_num+mea_num+diag_num+sah_num,:); % ATT, ATV, COI, SWA, UKY, UTO
    BPMN_MDD = mn(sub_num+mea_num+diag_num+sah_num+1:sub_num+mea_num+diag_num+sah_num+sam_num,:);% COI, UKY, UTO
    BPMN_SCZ = mn(sub_num+mea_num+diag_num+sah_num+sam_num+1:sub_num+mea_num+diag_num+sah_num+sam_num+sas_num,:); % SWA, UKY, UTO
    EF_ASD = mn(sub_num+mea_num+1,:);
    EF_MDD = mn(sub_num+mea_num+2,:);
    EF_SCZ = mn(sub_num+mea_num+3,:);
    CONST = mn(end,:);
    
    x_hat = DM*mn;
    residual = (X-x_hat).^2;
    mean_residual = mean(residual(:));
    
    CONT_participant = DM(:,1:sub_num)*TSMN_SUB;
    CONT_measurement = DM(:,sub_num+1:sub_num+mea_num)*TSMN_SITE;
    CONT_diag = DM(:,sub_num+mea_num+1:sub_num+mea_num+diag_num)*est_d;
    CONT_sampling_hc = DM(:,sub_num+mea_num+diag_num+1:sub_num+mea_num+diag_num+sah_num)*BPMN;
    CONT_sampling_mdd = DM(:,sub_num+mea_num+diag_num+sah_num+1:sub_num+mea_num+diag_num+sah_num+sam_num)*BPMN_MDD;
    CONT_sampling_scz = DM(:,sub_num+mea_num+diag_num+sah_num+sam_num+1:sub_num+mea_num+diag_num+sah_num+sam_num+sas_num)*BPMN_SCZ;
    norm_coef = (CONT_participant.^2)+(CONT_measurement.^2)+(CONT_diag.^2)+(CONT_sampling_hc.^2)+(CONT_sampling_mdd.^2)+(CONT_sampling_scz.^2)+residual;
    NormalizedEffectSize(i) = mean((CONT_measurement(:).^2)./norm_coef(:))/mea_num;

end

figure;
bar(NormalizedEffectSize)
set(gca,'XTickLabel',TARGET)
title('Normalized contribution size')
