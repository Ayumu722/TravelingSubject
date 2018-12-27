function [Xte,Yte,Ste,Ute,Ypre1,Upre1,Ypre2,Upre2] = FitSamplingBias_CV(EXCLUDE)
%% set parameter
lambda = 14;
DATA = load(['/home/denbo3/ayumu/TravelingSubject/code/Figure2/BIAS_Lambda',num2str(lambda),'.mat']); %% CHANGE HERE
BPMN = DATA.mn(25:30,:); % ATT, ATV, COI, UKY, SWA, UTO
Y = var(BPMN,0,2);
X = [31,77,9,35,39,140]';

Yte = Y(EXCLUDE);Y(EXCLUDE) = [];
Xte = X(EXCLUDE);X(EXCLUDE) = [];

U = log10(Y);Ute = log10(Yte);
S = log10(X);Ste = log10(Xte);

w0_1 = 0.1;
[w_new_1,fval] = fminunc(@(w)fun3(w,U,S),w0_1);
w0_2 = [0.1,0.1];
[w_new_2,fval] = fminunc(@(w)fun4(w,U,S),w0_2);

Ypre1 = w_new_1(1)*Xte.^(-1);
Ypre2 = w_new_2(1)*Xte.^(-1)+w_new_2(2);
Upre1 = log10(Ypre1);
Upre2 = log10(Ypre2);



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