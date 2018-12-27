clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/'; %% CHANGE HERE!!

%% Make bias subtracted data. Subtract measurement bias only, or subtract sampling bias only.
% USEBIAS = 'SubtractMeasurementBias'; % SubtractMeasurementBias
USEBIAS = 'SubtractSamplingBias'; % SubtractSamplingBias

load([PATH,'data/COR_SRPBS_ALL_ORG.mat'])
Correlation = X';

for i = 1:length(IDLIST)
    ID = char(IDLIST(i,:));
    switch ID(1:3)
        case 'ATN'
            ANSWER_SITE(i) = 1; % ATR(Trio)
            ANSWER_PA(i) = 2; % PA
            ANSWER_SM(i) = 3; % Simens
        case 'ATR'
            switch ID(5:8)
                case 'Trio'
                    ANSWER_SITE(i) = 1; % ATR(Trio)
                    ANSWER_PA(i) = 2; % PA
                    ANSWER_SM(i) = 3; % Simens
                otherwise
                    ANSWER_SITE(i) = 2; % ATR(Verio)
                    ANSWER_PA(i) = 2; % PA
                    ANSWER_SM(i) = 3; % Simens
            end
        case 'UHI'
            switch ID(5:9)
                case 'Verio'
                    ANSWER_SITE(i) = 3; % COI
                    ANSWER_PA(i) = 1; % AP
                    ANSWER_SM(i) = 3; % Simens
                case 'Spect'
                    ANSWER_SITE(i) = 4; % HKH
                    ANSWER_PA(i) = 1; % AP
                    ANSWER_SM(i) = 3; % Simens
                case 'Signa'
                    ANSWER_SITE(i) = 5; % HUH
                    ANSWER_PA(i) = 2; % PA
                    ANSWER_SM(i) = 1; % GE
            end
        case 'KPM'
            ANSWER_SITE(i) = 6; % KFU
            ANSWER_PA(i) = 1; % AP
            ANSWER_SM(i) = 2; % Philips
        case 'UKY'
            ANSWER_SITE(i) = 7; % KUT
            ANSWER_PA(i) = 2; % PA
            ANSWER_SM(i) = 3; % Simens
        case 'SWA'
            ANSWER_SITE(i) = 8; % SWA
            ANSWER_PA(i) = 2; % PA
            ANSWER_SM(i) = 3; % Simens
        case 'UTO'
            ANSWER_SITE(i) = 9; % UTA
            ANSWER_PA(i) = 2; % PA
            ANSWER_SM(i) = 1; % GE
    end
end

switch USEBIAS
    case 'SubtractMeasurementBias'
        lambda = 11;
        load([PATH,'data/BIAS_Lambda',num2str(lambda),'.mat'])
        load([PATH,'data/DesignMatrix_SRPBS_ALL.mat']) % load designmatrix
        DM(1:397,:) = [];
        DM_USE = DM(:,10:23);
        BETA = mn(10:23,:);
    case 'SubtractSamplingBias'
        lambda = 11;
        load([PATH,'data/BIAS_Lambda',num2str(lambda),'.mat'])
        load([PATH,'data/DesignMatrix_SRPBS_ALL.mat']) % load designmatrix
        DM(1:397,:) = [];
        DM_USE = DM(:,27:42);
        BETA = mn(27:42,:); % mn = sub1-9, 'ATT' 'ATV' 'COI' 'HKH' 'HUH' 'KFU' 'KUS' 'KUT' 'SWA' 'UTA' 'YC1' 'YC2'
end
Correlation = Correlation-BETA'*DM_USE';
X = Correlation';

save(['/home/denbo3/ayumu/TravelingSubject/data/COR_SRPBS_ALL_',USEBIAS,'.mat'],'X','IDLIST','ANSWER_SITE','DATA_SUB')

