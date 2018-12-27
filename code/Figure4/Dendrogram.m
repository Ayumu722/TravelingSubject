clear all

%% set parameter
sub_num = 9; % participant
mea_num = 12; % measurement bias
diag_num = 3; % diagnosis factor
sah_num = 6; % sampling bias (HC)
sam_num = 3; % sampling bias (MDD)
sas_num = 3; % samplibg bias (SCZ)
lambda = 14;
load(['/home/denbo3/ayumu/TravelingSubject/code/Figure4/BIAS_Lambda',num2str(lambda),'_manyfactor_SITE.mat']) %% CHANGE HERE
TSMN_SITE = mn(sub_num+1:sub_num+mea_num,:);
LABEL_m = LABEL(sub_num+1:sub_num+mea_num);

figure('Position',[100 100 1700 600])
D = pdist(TSMN_SITE,'correlation');
tree = linkage(D);
leafOrder = optimalleaforder(tree,D);
[H,T,OUTPERM] = dendrogram(tree,'Reorder',leafOrder);
set(gca,'XTickLabel',LABEL_m([OUTPERM]),'FontSize',10);
title('Clustering')

