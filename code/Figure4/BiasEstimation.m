clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/'; %% CHANGE HERE!!
ROI = 'ROI268';
switch ROI
    case 'BAL'
        NR = 140;
    case 'ICA'
        NR = 20;
    case 'ROI268'
        NR = 268;
end
ix_all = tril( ones(NR,NR), -1 );
ix_all = ix_all(:);
ix_chk = find( ix_all == 1 );
NC = length(ix_chk);
load([PATH,'data/COR_TravelingSubject.mat'])
load([PATH,'data/DATA_NOTUSE_TS.mat'])
X(OUT,:) = [];
X_TS = X;
load([PATH,'data/COR_SRPBS_UnifiedProtocol.mat'])
X_MD = X;
clear X
X = [X_TS;X_MD];
TARGET = {'SITE','SCAN', 'COIL', 'SM', 'PA'};

sub_num = 9; % participant
diag_num = 3; % diagnosis factor
sah_num = 6; % sampling bias (HC)
sam_num = 3; % sampling bias (MDD)
sas_num = 3; % samplibg bias (SCZ)
lambda = 14;

for ii = 1%1:length(TARGET)
    switch TARGET{ii}
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
    load([PATH,'data/DesignMatrix.mat']) % load designmatrix
    DM_tmp = DM;
    LABEL_tmp = LABEL;
    clear DM LABEL
    eval(['DM = DM_tmp.',TARGET{ii},';'])
    eval(['LABEL = LABEL_tmp.',TARGET{ii},';'])
    DM = [DM,ones(size(DM,1),1)];
    %X = X - repmat(mean(X),size(X,1),1);
    
    H = DM'*DM+ lambda * eye(size(DM'*DM)); % Regularization
    Aeq = [ones(1,sub_num)/sub_num,zeros(1,mea_num),zeros(1,diag_num),zeros(1,sah_num),zeros(1,sam_num),zeros(1,sas_num),0;...
        zeros(1,sub_num),ones(1,mea_num)/mea_num,zeros(1,diag_num),zeros(1,sah_num),zeros(1,sam_num),zeros(1,sas_num),0;...
        zeros(1,sub_num),zeros(1,mea_num),zeros(1,diag_num),ones(1,sah_num)/sah_num,zeros(1,sam_num),zeros(1,sas_num),0;...
        zeros(1,sub_num),zeros(1,mea_num),zeros(1,diag_num),zeros(1,sah_num),ones(1,sam_num)/sam_num,zeros(1,sas_num),0;...
        zeros(1,sub_num),zeros(1,mea_num),zeros(1,diag_num),zeros(1,sah_num),zeros(1,sam_num),ones(1,sas_num)/sas_num,0];
    Beq = [0;0;0;0;0];
    for i = 1:NC
        disp(['Now ',num2str(100*i/NC)])
        t = X(:,i);
        f = -DM'*t;
        mn(:,i) = quadprog(H,f,[],[],Aeq,Beq);
    end
        save([PATH,'code/Figure4/BIAS_Lambda',num2str(lambda),'_manyfactor_',TARGET{ii},'.mat'],'mn','DM','LABEL')
        clear mn DM LABEL
end