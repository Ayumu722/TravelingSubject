clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/'; %% CHANGE HERE

%% PLOT PCA
USEDATA = 'ORG'; %  use data not modified
% USEDATA = 'SubtractMeasurementBias'; % use measurement bias subtracted data 
% USEDATA = 'SubtractSamplingBias'; % use sampling bias subtracted data 

load([PATH,'data/COR_SRPBS_ALL_',USEDATA,'.mat'])
COLOR_BASE = [120,120,120;250,230,0;53,161,107;0,65,255;102,204,255;255,153,160;255,153,0;154,0,121;255,40,0]/255;
SYMBOL_BASE = ['o';'^';'d';'s';'p'];
SYMBOL_SIZE = 100;
SYMBOL_XIZE_MINI = 2;

DATA = DATA_SUB;
GROUP = 10*DATA(:,1)+DATA(:,2);
COLOR = [];
SYMBOL = [];
for i = unique(GROUP)'
    DIAGNOSIS = floor(i/10)+1;
    SITE = mod(i,10);
    COLOR = [COLOR;COLOR_BASE(SITE,:)];
    SYMBOL = [SYMBOL;SYMBOL_BASE(DIAGNOSIS,:)];
end
BPNOTUSE = find(sum(isnan(X)));
X(:,BPNOTUSE) = [];
X = X - repmat(mean(X(DATA(:,1)==0,:)),size(X,1),1);
[coeff_org,score_org,latent,tsquared, explained] = pca(X);
%         [coeff_org,score_org,latent,tsquared, explained] = pca(X');
EX = cumsum(latent)./sum(latent);
EX(2)

site_num = unique(DATA(:,2))';
h = figure('Position',[1 26 1895 1066]);
title('Original Data')
% h = gscatter(coeff_org(:,1),coeff_org(:,2),GROUP,COLOR,SYMBOL,SYMBOL_XIZE_MINI,'doleg','off','filled');
h = gscatter(score_org(:,1),score_org(:,2),GROUP,COLOR,SYMBOL,SYMBOL_XIZE_MINI,'doleg','off','filled');
for i = 1:length(h)
    set(h(i),'MarkerFaceColor',COLOR(i,:))
end
hold on
t = 1;
for i = site_num
    USEDATA = find((DATA(:,2)==i)&(DATA(:,1)==0));
    DATALENGTH(i) = length(USEDATA);
%     COEF1(i) = mean(coeff_org(USEDATA,1));
%     COEF2(i) = mean(coeff_org(USEDATA,2));
    COEF1(t) = mean(score_org(USEDATA,1));
    COEF2(t) = mean(score_org(USEDATA,2));
    t = t + 1;
end

diag_num = unique(DATA(:,1))';
diag_num(1) = [];
t = 1;
for i = diag_num
    USEDATA = find(DATA(:,1)==i);
%     COEF1_DIAG(i) = mean(coeff_org(USEDATA,1));
%     COEF2_DIAG(i) = mean(coeff_org(USEDATA,2));
    COEF1_DIAG(t) = mean(score_org(USEDATA,1));
    COEF2_DIAG(t) = mean(score_org(USEDATA,2));
    t = t + 1;
end

t = 1;
for i = site_num
    p(t) = scatter(COEF1(t),COEF2(t),SYMBOL_SIZE,COLOR_BASE(i,:),SYMBOL_BASE(1,:),'filled');
    t = t + 1;
end
t = 1;
for i = diag_num
    p(length(site_num)+t) = scatter(COEF1_DIAG(t),COEF2_DIAG(t),SYMBOL_SIZE,'k',SYMBOL_BASE(i+1,:),'filled');
    t = t + 1;
end
axis square
% xlim([-0.1 0.1])
% ylim([-0.1 0.1])
xlim([-25 25])
ylim([-25 25])
LABEL = {'ATT','ATV','UKY','SWA','HUH','HKH','COI','UTO','ASD','MDD','SCZ'};
legend(p,LABEL)

