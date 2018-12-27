clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/'; %% CHANGE HERE!!

%% set parameter
sub_num = 9; % participant
mea_num = 12; % measurement bias
diag_num = 3; % diagnosis factor
sah_num = 6; % sampling bias (HC)
sam_num = 3; % sampling bias (MDD)
sas_num = 3; % samplibg bias (SCZ)
lambda = 14;
load([PATH,'code/Figure2/BIAS_Lambda',num2str(lambda),'.mat'])
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

%% Statistial analysis
ALL_MEA = [mean(mean((TSMN_SUB),2)),mean(mean((TSMN_SITE),2)),mean(mean((BPMN),2)),mean(mean((BPMN_MDD),2)),mean((EF_MDD),2),mean(mean((BPMN_SCZ),2)),mean((EF_SCZ),2),mean((EF_ASD),2)];
COLOR = [0,0,0;120,120,120;0,0,0;0,65,255;102,204,255;255,40,0;255,153,160;153,216,201]/255;
MARKER_COLOR = [120,120,120;0,0,0;255,200,100;102,204,255;102,204,255;255,153,160;255,153,160;153,216,201]/255;
LABEL = {'Participant','Measurement','Sampling (HC)','Sampling (MDD)','MDD','Sampling (SCZ)','SCZ','ASD'};
NUM_MOMENT = 3;


%% Figure Means
err = [std(mean((TSMN_SUB),2)),std(mean((TSMN_SITE),2)),std(mean((BPMN),2)),std(mean((BPMN_MDD),2)),0,std(mean((BPMN_SCZ),2)),0,0];
h = figure('Position',[1 26 1920 1066]);
subplot(1,NUM_MOMENT,1);hold on
b = bar(diag(ALL_MEA),'stack');
e = errorbar(ALL_MEA,err,'LineStyle','none');
colormap(COLOR)
for i = 1:length(b)
    b(i).EdgeColor = COLOR(i,:);
end
ylim([-0.1 0.15])
title('Means','FontSize',15)
hold on
scatter(ones(length(mean((TSMN_SUB),2)),1),mean((TSMN_SUB),2),40,[1 1 1],'filled','o','MarkerEdgeColor',COLOR(1,:))
scatter(2*ones(length(mean((TSMN_SITE),2)),1),mean((TSMN_SITE),2),40,[1 1 1],'filled','o','MarkerEdgeColor',COLOR(2,:))
scatter(3*ones(length(mean((BPMN),2)),1),mean((BPMN),2),40,[1 1 1],'filled','o','MarkerEdgeColor',COLOR(3,:))
scatter(4*ones(length(mean((BPMN_MDD),2)),1),mean((BPMN_MDD),2),40,[1 1 1],'filled','o','MarkerEdgeColor',COLOR(4,:))
scatter(6*ones(length(mean((BPMN_SCZ),2)),1),mean((BPMN_SCZ),2),40,[1 1 1],'filled','o','MarkerEdgeColor',COLOR(6,:))

%% Figure Moment
t = 1;
for i = 2:NUM_MOMENT
err = [std(nthroot(moment(TSMN_SUB,i,2),i)),std(nthroot(moment(TSMN_SITE,i,2),i)),std(nthroot(moment(BPMN,i,2),i)),std(nthroot(moment(BPMN_MDD,i,2),i)),0,std(nthroot(moment(BPMN_SCZ,i,2),i)),0,0];
ALL_MOMENT(t,:) = [mean(nthroot(moment(TSMN_SUB,i,2),i)),mean(nthroot(moment(TSMN_SITE,i,2),i)),mean(nthroot(moment(BPMN,i,2),i)),mean(nthroot(moment(BPMN_MDD,i,2),i)),nthroot(moment(EF_MDD,i,2),i),mean(nthroot(moment(BPMN_SCZ,i,2),i)),nthroot(moment(EF_SCZ,i,2),i),nthroot(moment(EF_ASD,i,2),i)];
subplot(1,NUM_MOMENT,i);hold on
b = bar(diag(ALL_MOMENT(t,:)),'stack');
errorbar(ALL_MOMENT(t,:),err,'LineStyle','none')
colormap(COLOR)
for ii = 1:length(b)
    b(ii).EdgeColor = COLOR(ii,:);
end
ylim([-0.1 0.15])
title(['Moment',num2str(i)],'FontSize',15)
hold on
scatter(ones(length(moment(TSMN_SUB,i,2)),1),nthroot(moment(TSMN_SUB,i,2),i),40,[1 1 1],'filled','o','MarkerEdgeColor',COLOR(1,:))
scatter(2*ones(length(moment(TSMN_SITE,i,2)),1),nthroot(moment(TSMN_SITE,i,2),i),40,[1 1 1],'filled','o','MarkerEdgeColor',COLOR(2,:))
scatter(3*ones(length(moment(BPMN,i,2)),1),nthroot(moment(BPMN,i,2),i),40,[1 1 1],'filled','o','MarkerEdgeColor',COLOR(3,:))
scatter(4*ones(length(moment(BPMN_MDD,i,2)),1),nthroot(moment(BPMN_MDD,i,2),i),40,[1 1 1],'filled','o','MarkerEdgeColor',COLOR(4,:))
scatter(6*ones(length(moment(BPMN_SCZ,i,2)),1),nthroot(moment(BPMN_SCZ,i,2),i),40,[1 1 1],'filled','o','MarkerEdgeColor',COLOR(6,:))
t = t + 1;
end
legend(LABEL,'FontSize',15)

%% Figure Distribution
h = figure('Position',[1 26 1920 1066]);
YLIM = [-1 4.5];
Hight = YLIM(2)/3;
BinWidth = 0.025;
edge = [(-1-BinWidth/2):BinWidth:(1+BinWidth/2)];
%% Participant factor
for i = 1:size(TSMN_SUB,1)
subplot(2,2,1);hold on
xlim([-0.6 0.6])
ylim(YLIM)
MakeDistributionLOG(((TSMN_SUB(i,:))),COLOR(1,:),':',0,edge,h.Number);
end
H = gca;
legend(H.Children(1),LABEL(1),'FontSize',10)
plot([max(max(TSMN_SUB)) max(max(TSMN_SUB))],[0 Hight],'Color',COLOR(1,:))
text(max(max(TSMN_SUB))+0.001,Hight,num2str(round(max(max(TSMN_SUB)),3)),'Color',COLOR(1,:),'FontSize',10)
plot([min(min(TSMN_SUB)) min(min(TSMN_SUB))],[0 Hight],'Color',COLOR(1,:))
text(min(min(TSMN_SUB))+0.001,Hight,num2str(round(min(min(TSMN_SUB)),3)),'Color',COLOR(1,:),'FontSize',10)

%% Measurement bias
for i = 1:size(TSMN_SITE,1)
subplot(2,2,2);hold on
xlim([-0.6 0.6])
ylim(YLIM)
H = gca;
MakeDistributionLOG(((TSMN_SITE(i,:))),COLOR(2,:),'-',0,edge,h.Number);
end
H = gca;
legend(H.Children(1),LABEL(2),'FontSize',10)
plot([max(max(TSMN_SITE)) max(max(TSMN_SITE))],[0 Hight],'Color',COLOR(2,:))
text(max(max(TSMN_SITE))+0.001,Hight,num2str(round(max(max(TSMN_SITE)),3)),'Color',COLOR(2,:),'FontSize',10)
plot([min(min(TSMN_SITE)) min(min(TSMN_SITE))],[0 Hight],'Color',COLOR(2,:))
text(min(min(TSMN_SITE))+0.001,Hight,num2str(round(min(min(TSMN_SITE)),3)),'Color',COLOR(2,:),'FontSize',10)



%% Sampling bias
for i = 1:size(BPMN,1)
subplot(2,2,3);hold on
title('Sampling bias')
xlim([-0.6 0.6])
ylim(YLIM)
MakeDistributionLOG(((BPMN(i,:))),COLOR(3,:),'-',0,edge,h.Number);
end
for i = 1:size(BPMN_MDD,1)
subplot(2,2,3);hold on
MakeDistributionLOG(((BPMN_MDD(i,:))),COLOR(4,:),'-',0,edge,h.Number);
end
for i = 1:size(BPMN_SCZ,1)
subplot(2,2,3);hold on
MakeDistributionLOG(((BPMN_SCZ(i,:))),COLOR(6,:),'-',0,edge,h.Number);
end

H = gca;
legend(H.Children([23,11,3]),LABEL([3,4,6]),'FontSize',10)

plot([max(max(BPMN)) max(max(BPMN))],[0 Hight],'Color',COLOR(3,:))
text(max(max(BPMN))+0.001,Hight,num2str(round(max(max(BPMN)),3)),'Color',COLOR(3,:),'FontSize',10)
plot([min(min(BPMN)) min(min(BPMN))],[0 Hight],'Color',COLOR(3,:))
text(min(min(BPMN))+0.001,Hight,num2str(round(min(min(BPMN)),3)),'Color',COLOR(3,:),'FontSize',10)

plot([max(max(BPMN_MDD)) max(max(BPMN_MDD))],[0 Hight],'Color',COLOR(4,:))
text(max(max(BPMN_MDD))+0.001,Hight,num2str(round(max(max(BPMN_MDD)),3)),'Color',COLOR(4,:),'FontSize',10)
plot([min(min(BPMN_MDD)) min(min(BPMN_MDD))],[0 Hight],'Color',COLOR(4,:))
text(min(min(BPMN_MDD))+0.001,Hight,num2str(round(min(min(BPMN_MDD)),3)),'Color',COLOR(4,:),'FontSize',10)

plot([max(max(BPMN_SCZ)) max(max(BPMN_SCZ))],[0 Hight],'Color',COLOR(6,:))
text(max(max(BPMN_SCZ))+0.001,Hight,num2str(round(max(max(BPMN_SCZ)),3)),'Color',COLOR(6,:),'FontSize',10)
plot([min(min(BPMN_SCZ)) min(min(BPMN_SCZ))],[0 Hight],'Color',COLOR(6,:))
text(min(min(BPMN_SCZ))+0.001,Hight,num2str(round(min(min(BPMN_SCZ)),3)),'Color',COLOR(6,:),'FontSize',10)

%% Disorder factor
subplot(2,2,4);hold on
title('Disorder factor')
xlim([-0.6 0.6])
ylim(YLIM)
MakeDistributionLOG(((EF_MDD)),COLOR(5,:),'-',0,edge,h.Number);
MakeDistributionLOG(((EF_SCZ)),COLOR(7,:),'-',0,edge,h.Number);
MakeDistributionLOG(((EF_ASD)),COLOR(8,:),'-',0,edge,h.Number);
H = gca;
legend(H.Children([5 3 1]),LABEL([5 7 8]),'FontSize',10)

X = [0.02 0.06];
t = 1;
for i = [5,7,8]
switch i 
    case 5
        DATA = EF_MDD;
    case 7
        DATA = EF_SCZ;
    case 8
        DATA = EF_ASD;
end
plot([max(max(DATA)) max(max(DATA))],[0 Hight],'Color',COLOR(i,:))
text(max(max(DATA))+0.001,Hight,num2str(round(max(max(DATA)),3)),'Color',COLOR(i,:),'FontSize',10)
plot([min(min(DATA)) min(min(DATA))],[0 Hight],'Color',COLOR(i,:))
text(min(min(DATA))+0.001,Hight,num2str(round(min(min(DATA)),3)),'Color',COLOR(i,:),'FontSize',10)
t = t + 1;
end


%% Figure Distribution
h = figure('Position',[1 26 1920 1066]);
% Hight_LOG = 10^4;
Hight_LOG = 0.21;
Hight = Hight_LOG/3;
BinWidth = 0.01;
edge = [(-1-BinWidth/2):BinWidth:(1+BinWidth/2)];
%% Participant factor
for i = 1:size(TSMN_SUB,1)
subplot(2,2,1);hold on
xlim([-0.6 0.6])
ylim([0 Hight_LOG])
MakeDistribution(((TSMN_SUB(i,:))),COLOR(1,:),':',0,edge,h.Number);
end
H = gca;
legend(H.Children(1),LABEL(1),'FontSize',10)
plot([max(max(TSMN_SUB)) max(max(TSMN_SUB))],[0 Hight],'Color',COLOR(1,:))
text(max(max(TSMN_SUB))+0.001,Hight,num2str(round(max(max(TSMN_SUB)),3)),'Color',COLOR(1,:),'FontSize',10)
plot([min(min(TSMN_SUB)) min(min(TSMN_SUB))],[0 Hight],'Color',COLOR(1,:))
text(min(min(TSMN_SUB))+0.001,Hight,num2str(round(min(min(TSMN_SUB)),3)),'Color',COLOR(1,:),'FontSize',10)



%% Measurement bias
for i = 1:size(TSMN_SITE,1)
subplot(2,2,2);hold on
xlim([-0.6 0.6])
ylim([0 Hight_LOG])
H = gca;
MakeDistribution(((TSMN_SITE(i,:))),COLOR(2,:),'-',0,edge,h.Number);
end
H = gca;
legend(H.Children(1),LABEL(2),'FontSize',10)
plot([max(max(TSMN_SITE)) max(max(TSMN_SITE))],[0 Hight],'Color',COLOR(2,:))
text(max(max(TSMN_SITE))+0.001,Hight,num2str(round(max(max(TSMN_SITE)),3)),'Color',COLOR(2,:),'FontSize',10)
plot([min(min(TSMN_SITE)) min(min(TSMN_SITE))],[0 Hight],'Color',COLOR(2,:))
text(min(min(TSMN_SITE))+0.001,Hight,num2str(round(min(min(TSMN_SITE)),3)),'Color',COLOR(2,:),'FontSize',10)


%% Sampling bias
for i = 1:size(BPMN,1)
subplot(2,2,3);hold on
title('Sampling bias')
xlim([-0.6 0.6])
ylim([0 Hight_LOG])
MakeDistribution(((BPMN(i,:))),COLOR(3,:),'-',0,edge,h.Number);
end
for i = 1:size(BPMN_MDD,1)
subplot(2,2,3);hold on
MakeDistribution(((BPMN_MDD(i,:))),COLOR(4,:),'-',0,edge,h.Number);
end
for i = 1:size(BPMN_SCZ,1)
subplot(2,2,3);hold on
MakeDistribution(((BPMN_SCZ(i,:))),COLOR(6,:),'-',0,edge,h.Number);
end
H = gca;
legend(H.Children([23,11,3]),LABEL([3,4,6]),'FontSize',10)

plot([max(max(BPMN)) max(max(BPMN))],[0 Hight],'Color',COLOR(3,:))
text(max(max(BPMN))+0.001,Hight,num2str(round(max(max(BPMN)),3)),'Color',COLOR(3,:),'FontSize',10)
plot([min(min(BPMN)) min(min(BPMN))],[0 Hight],'Color',COLOR(3,:))
text(min(min(BPMN))+0.001,Hight,num2str(round(min(min(BPMN)),3)),'Color',COLOR(3,:),'FontSize',10)

plot([max(max(BPMN_MDD)) max(max(BPMN_MDD))],[0 Hight],'Color',COLOR(4,:))
text(max(max(BPMN_MDD))+0.001,Hight,num2str(round(max(max(BPMN_MDD)),3)),'Color',COLOR(4,:),'FontSize',10)
plot([min(min(BPMN_MDD)) min(min(BPMN_MDD))],[0 Hight],'Color',COLOR(4,:))
text(min(min(BPMN_MDD))+0.001,Hight,num2str(round(min(min(BPMN_MDD)),3)),'Color',COLOR(4,:),'FontSize',10)

plot([max(max(BPMN_SCZ)) max(max(BPMN_SCZ))],[0 Hight],'Color',COLOR(6,:))
text(max(max(BPMN_SCZ))+0.001,Hight,num2str(round(max(max(BPMN_SCZ)),3)),'Color',COLOR(6,:),'FontSize',10)
plot([min(min(BPMN_SCZ)) min(min(BPMN_SCZ))],[0 Hight],'Color',COLOR(6,:))
text(min(min(BPMN_SCZ))+0.001,Hight,num2str(round(min(min(BPMN_SCZ)),3)),'Color',COLOR(6,:),'FontSize',10)


%% Disorder factor
subplot(2,2,4);hold on
title('Disorder factor')
xlim([-0.6 0.6])
ylim([0 Hight_LOG])
MakeDistribution(((EF_MDD)),COLOR(5,:),'-',0,edge,h.Number);
MakeDistribution(((EF_SCZ)),COLOR(7,:),'-',0,edge,h.Number);
MakeDistribution(((EF_ASD)),COLOR(8,:),'-',0,edge,h.Number);
H = gca;
legend(H.Children([5 3 1]),LABEL([5 7 8]),'FontSize',10)

X = [0.02 0.06];
t = 1;
for i = [5,7,8]
switch i 
    case 5
        DATA = EF_MDD;
    case 7
        DATA = EF_SCZ;
    case 8
        DATA = EF_ASD;
end
plot([max(max(DATA)) max(max(DATA))],[0 Hight],'Color',COLOR(i,:))
text(max(max(DATA))+0.001,Hight,num2str(round(max(max(DATA)),3)),'Color',COLOR(i,:),'FontSize',10)
plot([min(min(DATA)) min(min(DATA))],[0 Hight],'Color',COLOR(i,:))
text(min(min(DATA))+0.001,Hight,num2str(round(min(min(DATA)),3)),'Color',COLOR(i,:),'FontSize',10)
t = t + 1;
end

%% Contribution size

%% load data
load([PATH,'data/COR_TravelingSubject.mat'])
load([PATH,'data/DATA_NOTUSE_TS.mat'])
X(OUT,:) = [];
X_TS = X;
load([PATH,'data/COR_SRPBS_UnifiedProtocol.mat'])
X_MD = X;
clear X
X = [X_TS;X_MD];

x_hat = DM*mn;
residual = (X-x_hat).^2;
mean_residual = mean(residual(:));

CONT_participant = DM(:,1:sub_num)*TSMN_SUB;
CONT_measurement = DM(:,sub_num+1:sub_num+mea_num)*TSMN_SITE;
CONT_asd = DM(:,sub_num+mea_num+1:sub_num+mea_num+1)*EF_ASD;
CONT_mdd = DM(:,sub_num+mea_num+2:sub_num+mea_num+2)*EF_MDD;
CONT_scz = DM(:,sub_num+mea_num+3:sub_num+mea_num+3)*EF_SCZ;
CONT_sampling_hc = DM(:,sub_num+mea_num+diag_num+1:sub_num+mea_num+diag_num+sah_num)*BPMN;
CONT_sampling_mdd = DM(:,sub_num+mea_num+diag_num+sah_num+1:sub_num+mea_num+diag_num+sah_num+sam_num)*BPMN_MDD;
CONT_sampling_scz = DM(:,sub_num+mea_num+diag_num+sah_num+sam_num+1:sub_num+mea_num+diag_num+sah_num+sam_num+sas_num)*BPMN_SCZ;

norm_coef = (CONT_participant.^2)+(CONT_measurement.^2)+(CONT_asd.^2)+(CONT_mdd.^2)+(CONT_scz.^2)+(CONT_sampling_hc.^2)+(CONT_sampling_mdd.^2)+(CONT_sampling_scz.^2)+residual;

CONT(1) = mean((CONT_participant(:).^2)./norm_coef(:))/sub_num;
CONT(2) = mean((CONT_measurement(:).^2)./norm_coef(:))/mea_num;
CONT(3) = mean((CONT_sampling_hc(:).^2)./norm_coef(:))/sah_num;
CONT(4) = mean((CONT_sampling_mdd(:).^2)./norm_coef(:))/sam_num;
CONT(5) = mean((CONT_mdd(:).^2)./norm_coef(:));
CONT(6) = mean((CONT_sampling_scz(:).^2)./norm_coef(:))/sas_num;
CONT(7) = mean((CONT_scz(:).^2)./norm_coef(:));
CONT(8) = mean((CONT_asd(:).^2)./norm_coef(:));

%% Figure Means
h = figure('Position',[1 26 500 1066]);
b = bar(diag(CONT),'stack');
title('Contribution size','FontSize',15)
colormap(COLOR)
for i = 1:length(b)
    b(i).EdgeColor = COLOR(i,:);
end
ylim([0 0.02])
legend(LABEL,'FontSize',15)
CONT(2)/CONT(1)