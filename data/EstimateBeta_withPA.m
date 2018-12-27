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

sub_num = 9; % participant factor
mea_num = 12; % measurement bias
pa_num = 2; % phase encoding factor
diag_num = 3; % diagnosis factor
sah_num = 8; % sampling bias (HC)
sam_num = 5; % sampling bias (MDD)
sas_num = 3; % samplibg bias (SCZ)

load([PATH,'data/DesignMatrix_SRPBS_ALL.mat']) % load designmatrix
DM = [DM,ones(size(DM,1),1)];

load([PATH,'data/COR_TravelingSubject.mat']) % load Traveling subject connectivity matrix
load([PATH,'data/DATA_NOTUSE_TS.mat'])
X(OUT,:) = [];
X_TS = X;

load([PATH,'data/COR_SRPBS_ALL_ORG.mat'])% load SRPBS subject connectivity matrix
X_MD = X;

clear X
X = [X_TS;X_MD];


lambda = 11;
H = DM'*DM+ lambda * eye(size(DM'*DM)); % Regularization

Aeq = [ones(1,sub_num)/sub_num,zeros(1,mea_num),zeros(1,pa_num),zeros(1,diag_num),zeros(1,sah_num),zeros(1,sam_num),zeros(1,sas_num),0;...
    zeros(1,sub_num),ones(1,mea_num)/mea_num,zeros(1,pa_num),zeros(1,diag_num),zeros(1,sah_num),zeros(1,sam_num),zeros(1,sas_num),0;...
    zeros(1,sub_num),zeros(1,mea_num),ones(1,pa_num)/pa_num,zeros(1,diag_num),zeros(1,sah_num),zeros(1,sam_num),zeros(1,sas_num),0;...
    zeros(1,sub_num),zeros(1,mea_num),zeros(1,pa_num),zeros(1,diag_num),ones(1,sah_num)/sah_num,zeros(1,sam_num),zeros(1,sas_num),0;...
    zeros(1,sub_num),zeros(1,mea_num),zeros(1,pa_num),zeros(1,diag_num),zeros(1,sah_num),ones(1,sam_num)/sam_num,zeros(1,sas_num),0;...
    zeros(1,sub_num),zeros(1,mea_num),zeros(1,pa_num),zeros(1,diag_num),zeros(1,sah_num),zeros(1,sam_num),ones(1,sas_num)/sas_num,0];
Beq = [0;0;0;0;0;0];
for i = 1:NC
    disp(['Now ',num2str(100*i/NC)])
    t = X(:,i);
    f = -DM'*t;
    mn(:,i) = quadprog(H,f,[],[],Aeq,Beq);
end

save([PATH,'data/BIAS_Lambda',num2str(lambda),'.mat'],'mn','DM','LABEL')

