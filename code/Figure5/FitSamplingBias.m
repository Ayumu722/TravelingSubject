function FitSamplingBias()

PATH = '/home/denbo3/ayumu/TravelingSubject/'; %% CHANGE HERE

%% set parameter
lambda = 14;
DATA = load([PATH,'code/Figure2/BIAS_Lambda',num2str(lambda),'.mat']);
BPMN = DATA.mn(25:30,:); % ATT, ATV, COI, SWA, UKY, UTO
Y = var(BPMN,0,2);
X = [31,77,9,35,39,140]';
U = log10(Y);
S = log10(X);

w0_1 = 0.1;
[w_new_1,fval] = fminunc(@(w)fun3(w,U,S),w0_1)
w0_2 = [0.1,0.1];
[w_new_2,fval] = fminunc(@(w)fun4(w,U,S),w0_2);

Ypre1 = w_new_1(1)./X';
Ypre2 = w_new_2(1)./X'+w_new_2(2);
 
AIC1 = sum(log((Ypre1'-Y).^2))+2*1;
AIC2 = sum(log((Ypre2'-Y).^2))+2*2;
BIC1 = sum(log((Ypre1'-Y).^2))+log(6)
BIC2 = sum(log((Ypre2'-Y).^2))+2*log(6)
AICc1 = AIC1 + 2*1*(1+1)/(6-1-1)
AICc2 = AIC2 + 2*2*(2+1)/(6-2-1)

SiteNum = 300;
SubNum = 1:SiteNum;

figure
scatter(X,Y)
hold on
plot(SubNum,w_new_1(1)./SubNum)
plot(SubNum,(w_new_2(1)./SubNum+w_new_2(2)))
set(gca,'XScale','Log')
set(gca,'YScale','Log')
ylim([0.0001 0.1])
xlim([1 300])


function val = fun1(w,x,y)
val = sum((y-w(1)*x.^(-1)).^2);
end

function val = fun2(w,x,y)
val = sum((y-(w(1)*(x.^(-1))+w(2))).^2);
end

function val = fun3(w,u,s)
val = sum((u+s-log10(w(1))).^2);
end

function val = fun4(w,u,s)
val = sum((u-log10(w(1)*10.^(-s)+w(2))).^2);
end


end