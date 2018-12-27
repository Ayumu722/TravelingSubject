clear all

COLOR = [120,120,120;250,230,0;255,153,0;53,161,107;0,65,255;255,40,0]/255;
figure;hold on
for i = 1:6
[x,Yte(i),s,Ute(i),Ypre1(i),Upre1(i),Ypre2(i),Upre2(i)] = FitSamplingBias_CV(i);
RMSE(i,1) = sqrt(mean((Yte(i)-Ypre1(i)).^2));
RMSE(i,2) = sqrt(mean((Yte(i)-Ypre2(i)).^2));

scatter(1,RMSE(i,1),50,COLOR(i,:),'^')
scatter(2,RMSE(i,2),50,COLOR(i,:),'s','filled')
plot([RMSE(i,1);RMSE(i,2)],'Color',COLOR(i,:))
end
set(gca,'XTick',[1,2],'XTickLabel',{'With sampling bias','Without sampling bias'})
xlim([0.5 2.5])

figure;hold on% subplot(1,2,2);hold on
x = 0:0.0001:0.004;
for i = 1:6
scatter(Yte(i),Ypre2(i),50,COLOR(i,:),'s','filled');
scatter(Yte(i),Ypre1(i),50,COLOR(i,:),'^');
end
plot(x,x)
xlabel('Actual value')
ylabel('Prediction value')
legend('With sampling bias','Without sampling bias')
axis square
xlim([0 0.004]);ylim([0 0.004])

[p,h,stat] = signrank(RMSE(:,1),RMSE(:,2),'tail','right')