clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/'; % CHANGE HERE!!

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
mkdir([PATH,'code/Figure7/fig/'])
NUM_MOMENT = 2;
for ii = 1:5
    switch ii
        case 1
            USEBIAS = 'ORG';
        case 2
            USEBIAS = 'GLM';
        case 3
            USEBIAS = 'AGLM';
        case 4
            USEBIAS = 'ComBat';
        case 5
            USEBIAS = 'TS';
    end
    for i = 1:numfold
        load([PATH,'code/Figure7/Results/',USEBIAS,'/FOLD',num2str(i),'.mat'])
        mea_num = 12; % measurement bias
        sub_num = 9; % participant
        diag_num = 3; % diagnosis factor
        sah_num = 6; % sampling bias (HC)
        sam_num = 3; % sampling bias (MDD)
        sas_num = 3; % samplibg bias (SCZ)
        TSMN_SITE = mn(1:mea_num,:);
        TSMN_SUB = mn(mea_num+1:mea_num+sub_num,:);
        est_d = mn(mea_num+sub_num+1:mea_num+sub_num+diag_num,:);
        BPMN = mn(mea_num+sub_num+diag_num+1:mea_num+sub_num+diag_num+sah_num,:); % ATT, ATV, COI, SWA, UKY, UTO
        BPMN_MDD = mn(mea_num+sub_num+diag_num+sah_num+1:mea_num+sub_num+diag_num+sah_num+sam_num,:);% COI, UKY, UTO
        BPMN_SCZ = mn(mea_num+sub_num+diag_num+sah_num+sam_num+1:mea_num+sub_num+diag_num+sah_num+sam_num+sas_num,:); % SWA, UKY, UTO
        EF_ASD = mn(mea_num+sub_num+1,:);
        EF_MDD = mn(mea_num+sub_num+2,:);
        EF_SCZ = mn(mea_num+sub_num+3,:);
        CONST = mn(end,:);
        ALL_MOMENT(i,:,ii) = [mean(nthroot(moment(TSMN_SITE,NUM_MOMENT,2),NUM_MOMENT)),nthroot(moment(EF_ASD,NUM_MOMENT,2),NUM_MOMENT),nthroot(moment(EF_MDD,NUM_MOMENT,2),NUM_MOMENT),nthroot(moment(EF_SCZ,NUM_MOMENT,2),NUM_MOMENT),mean(nthroot(moment(TSMN_SUB,NUM_MOMENT,2),NUM_MOMENT)),mean(nthroot(moment(BPMN,NUM_MOMENT,2),NUM_MOMENT))];
        ALL_err(i,:,ii) = [std(nthroot(moment(TSMN_SITE,NUM_MOMENT,2),NUM_MOMENT)),nthroot(moment(EF_ASD,NUM_MOMENT,2),NUM_MOMENT),nthroot(moment(EF_MDD,NUM_MOMENT,2),NUM_MOMENT),nthroot(moment(EF_SCZ,NUM_MOMENT,2),NUM_MOMENT),std(nthroot(moment(TSMN_SUB,NUM_MOMENT,2),NUM_MOMENT)),std(nthroot(moment(BPMN,NUM_MOMENT,2),NUM_MOMENT))];
        INDEX(i,ii) = mean([ALL_MOMENT(i,2,ii),ALL_MOMENT(i,3,ii),ALL_MOMENT(i,4,ii)])/ALL_MOMENT(i,1,ii);
        INDEX2(i,ii) = ALL_MOMENT(i,5)/ALL_MOMENT(i,1,ii);
        INDEX3(i,ii) = ALL_MOMENT(i,6)/ALL_MOMENT(i,1,ii);
        switch i 
            case 1
        EACHPOINT(:,2*ii-1) = nthroot(moment(TSMN_SITE,NUM_MOMENT,2),NUM_MOMENT);
            case 2
        EACHPOINT(:,2*ii) = nthroot(moment(TSMN_SITE,NUM_MOMENT,2),NUM_MOMENT);
        end
    end
end
ALL_MEASUREMENT =  squeeze(ALL_MOMENT(:,1,:));
ALL_MEASUREMENT_err =  squeeze(ALL_err(:,1,:));


figure('Position',[100 100 1700 600])
subplot(1,3,1)
bar(ALL_MEASUREMENT');hold on
ylim([0 0.06])
set(gca,'XTickLabel',{'ORG','GLM','AGLM','ComBat','TS'})
title('Measurement bias')
subplot(1,3,2)
bar(INDEX2');hold on
ylim([0 2.5])
set(gca,'XTickLabel',{'ORG','GLM','AGLM','ComBat','TS'})
title('Participant effect / Measurement bias')
subplot(1,3,3)
bar(INDEX');hold on
set(gca,'XTickLabel',{'ORG','GLM','AGLM','ComBat','TS'})
title('Disorder effect / Measurement bias')
[p,h,stats] = ranksum(ALL_MEASUREMENT(:,1),ALL_MEASUREMENT(:,5),'method','exact')
[p,h,stats] = ranksum(ALL_MEASUREMENT(:,4),ALL_MEASUREMENT(:,5),'method','exact')

[p,h,stats] = ranksum(INDEX2(:,1),INDEX2(:,5),'method','exact')
[p,h,stats] = ranksum(INDEX2(:,4),INDEX2(:,5),'method','exact')

[p,h,stats] = ranksum(INDEX(:,1),INDEX(:,5),'method','exact')
[p,h,stats] = ranksum(INDEX(:,4),INDEX(:,5),'method','exact')

saveas(gca,[PATH,'code/Figure7/fig/Results.pdf'])

100*abs(ALL_MEASUREMENT(1,1)-ALL_MEASUREMENT(1,5))/ALL_MEASUREMENT(1,1)
100*abs(ALL_MEASUREMENT(2,1)-ALL_MEASUREMENT(2,5))/ALL_MEASUREMENT(2,1)
100*abs(INDEX2(1,1)-INDEX2(1,5))/INDEX2(1,1)
100*abs(INDEX2(2,1)-INDEX2(2,5))/INDEX2(2,1)
100*abs(INDEX(1,1)-INDEX(1,5))/INDEX(1,1)
100*abs(INDEX(2,1)-INDEX(2,5))/INDEX(2,1)

100*abs(ALL_MEASUREMENT(1,1)-ALL_MEASUREMENT(1,4))/ALL_MEASUREMENT(1,1)
100*abs(ALL_MEASUREMENT(2,1)-ALL_MEASUREMENT(2,4))/ALL_MEASUREMENT(2,1)
100*abs(INDEX2(1,1)-INDEX2(1,4))/INDEX2(1,1)
100*abs(INDEX2(2,1)-INDEX2(2,4))/INDEX2(2,1)
100*abs(INDEX(1,1)-INDEX(1,4))/INDEX(1,1)
100*abs(INDEX(2,1)-INDEX(2,4))/INDEX(2,1)


figure('Position',[100 100 1700 600])
subplot(1,3,1)
bar(reshape(ALL_MEASUREMENT,1,10));hold on
errorbar(reshape(ALL_MEASUREMENT,1,10),reshape(ALL_MEASUREMENT_err,1,10),'LineStyle','none')

scatter(ones(12,1),EACHPOINT(:,1),40,[1 1 1],'filled','o','MarkerEdgeColor','k')
scatter(2*ones(12,1),EACHPOINT(:,2),40,[1 1 1],'filled','o','MarkerEdgeColor','k')
scatter(3*ones(12,1),EACHPOINT(:,3),40,[1 1 1],'filled','o','MarkerEdgeColor','k')
scatter(4*ones(12,1),EACHPOINT(:,4),40,[1 1 1],'filled','o','MarkerEdgeColor','k')
scatter(5*ones(12,1),EACHPOINT(:,5),40,[1 1 1],'filled','o','MarkerEdgeColor','k')
scatter(6*ones(12,1),EACHPOINT(:,6),40,[1 1 1],'filled','o','MarkerEdgeColor','k')
scatter(7*ones(12,1),EACHPOINT(:,7),40,[1 1 1],'filled','o','MarkerEdgeColor','k')
scatter(8*ones(12,1),EACHPOINT(:,8),40,[1 1 1],'filled','o','MarkerEdgeColor','k')
scatter(9*ones(12,1),EACHPOINT(:,9),40,[1 1 1],'filled','o','MarkerEdgeColor','k')
scatter(10*ones(12,1),EACHPOINT(:,10),40,[1 1 1],'filled','o','MarkerEdgeColor','k')

saveas(gca,[PATH,'code/Figure7/fig/WithScatter.pdf'])
