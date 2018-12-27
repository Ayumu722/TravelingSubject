clear all

MARKER_COLOR = parula(9);


load('/home/denbo3/ayumu/TravelingSubject/data/COR_TravelingSubject.mat')
subinfo = tdfread('/home/denbo3/ayumu/TravelingSubject/code/NewAnalysis/TravelingSubject.tsv', '\t' );

ALLSUB = cellstr(subinfo.Subject);
ALLSITE = cellstr(subinfo.Site);
SUB_ID = unique(ALLSUB);
SITE_ID = unique(ALLSITE);

COR = zeros(9,2);
for N = 1:size(SUB_ID,1)
ID = SUB_ID{N};
WITHIN = strcmp(ID,ALLSUB)&strcmp('ATT',ALLSITE);
BETWEEN = strcmp(ID,ALLSUB)&(strcmp('ATT',ALLSITE)==0);
COR_tmp = corr(X(WITHIN,:)');
USECON = tril(ones(size(COR_tmp)),-1);
COR(N,1) = mean(COR_tmp(USECON==1));

COR_tmp = corr(X(BETWEEN,:)');
USECON = tril(ones(size(COR_tmp)),-1);
COR(N,2) = mean(COR_tmp(USECON==1));

end

figure;hold on
bar(mean(COR))
for N = 1:size(SUB_ID,1)
    scatter(1,COR(N,1),'MarkerFaceColor',MARKER_COLOR(N,:),'MarkerEdgeColor',MARKER_COLOR(N,:));
    scatter(2,COR(N,2),'MarkerFaceColor',MARKER_COLOR(N,:),'MarkerEdgeColor',MARKER_COLOR(N,:));
    plot([1,2],[COR(N,1),COR(N,2)],'Color',MARKER_COLOR(N,:));   
end
xlim([0.5 2.5])
xticks([1,2])
xticklabels({'WithinSite','BetweenSite'})