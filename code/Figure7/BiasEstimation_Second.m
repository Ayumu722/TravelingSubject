function BiasEstimation_Second(USEBIAS)

PATH = '/home/denbo3/ayumu/TravelingSubject/';

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
% USEBIAS = 'ORG';
% USEBIAS = 'GLM';
% USEBIAS = 'AGLM';
% USEBIAS = 'TS';
% USEBIAS = 'ComBat';

numfold = 2;

mea_num = 12; % measurement bias
sub_num = 9; % participant
diag_num = 3; % diagnosis factor
sah_num = 6; % sampling bias (HC)
sam_num = 3; % sampling bias (MDD)
sas_num = 3; % samplibg bias (SCZ)

for i = 1:numfold
    load([PATH,'code/Figure7/CV/FOLD',num2str(i),'.mat'])
    switch USEBIAS
        case 'ORG'
            X = X_TEST_withTS;
        otherwise
            load([PATH,'code/Figure7/Results/',USEBIAS,'/BIAS_FOLD',num2str(i),'.mat'])
            MEA_DM = DM_TEST_withTS.TS(:,1:mea_num);
            X = X_TEST_withTS;
            X = X - MEA_DM*mea_bias;
    end
    DM = DM_TEST_withTS.TS;
    lambda = 8;
    H = DM'*DM+ lambda * eye(size(DM'*DM)); % Regularization
    Aeq = [ones(1,mea_num)/mea_num,zeros(1,sub_num),zeros(1,diag_num),zeros(1,sah_num),zeros(1,sam_num),zeros(1,sas_num),0;...
        zeros(1,mea_num),ones(1,sub_num)/sub_num,zeros(1,diag_num),zeros(1,sah_num),zeros(1,sam_num),zeros(1,sas_num),0;...
        zeros(1,mea_num),zeros(1,sub_num),zeros(1,diag_num),ones(1,sah_num)/sah_num,zeros(1,sam_num),zeros(1,sas_num),0;...
        zeros(1,mea_num),zeros(1,sub_num),zeros(1,diag_num),zeros(1,sah_num),ones(1,sam_num)/sam_num,zeros(1,sas_num),0;...
        zeros(1,mea_num),zeros(1,sub_num),zeros(1,diag_num),zeros(1,sah_num),zeros(1,sam_num),ones(1,sas_num)/sas_num,0];
    Beq = [0;0;0;0;0];
    for numnc = 1:NC
        disp(['Now ',num2str(100*numnc/NC)])
        t = X(:,numnc);
        f = -DM'*t;
        mn(:,numnc) = quadprog(H,f,[],[],Aeq,Beq);
    end
    tmp = LABEL.TS;
    clear LABEL
    LABEL = tmp;
    save([PATH,'code/Figure7/Results/',USEBIAS,'/FOLD',num2str(i),'.mat'],'mn','LABEL')
end
end
