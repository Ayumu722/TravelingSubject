function MakeDistribution(DATA,Color,Line,Hight,edge,FigNum)
figure(FigNum);
h = histogram(DATA,'BinEdge',edge,'Visible','off');
h.Normalization = 'probability';
% h.BinWidth = BinWidth;
X = h.BinEdges(1:end-1)+diff(h.BinEdges)/2;
Y = h.Values;
plot(X,Y,'Color',Color,'LineStyle',Line,'LineWidth',1.5)
if Hight > 0
plot([median(DATA) median(DATA)],[0 Hight],':','Color',Color)
text(median(DATA)+0.001,Hight,num2str(round(median(DATA),3)),'Color',Color,'FontSize',20)
end
return;
