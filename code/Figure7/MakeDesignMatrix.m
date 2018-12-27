clear all

PATH = '/home/denbo3/ayumu/TravelingSubject/'; % CHANGE HERE!!

IDLIST = textread([PATH,'code/Figure7/ID.lst'], '%s' );
DIVIDEID = csvread([PATH,'code/Figure7/DivideID.csv']);
load([PATH,'data/DATA_NOTUSE_TS.mat'])
IDLIST(OUT,:) = [];
DIVIDEID(OUT) = [];
for i = 1:length(IDLIST)
    ID = char( IDLIST(i) );
    data.SITE(i,:) = {ID(1:3)};
    switch ID(1:3)
        case {'ATT','ATV','CIN','HKH','KUS','KUT','SWA','COI'}
            data.SM(i,:) = {'SI'};
        case {'HUH','UTA'}
            data.SM(i,:) = {'GE'};
        case {'KFU','YC1','YC2'}
            data.SM(i,:) = {'PH'};
    end
    switch ID(1:3)
        case {'COI','KUS','KFU','YC1','YC2'}
            data.PA(i,:) = {'AP'};
        otherwise
            data.PA(i,:) = {'PA'};
    end
    switch ID(1:3)
        case {'ATT','ATV','HKH','SWA','COI'}
            data.COIL(i,:) = {'COIL12'};
        case {'KUS','KUT'}
            data.COIL(i,:) = {'COIL32'};
        case {'UTA'}
            data.COIL(i,:) = {'COIL24'};
        case {'KFU','YC1','YC2','HUH'}
            data.COIL(i,:) = {'COIL8'};
    end
    switch ID(1:3)
        case {'ATV','SWA','COI'}
            data.SCAN(i,:) = {'Verio'};
        case {'KUS'}
            data.SCAN(i,:) = {'Skyra'};
        case {'HUH'}
            data.SCAN(i,:) = {'Signa'};
        case {'ATT','KUT'}
            data.SCAN(i,:) = {'Trio'};
         case {'HKH'}
            data.SCAN(i,:) = {'Spectra'};
        case {'KFU','YC1','YC2'}
            data.SCAN(i,:) = {'Achieva'};
        case {'UTA'}
            data.SCAN(i,:) = {'MR'};
    end
    data.SAM(i,:) = {''};
    data.SUB(i,:) = {ID(6:7)};
    data.SEX(i,:) = {'MAN'};
    data.DIAG(i,:) = {''};
    
    switch ID(6:7)
        case {'YO'}
            AGE(i,:) =24;
        case {'AY','KS'}
            AGE(i,:) =25;
        case {'YT','MH'}
            AGE(i,:) =26;
        case {'MY'}
            AGE(i,:) =27;
        case {'RO'}
            AGE(i,:) =28;
        case {'ST'}
            AGE(i,:) =30;
        case {'SC'}
            AGE(i,:) =32;
    end
end


%% DM Multi-site data
load([PATH,'data/COR_SRPBS_UnifiedProtocol.mat'])
DATA = DATA_SUB;
clear USESUB

t = 1;
for i = length(data.SITE)+1:length(data.SITE)+length(IDLIST)
    ID = char( IDLIST(t) );
    switch ID(1:3)
        case 'ATR'
            switch ID(5:8)
                case 'Trio'
                    data.SM(i,:) = {'SI'};
                    data.SITE(i,:) = {'ATT'};
                    data.SCAN(i,:) = {'Trio'};
                case 'Veri'
                    data.SM(i,:) = {'SI'};
                    data.SITE(i,:) = {'ATV'};
                    data.SCAN(i,:) = {'Verio'};
            end
            data.COIL(i,:) = {'COIL12'};
            data.PA(i,:) = {'PA'};
        case 'ATN'
            data.SM(i,:) = {'SI'};
            data.SITE(i,:) = {'ATT'};
            data.PA(i,:) = {'PA'};
            data.SCAN(i,:) = {'Trio'};
            data.COIL(i,:) = {'COIL12'};
        case 'KPM'
            data.SM(i,:) = {'PH'};
            data.SITE(i,:) = {'KFU'};
            data.PA(i,:) = {'AP'};
            data.SCAN(i,:) = {'Achieva'};
            data.COIL(i,:) = {'COIL8'};
        case 'SWA'
            data.SM(i,:) = {'SI'};
            data.SITE(i,:) = {'SWA'};
            data.PA(i,:) = {'PA'};
            data.SCAN(i,:) = {'Verio'};
            data.COIL(i,:) = {'COIL12'};
        case 'UTO'
            data.SM(i,:) = {'GE'};
            data.SITE(i,:) = {'UTA'};
            data.PA(i,:) = {'PA'};
            data.SCAN(i,:) = {'MR'};
            data.COIL(i,:) = {'COIL24'};
        case 'UKY'
            data.SM(i,:) = {'SI'};
            data.SITE(i,:) = {'KUT'};
            data.PA(i,:) = {'PA'};
            data.SCAN(i,:) = {'Trio'};
            data.COIL(i,:) = {'COIL32'};
       case 'UHI'
            switch ID(5:9)
                case 'Signa'
                    data.SM(i,:) = {'GE'};
                    data.SITE(i,:) = {'HUH'};
                    data.PA(i,:) = {'PA'};
                    data.SCAN(i,:) = {'Signa'};
                    data.COIL(i,:) = {'COIL8'};
                case 'Spect'
                    data.SM(i,:) = {'SI'};
                    data.SITE(i,:) = {'HKH'};
                    data.PA(i,:) = {'AP'};
                    data.SCAN(i,:) = {'Spectra'};
                    data.COIL(i,:) = {'COIL12'};
                case 'Verio'
                    data.SM(i,:) = {'SI'};
                    data.SITE(i,:) = {'COI'};
                    data.PA(i,:) = {'AP'};
                    data.SCAN(i,:) = {'Verio'};
                    data.COIL(i,:) = {'COIL8'};
            end
    end
    AGE(i,:) = DATA(t,3);
    data.SUB(i,:) = {''};
    if DATA(t,4) == 0
        data.SEX(i,:) = {'MAN'};
    elseif DATA(t,4) == 1
        data.SEX(i,:) = {'WOMAN'};
    end
    
    switch DATA(t,1)
        case 0
            data.DIAG(i,:) = {''};
            switch ID(1:3)
                case {'ATR','ATN'}
                    switch ID(5:8)
                        case 'Trio'
                            data.SAM(i,:) = {'HC_ATT'};
                        case 'Veri'
                            data.SAM(i,:) = {'HC_ATV'};
                    end
                case 'KPM'
                    data.SAM(i,:) = {'HC_KFU'};
                case 'SWA'
                    data.SAM(i,:) = {'HC_SWA'};
                case 'UTO'
                    data.SAM(i,:) = {'HC_UTA'};
                case 'UKY'
                    data.SAM(i,:) = {'HC_KUT'};
                case 'UHI'
                    switch ID(5:9)
                        case 'Signa'
                            data.SAM(i,:) = {'HC_HUH'};
                        case 'Spect'
                            data.SAM(i,:) = {'HC_HKH'};
                        case 'Verio'
                            data.SAM(i,:) = {'HC_COI'};
                    end
            end
        case 1
            data.DIAG(i,:) = {'ASD'};
            data.SAM(i,:) = {''};
        case 2
            data.DIAG(i,:) = {'MDD'};
            switch ID(1:3)
                case {'ATR','ATN'}
                    switch ID(5:8)
                        case 'Trio'
                            data.SAM(i,:) = {'MDD_ATT'};
                        case 'Veri'
                            data.SAM(i,:) = {'MDD_ATV'};
                    end
                case 'KPM'
                    data.SAM(i,:) = {'MDD_KFU'};
                case 'SWA'
                    data.SAM(i,:) = {'MDD_SWA'};
                case 'UTO'
                    data.SAM(i,:) = {'MDD_UTA'};
                case 'UKY'
                    data.SAM(i,:) = {'MDD_KUT'};
                case 'UHI'
                    switch ID(5:9)
                        case 'Signa'
                            data.SAM(i,:) = {'MDD_HU'};
                        case 'Spect'
                            data.SAM(i,:) = {'MDD_HKH'};
                        case 'Verio'
                            data.SAM(i,:) = {'MDD_COI'};
                    end
            end
        case 3
            data.DIAG(i,:) = {'OCD'};
            switch ID(1:3)
                case {'ATR','ATN'}
                    switch ID(5:8)
                        case 'Trio'
                            data.SAM(i,:) = {'OCD_ATT'};
                        case 'Veri'
                            data.SAM(i,:) = {'OCD_ATV'};
                    end
                case 'KPM'
                    data.SAM(i,:) = {'OCD_KFU'};
                case 'SWA'
                    data.SAM(i,:) = {'OCD_SWA'};
                case 'UTO'
                    data.SAM(i,:) = {'OCD_UTA'};
                case 'UKY'
                    data.SAM(i,:) = {'OCD_KUT'};
                case 'UHI'
                    switch ID(5:9)
                        case 'Signa'
                            data.SAM(i,:) = {'OCD_HU'};
                        case 'Spect'
                            data.SAM(i,:) = {'OCD_HKH'};
                        case 'Verio'
                            data.SAM(i,:) = {'OCD_COI'};
                    end
            end
        case 4
            data.DIAG(i,:) = {'SCZ'};
            switch ID(1:3)
                case {'ATR','ATN'}
                    switch ID(5:8)
                        case 'Trio'
                            data.SAM(i,:) = {'SCZ_ATT'};
                        case 'Veri'
                            data.SAM(i,:) = {'SCZ_ATV'};
                    end
                case 'KPM'
                    data.SAM(i,:) = {'SCZ_KFU'};
                case 'SWA'
                    data.SAM(i,:) = {'SCZ_SWA'};
                case 'UTO'
                    data.SAM(i,:) = {'SCZ_UTA'};
                case 'UKY'
                    data.SAM(i,:) = {'SCZ_KUT'};
                case 'UHI'
                    switch ID(5:9)
                        case 'Signa'
                            data.SAM(i,:) = {'SCZ_HUH'};
                        case 'Spect'
                            data.SAM(i,:) = {'SCZ_HKH'};
                        case 'Verio'
                            data.SAM(i,:) = {'SCZ_COI'};
                    end
            end
    end
    t = t + 1;
end

tmp = fieldnames(data);
for i = 1:length(tmp)
    eval(['dv.',tmp{i},' = dummyvar(nominal(data.',tmp{i},'));'])
    eval(['dv.',tmp{i},'(isnan(dv.',tmp{i},'))=0;'])
    eval(['label.',tmp{i},' = unique(data.',tmp{i},');'])
    if eval(['size(dv.',tmp{i},',2) ~= length(label.',tmp{i},')'])
        eval(['label.',tmp{i},'(1) = [];'])
    end
end


%% not include sex and age
DM.TS = [dv.SITE,dv.SUB,dv.DIAG,dv.SAM];
LABEL.TS =  [label.SITE;label.SUB;label.DIAG;label.SAM];

DM.GLM = dv.SITE;
LABEL.GLM = label.SITE;

DM.AGLM = [dv.SITE,dv.DIAG];
LABEL.AGLM =  [label.SITE;label.DIAG];

for i = 1:size(dv.SITE,1)
    batch(i) = find(dv.SITE(i,:));
end
DM.COMBAT.mod  = [dv.DIAG+1]';
DM.COMBAT.batch  = batch;
LABEL.COMBAT.mod =  label.DIAG;
LABEL.COMBAT.batch =  label.SITE;


save([PATH,'code/Figure7/DesignMatrix.mat'],'DM','LABEL','DATA','DIVIDEID')

