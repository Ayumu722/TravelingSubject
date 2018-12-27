clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/'; % CHANGE HERE!!

%% PLOT Original
USEDATA = 'ORG'; %  use data not modified
% USEDATA = 'SubtractMeasurementBias'; % use measurement bias subtracted data 
% USEDATA = 'SubtractSamplingBias'; % use sampling bias subtracted data 

load([PATH,'data/COR_SRPBS_ALL_',USEDATA,'.mat'])
LABEL = {'ATT','ATV','COI','HKH','HUH','KPM','KUT','SWA','UTO'};
ALLSITE = DATA_SUB(:,2);
NC = size(X,2);

subnum = size(ALLSITE,1);
for i = 1:subnum
    SITE(i,:) = LABEL(ALLSITE(i));
end

for i = 1:NC
    disp(['Now ',num2str(100*i/NC)])
    [p(i,:),tbl,stats{i}] = anovan(X(:,i),{SITE},'display','off');
%     f_org(i,:) = cell2mat(tbl(2:4,6))';
end

SIGNUM = sum(p<(0.05/NC))
100*SIGNUM/NC

