clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/'; % CHANGE HERE!!
mkdir([PATH,'code/Figure7/CV/'])
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
load([PATH,'code/Figure7/DesignMatrix.mat']) % load designmatrix
load([PATH,'data/COR_TravelingSubject.mat'])
load([PATH,'data/DATA_NOTUSE_TS.mat'])
X(OUT,:) = [];
X_TS = X;

indices_TS =ones(size(X_TS,1),1);

load([PATH,'data/COR_SRPBS_UnifiedProtocol.mat'])
numfold = 2;
rng(1)
indices = crossvalind('Kfold',DATA(:,2),numfold);

for i = 1:numfold

indices_Train =DIVIDEID~=i;
indices_Test =DIVIDEID==i;

X_MD_TRAIN = X(indices~=i,:);
X_MD_TEST = X(indices==i,:);

TRAINSUB = [indices_TS==0;indices~=i]==1;
TRAINSUB_withTS = [indices_Train;indices~=i]==1;
TESTSUB = [indices_TS==0;indices==i]==1;
TESTSUB_withTS = [indices_Test;indices==i]==1;

X_TRAIN = X_MD_TRAIN;
DM_TRAIN.TS = DM.TS(TRAINSUB,:);
DM_TRAIN.TS = [DM_TRAIN.TS,ones(size(DM_TRAIN.TS,1),1)];
DM_TRAIN.GLM = DM.GLM(TRAINSUB,:);
DM_TRAIN.GLM = [DM_TRAIN.GLM,ones(size(DM_TRAIN.GLM,1),1)];
DM_TRAIN.AGLM = DM.AGLM(TRAINSUB,:);
DM_TRAIN.AGLM = [DM_TRAIN.AGLM,ones(size(DM_TRAIN.AGLM,1),1)];
DM_TRAIN.COMBAT.mod = DM.COMBAT.mod(:,TRAINSUB);
DM_TRAIN.COMBAT.batch = DM.COMBAT.batch(:,TRAINSUB);

X_TRAIN_withTS = [X_TS(indices_Train,:);X_MD_TRAIN];
DM_TRAIN_withTS.TS = DM.TS(TRAINSUB_withTS,:);
DM_TRAIN_withTS.TS = [DM_TRAIN_withTS.TS,ones(size(DM_TRAIN_withTS.TS,1),1)];
DM_TRAIN_withTS.GLM = DM.GLM(TRAINSUB_withTS,:);
DM_TRAIN_withTS.GLM = [DM_TRAIN_withTS.GLM,ones(size(DM_TRAIN_withTS.GLM,1),1)];
DM_TRAIN_withTS.AGLM = DM.AGLM(TRAINSUB_withTS,:);
DM_TRAIN_withTS.AGLM = [DM_TRAIN_withTS.AGLM,ones(size(DM_TRAIN_withTS.AGLM,1),1)];
DM_TRAIN_withTS.COMBAT.mod = DM.COMBAT.mod(:,TRAINSUB_withTS);
DM_TRAIN_withTS.COMBAT.batch = DM.COMBAT.batch(:,TRAINSUB_withTS);

X_TEST = X_MD_TEST;
DM_TEST.TS = DM.TS(TESTSUB,:);
DM_TEST.TS = [DM_TEST.TS,ones(size(DM_TEST.TS,1),1)];
DM_TEST.GLM = DM.GLM(TESTSUB,:);
DM_TEST.GLM = [DM_TEST.GLM,ones(size(DM_TEST.GLM,1),1)];
DM_TEST.AGLM = DM.AGLM(TESTSUB,:);
DM_TEST.AGLM = [DM_TEST.AGLM,ones(size(DM_TEST.AGLM,1),1)];
DM_TEST.COMBAT.mod = DM.COMBAT.mod(:,TESTSUB);
DM_TEST.COMBAT.batch = DM.COMBAT.batch(:,TESTSUB);

X_TEST_withTS = [X_TS(indices_Test,:);X_MD_TEST];
DM_TEST_withTS.TS = DM.TS(TESTSUB_withTS,:);
DM_TEST_withTS.TS = [DM_TEST_withTS.TS,ones(size(DM_TEST_withTS.TS,1),1)];
DM_TEST_withTS.GLM = DM.GLM(TESTSUB_withTS,:);
DM_TEST_withTS.GLM = [DM_TEST_withTS.GLM,ones(size(DM_TEST_withTS.GLM,1),1)];
DM_TEST_withTS.AGLM = DM.AGLM(TESTSUB_withTS,:);
DM_TEST_withTS.AGLM = [DM_TEST_withTS.AGLM,ones(size(DM_TEST_withTS.AGLM,1),1)];
DM_TEST_withTS.COMBAT.mod = DM.COMBAT.mod(:,TESTSUB_withTS);
DM_TEST_withTS.COMBAT.batch = DM.COMBAT.batch(:,TESTSUB_withTS);

save([PATH,'code/Figure7/CV/FOLD',num2str(i),'.mat'],'X_TRAIN','DM_TRAIN','X_TEST','DM_TEST','X_TRAIN_withTS','DM_TRAIN_withTS','X_TEST_withTS','DM_TEST_withTS','LABEL','indices')
end

