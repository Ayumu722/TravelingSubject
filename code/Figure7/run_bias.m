clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/';% CHANGE HERE!!

TARGET = {'ORG','GLM', 'AGLM', 'TS', 'ComBat'};

for i = 1:length(TARGET)
    mkdir([PATH,'code/Figure7/Results/',TARGET{i}])
    if strcmp(TARGET{i},'ORG')
    else
        BiasEstimation_First(TARGET{i})
    end
    BiasEstimation_Second(TARGET{i})
    
end

