function BiasEstimation_First(USEBIAS)

PATH = '/home/denbo3/ayumu/TravelingSubject/';

addpath([PATH,'code/Figure7/ComBat/'])

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
numfold = 2;
% USEBIAS = 'GLM';
% USEBIAS = 'AGLM';
% USEBIAS = 'TS';
% USEBIAS = 'ComBat';

mkdir([PATH,'code/Figure7/Results/',USEBIAS])
for i = 1:numfold
load([PATH,'code/Figure7/CV/FOLD',num2str(i),'.mat'])
switch USEBIAS
    case 'GLM'
        X = X_TRAIN;
        DM = DM_TRAIN.GLM;
        USESITE = sum(DM)>1;
        USESITE(end) = [];
        DM(:,USESITE==0) = [];
        H = DM'*DM;
        mea_num = 6; % measurement bias
        Aeq = [ones(1,mea_num)/mea_num,0];
        Beq = 0;
        for numnc = 1:NC
            disp(['Now ',num2str(100*numnc/NC)])
            t = X(:,numnc);
            f = -DM'*t;
            mn(:,numnc) = quadprog(H,f,[],[],Aeq,Beq);
        end
        mea_bias = zeros(size(DM_TRAIN.GLM,2)-1,NC);
        mea_bias(USESITE,:) = mn(1:mea_num,:);
    case 'AGLM'
        X = X_TRAIN;
        DM = DM_TRAIN.AGLM;
        USESITE = sum(DM)>1;
        USESITE(end) = [];
        DM(:,USESITE==0) = [];
        H = DM'*DM;
        mea_num = 6; % measurement bias
        diag_num = 3; % diagnosis
        Aeq = [ones(1,mea_num)/mea_num,zeros(1,diag_num),0];
        Beq = 0;
        for numnc = 1:NC
            disp(['Now ',num2str(100*numnc/NC)])
            t = X(:,numnc);
            f = -DM'*t;
            mn(:,numnc) = quadprog(H,f,[],[],Aeq,Beq);
        end
        mea_bias = zeros(size(DM_TRAIN.GLM,2)-1,NC);
        mea_bias(USESITE(1:(size(DM_TRAIN.GLM,2)-1)),:) = mn(1:mea_num,:);
    case 'TS'
        mea_num = 12; % measurement bias
        sub_num = 9; % participant
        diag_num = 3; % diagnosis factor
        sah_num = 6; % sampling bias (HC)
        sam_num = 3; % sampling bias (MDD)
        sas_num = 3; % samplibg bias (SCZ)
        X = X_TRAIN_withTS;
        DM = DM_TRAIN_withTS.TS;
        lambda = 6;
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
        mea_bias = mn(1:mea_num,:);
    case 'ComBat'
        Correlation = X_TRAIN';
        DM = DM_TRAIN;
        SITENUM = unique(DM.COMBAT.batch);
        for ii = 1:length(SITENUM)
            DM.COMBAT.batch(DM.COMBAT.batch==SITENUM(ii)) = ii;
        end
        [X,gamma_star,delta_star, var_pooled] = combat(Correlation,DM.COMBAT.batch,DM.COMBAT.mod');
        tmp = repmat(sqrt(var_pooled),1,length(unique(DM.COMBAT.batch)))'.*gamma_star./sqrt(delta_star);
        mea_num = 12; % measurement bias
        mea_bias = zeros(mea_num,NC);
        mea_bias(SITENUM,:) = tmp;
end
save([PATH,'code/Figure7/Results/',USEBIAS,'/BIAS_FOLD',num2str(i),'.mat'],'mea_bias','LABEL')
clear mn

end

