% GeneralizableAnalysisPapaScript
% This script is a "papa script" that builds decoders, saves actual and
% predicted EMG, and then makes and saves figures in the appropriate
% folders so that I can just open a folder and look at summary figures/data
% for that day.

clear
%Step 1a: Initialize folders
monkeyname = 'Kevin';
HybridEMGlist=Kevin_HybridData_EMGQualityInfo();
BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Kevin\';
SubFolder={'05-15-15','05-19-15s','05-21-15s','05-25-15s','05-26-15s','06-03-15','06-04-15s','06-06-15','06-08-15'};
SubFolder={'05-19-15s','05-21-15s','05-25-15s','05-26-15s','06-04-15s'};
SubFolder = {'05-19-15s'};

%monkeyname = 'Jango';
%HybridEMGlist=Jango_HybridData_EMGQualityInfo();
%BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Jango\';
% % % SubFolder = {'07-23-14','07-24-14s','07-25-14s','08-19-14s','08-20-14s'...
% % %    '08-21-14s','09-23-14s','09-25-14','09-26-14','10-10-14s','10-11-14s'...
% % %    '10-12-14s','11-06-14','11-07-14'};
% SubFolder = {'07-24-14s','07-25-14s', '08-19-14s', '08-20-14s',...
   %'08-21-14s','09-23-14s','10-10-14s','10-11-14s'...
   %'10-12-14s'};
  % SubFolder = {'10-12-14s'};
% SubFolder = {'07-24-14s','07-25-14s', '08-21-14s','09-23-14s'};
   %8/19, 8/20 each missing a fold (4)
   
for z = 1:length(SubFolder)
    % Step 1b:  Load data into workspace | Open folder directory for saving figs 
    cd([BaseFolder SubFolder{z} '\']);
    foldername = [BaseFolder SubFolder{z} '\'];
    hyphens = find(SubFolder{z}=='-'); SubFolder{z}(hyphens)=[];
    load([foldername 'HybridData_' monkeyname '_' SubFolder{z}(1,1:6)]);
    datalabel = SubFolder{z}(1:6);

% Initialize springfile variable
if SubFolder{z}(end)=='s'
    SpringFile = 1;
else SpringFile = 0;
end

% Find the right EMGlist
% Only keep EMG data for the 4 wrist muscles
EMGlistIndex = find(strcmp(HybridEMGlist,datalabel));
binnedData = IsoBinned;
IsoBinned.emgguide = cellstr(IsoBinned.emgguide); WmBinned.emgguide = cellstr(WmBinned.emgguide);
for j=1:length(HybridEMGlist{EMGlistIndex,2})
    EMGindtemp = strmatch(HybridEMGlist{EMGlistIndex,2}(j,:),(binnedData.emgguide)); emg_vector(j) = EMGindtemp(1);
end
IsoBinned.emgguide = IsoBinned.emgguide(emg_vector); IsoBinned.emgdatabin = IsoBinned.emgdatabin(:,emg_vector);
WmBinned.emgguide = WmBinned.emgguide(emg_vector); WmBinned.emgdatabin = WmBinned.emgdatabin(:,emg_vector);
if SpringFile == 1
    SprBinned.emgguide = cellstr(SprBinned.emgguide);
    SprBinned.emgguide = SprBinned.emgguide(emg_vector); SprBinned.emgdatabin = SprBinned.emgdatabin(:,emg_vector);
end

% Normalize EMGs according to the biggest EMG across all 3 tasks
%Or across both tasks, if there isn't a spring session for that day
if SpringFile == 1
    [IsoEMGsNormed WmEMGsNormed SprEMGsNormed] = NormalizeGeneralizableEMGs(IsoBinned.emgdatabin,WmBinned.emgdatabin,SprBinned.emgdatabin, SpringFile);
    IsoBinned.emgdatabin = IsoEMGsNormed; WmBinned.emgdatabin = WmEMGsNormed; SprBinned.emgdatabin = SprEMGsNormed;
else
    [IsoEMGsNormed WmEMGsNormed] = NormalizeGeneralizableEMGs(IsoBinned.emgdatabin,WmBinned.emgdatabin,1, SpringFile);
    IsoBinned.emgdatabin = IsoEMGsNormed; WmBinned.emgdatabin = WmEMGsNormed;
end



% Make and save figures showing the EMGs for the 3 different tasks
save = 0;
%First List of EMGs
% TaskEMG_Isometric(IsoBinned,'FCU', 'FCR', 'ECU', 'ECR',save,foldername,'IsoEMGs1');
% TaskEMG_Movement(WmBinned,'FCU', 'FCR', 'ECU', 'ECR',save,foldername,'WmEMGs1');
% if SpringFile == 1
%     TaskEMG_Spring(SprBinned,'FCU', 'FCR', 'ECU', 'ECR',save,foldername,'SprEMGs1');
% end


% Step 3: make and save predictions
BuildDecodersMakePredictions_July2016
%BuildDecodersMakePredictions_NoFolds

% Plot individual EMG predictions
% The VAFs reported are now the VAF for that actual segment
% for emgInd=1:length(WmBinned.emgdatabin(1,:))
%     PlotAllIsometricPredictions(IsoBinned,IsoTest,IonIactTrunk,HonIpred.preddatabin,IonIpred.preddatabin,WonIpred.preddatabin,VAFstruct,emgInd,save,foldername, [monkeyname '_' datalabel 'IsoPredictions'])
%     PlotAllMovementPredictions(WmBinned,WmTest,WonWactTrunk,HonWpred.preddatabin,WonWpred.preddatabin,IonWpred.preddatabin,VAFstruct,emgInd,save,foldername, [monkeyname '_' datalabel 'WmPredictions'])
%     if SpringFile == 1
%         PlotAllSpringPredictions(SprBinned,SprTest,SonSactTrunk,SonSpred.preddatabin,HonSpred.preddatabin,IonSpred.preddatabin,WonSpred.preddatabin, VAFstruct,emgInd,save,foldername, 'SprPredictions')
%         PlotAllIsometricPredictionsWithH3(IsoBinned,IsoTest,IonIactTrunk,HonIpred.preddatabin,IonIpred.preddatabin,WonIpred.preddatabin,H3onIpred.preddatabin,VAFstruct,save,foldername, [monkeyname '_' datalabel 'IsoPredictionsWithH3'])
%         PlotAllMovementPredictionsWithH3(WmBinned,WmTest,WonWactTrunk,HonWpred.preddatabin,WonWpred.preddatabin,IonWpred.preddatabin,H3onWpred.preddatabin,VAFstruct,emgInd,save,foldername, [monkeyname '_' datalabel 'WmPredictionsWithH3'])
%     end
% end

% Make mega VAF struct
if z == 1
    MegaVAFstruct = VAFstruct;
    else
    MegaVAFstruct = [MegaVAFstruct VAFstruct];
end


% Make mega VAF struct - commented out when i tried the noFolds code, can
% uncomment when I bring the folds back
if z == 1
    MegaVAFstruct = VAFstruct;
    MegaIndivVAFstruct = IndivVAFstruct;
    AllDaysIonI=IonI_vaf;  AllDaysWonW=WonW_vaf;
    AllDaysWonI=WonI_vaf;  AllDaysIonW=IonW_vaf;
    AllDaysHonI=HonI_vaf;  AllDaysHonW=HonW_vaf;
    if SpringFile == 1 
        AllDaysSonS=SonS_vaf;
        AllDaysIonS=IonS_vaf;
        AllDaysWonS=WonS_vaf;
        AllDaysHonS=HonS_vaf;
        AllDaysSonI=SonI_vaf;
        AllDaysSonW=SonW_vaf;
        AllDaysH3onS=H3onS_vaf; AllDaysH3onW=H3onW_vaf; AllDaysH3onI=H3onI_vaf;
    end
else
    MegaVAFstruct = [MegaVAFstruct VAFstruct];
    MegaIndivVAFstruct = [MegaIndivVAFstruct IndivVAFstruct];
    AllDaysIonI=cat(1,AllDaysIonI,IonI_vaf); AllDaysWonW=cat(1,AllDaysWonW,WonW_vaf);
    AllDaysWonI=cat(1,AllDaysWonI,WonI_vaf); AllDaysIonW=cat(1,AllDaysIonW,IonW_vaf);
    AllDaysHonI=cat(1,AllDaysHonI,HonI_vaf); AllDaysHonW=cat(1,AllDaysHonW,HonW_vaf);
    if SpringFile == 1
    AllDaysSonS=cat(1,AllDaysSonS,SonS_vaf); AllDaysWonS=cat(1,AllDaysWonS,WonS_vaf);
    AllDaysIonS=cat(1,AllDaysIonS,IonS_vaf); AllDaysHonS=cat(1,AllDaysHonS,HonS_vaf);
    AllDaysH3onI=cat(1,AllDaysH3onI,H3onI_vaf); AllDaysH3onW=cat(1,AllDaysH3onW,H3onW_vaf);   
    AllDaysH3onS=cat(1,AllDaysH3onS,H3onS_vaf);    
    AllDaysSonI=cat(1,AllDaysSonI,SonI_vaf); AllDaysSonW=cat(1,AllDaysSonW,SonW_vaf);
    end
end

AllIsoFits(z)=IsoFitVAF; AllWmFits(z) = WmFitVAF; AllSprFits(z) = SprFitVAF;



% Clear variables
clearvars -except monkeyname BaseFolder SubFolder meanHonI_PC_mse meanIonI_PC_mse meanWonI_PC_mse meanHonW_PC_mse meanWonW_PC_mse meanIonW_PC_mse...
    stdHonI_PC_mse stdIonI_PC_mse stdWonI_PC_mse stdHonW_PC_mse stdWonW_PC_mse stdIonW_PC_mse meanHonS_PC_mse meanIonS_PC_mse meanWonS_PC_mse meanSonS_PC_mse ...
        stdHonS_PC_mse stdIonS_PC_mse stdWonS_PC_mse stdSonS_PC_mse z MegaVAFstruct MegaIndivVAFstruct  HybridEMGlist ...
        AllDaysIonI AllDaysWonW AllDaysWonI AllDaysIonW AllDaysHonI AllDaysHonW AllDaysSonS AllDaysIonS AllDaysWonS AllDaysHonS ...
        AllDaysH3onS AllDaysH3onI AllDaysH3onW AllDaysSonI AllDaysSonW AllIsoFits AllWmFits AllSprFits



end

%close all
save = 0;foldername = '';
for a=1:length(SubFolder)
   % PlotVAFAcrossDays(a,1000,MegaVAFstruct(a).IonI_vaf_mean, MegaVAFstruct(a).IonI_vaf_ste, MegaVAFstruct(a).HonI_vaf_mean, MegaVAFstruct(a).HonI_vaf_ste, MegaVAFstruct(a).WonI_vaf_mean, MegaVAFstruct(a).WonI_vaf_ste, save,foldername, [monkeyname ' | ', ' Iso VAFs Across Days'])
    %PlotVAFAcrossDays(a,1001,MegaVAFstruct(a).WonW_vaf_mean, MegaVAFstruct(a).WonW_vaf_ste, MegaVAFstruct(a).HonW_vaf_mean, MegaVAFstruct(a).HonW_vaf_ste, MegaVAFstruct(a).IonW_vaf_mean, MegaVAFstruct(a).IonW_vaf_ste, save,foldername, [monkeyname ' | ', ' Wm VAFs Across Days'])
    %PlotVAFAcrossDays_wSpring(a,1004,MegaVAFstruct(a).SonS_vaf_mean, MegaVAFstruct(a).SonS_vaf_ste, MegaVAFstruct(a).HonS_vaf_mean,MegaVAFstruct(a).HonS_vaf_ste, MegaVAFstruct(a).WonS_vaf_mean,MegaVAFstruct(a).WonS_vaf_ste, MegaVAFstruct(a).IonS_vaf_mean,MegaVAFstruct(a).IonS_vaf_ste,save,foldername, [monkeyname ' | ', 'Spring VAFs Across Days'])   
%PlotVAFAcrossDays(a,1010,MegaVAFstruct(a).H3onI_vaf_mean, MegaVAFstruct(a).H3onI_vaf_ste, MegaVAFstruct(a).H3onW_vaf_mean, MegaVAFstruct(a).H3onW_vaf_ste, MegaVAFstruct(a).H3onS_vaf_mean, MegaVAFstruct(a).H3onS_vaf_ste, save,foldername, [monkeyname ' | ', ' H3 VAFs Across Days'])

PlotVAFAcrossDaysWithH3(a,1001,MegaVAFstruct(a).WonW_vaf_mean, MegaVAFstruct(a).WonW_vaf_ste, MegaVAFstruct(a).HonW_vaf_mean, MegaVAFstruct(a).HonW_vaf_ste,MegaVAFstruct(a).H3onW_vaf_mean, MegaVAFstruct(a).H3onW_vaf_ste, MegaVAFstruct(a).IonW_vaf_mean, MegaVAFstruct(a).IonW_vaf_ste, save,foldername, [monkeyname ' | ', ' Wm VAFs Across Days'])
PlotVAFAcrossDaysWithH3(a,1000,MegaVAFstruct(a).IonI_vaf_mean, MegaVAFstruct(a).IonI_vaf_ste, MegaVAFstruct(a).HonI_vaf_mean, MegaVAFstruct(a).HonI_vaf_ste, MegaVAFstruct(a).H3onI_vaf_mean, MegaVAFstruct(a).H3onI_vaf_ste, MegaVAFstruct(a).WonI_vaf_mean, MegaVAFstruct(a).WonI_vaf_ste, save,foldername, [monkeyname ' | ', ' Iso VAFs Across Days'])
PlotVAFAcrossDays_wSpringWithH3(a,1004,MegaVAFstruct(a).SonS_vaf_mean, MegaVAFstruct(a).SonS_vaf_ste, MegaVAFstruct(a).HonS_vaf_mean,MegaVAFstruct(a).HonS_vaf_ste, MegaVAFstruct(a).H3onS_vaf_mean,MegaVAFstruct(a).H3onS_vaf_ste,MegaVAFstruct(a).WonS_vaf_mean,MegaVAFstruct(a).WonS_vaf_ste, MegaVAFstruct(a).IonS_vaf_mean,MegaVAFstruct(a).IonS_vaf_ste,save,foldername, [monkeyname ' | ', 'Spring VAFs Across Days'])   

%     PlotVAFAcrossDays(a,1005,mean([MegaIndivVAFstruct(a).IonI_vaf_mean]), (std([MegaIndivVAFstruct(a).IonI_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).IonI_vaf_mean]))),...
%         mean([MegaIndivVAFstruct(a).HonI_vaf_mean]), (std([MegaIndivVAFstruct(a).HonI_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).HonI_vaf_mean]))),...
%         mean([MegaIndivVAFstruct(a).WonI_vaf_mean]), (std([MegaIndivVAFstruct(a).WonI_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).WonI_vaf_mean]))),...
%         save,foldername, [monkeyname ' | ', ' Iso Mean of Individual VAFs Across Days'])
%    PlotVAFAcrossDays(a,1006,mean([MegaIndivVAFstruct(a).WonW_vaf_mean]), (std([MegaIndivVAFstruct(a).WonW_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).WonW_vaf_mean]))),...
%         mean([MegaIndivVAFstruct(a).HonW_vaf_mean]), (std([MegaIndivVAFstruct(a).HonW_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).HonW_vaf_mean]))),...
%         mean([MegaIndivVAFstruct(a).IonW_vaf_mean]), (std([MegaIndivVAFstruct(a).IonW_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).IonW_vaf_mean]))),...
%         save,foldername, [monkeyname ' | ', ' WM Mean of Individual VAFs Across Days'])
%    
%     PlotVAFAcrossDays_wSpring(a,1007,mean([MegaIndivVAFstruct(a).SonS_vaf_mean]), (std([MegaIndivVAFstruct(a).SonS_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).SonS_vaf_mean]))),...
%         mean([MegaIndivVAFstruct(a).HonS_vaf_mean]), (std([MegaIndivVAFstruct(a).HonS_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).HonS_vaf_mean]))),...
%         mean([MegaIndivVAFstruct(a).WonS_vaf_mean]), (std([MegaIndivVAFstruct(a).WonS_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).WonS_vaf_mean]))),...
%         mean([MegaIndivVAFstruct(a).IonS_vaf_mean]), (std([MegaIndivVAFstruct(a).IonS_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).IonS_vaf_mean]))),...    
%         save,foldername, [monkeyname ' | ', ' Spr Mean of Individual VAFs Across Days'])
%     
%         PlotVAFAcrossDays(a,1008,mean([MegaIndivVAFstruct(a).H3onI_vaf_mean]), (std([MegaIndivVAFstruct(a).H3onI_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).H3onI_vaf_mean]))),...
%         mean([MegaIndivVAFstruct(a).H3onW_vaf_mean]), (std([MegaIndivVAFstruct(a).H3onW_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).H3onW_vaf_mean]))),...
%         mean([MegaIndivVAFstruct(a).H3onS_vaf_mean]), (std([MegaIndivVAFstruct(a).H3onS_vaf_mean]))/(sqrt(length([MegaIndivVAFstruct(a).H3onS_vaf_mean]))),...
%         save,foldername, [monkeyname ' | ', ' H3 Mean of Individual VAFs Across Days'])
%     
end

% If you want plot labels for all Jango data:
     % set(gca,'Xtick',1:15,'XTickLabel',{'July 23', 'July 24', 'July 25', 'Aug 19', 'Aug 20', 'Aug 21',...
     % 'Sept 23', 'Sept 25', 'Sept 26', 'Oct 10', 'Oct 11', 'Oct 12', 'Nov 6', 'Nov 7'})

%     for a=1:length(SubFolder)
%     PlotVAFAcrossDays_wSpring(a,1004,SonS_PC_vaf_means(a), SonS_PC_vaf_STEs(a),HonS_PC_vaf_means(a), HonS_PC_vaf_STEs(a), WonS_PC_vaf_means(a), WonS_PC_vaf_STEs(a), IonS_PC_vaf_means(a), IonS_PC_vaf_STEs(a),save,foldername, [monkeyname ' | ', 'Spring PC VAFs Across Days'])
%     end
% 
%     
%     % Plot weighted VAFs
%     figure; MarkerSize = 20;
%     plot(AllweightedAveVAF_IonI,'.b','MarkerSize',MarkerSize); hold on
%     plot(AllweightedAveVAF_HonI,'.g','MarkerSize',MarkerSize);
%     plot(AllweightedAveVAF_WonI,'.r','MarkerSize',MarkerSize);
%     xlim([0 10]); ylim([0 1]);
%     title('Iso weighted averages')
%     
%     figure; MarkerSize = 20;
%     plot(AllweightedAveVAF_WonW,'.b','MarkerSize',MarkerSize); hold on
%     plot(AllweightedAveVAF_HonW,'.g','MarkerSize',MarkerSize);
%     plot(AllweightedAveVAF_IonW,'.r','MarkerSize',MarkerSize);
%     xlim([0 10]); ylim([0 1]);
%     title('Wm weighted averages')
%     
%      % Plot weighted VAFs -> length of the VAF vector
%     figure; MarkerSize = 20;
%     plot(AllEigenVAF_IonI,'.b','MarkerSize',MarkerSize); hold on
%     plot(AllEigenVAF_HonI,'.g','MarkerSize',MarkerSize);
%     plot(AllEigenVAF_WonI,'.r','MarkerSize',MarkerSize);
%     xlim([0 10]); ylim([0 1]);
%     title('Iso VAF vector length')
%     
%     figure; MarkerSize = 20;
%     plot(AllEigenVAF_WonW,'.b','MarkerSize',MarkerSize); hold on
%     plot(AllEigenVAF_HonW,'.g','MarkerSize',MarkerSize);
%     plot(AllEigenVAF_IonW,'.r','MarkerSize',MarkerSize);
%     xlim([0 10]); ylim([0 1]);
%     title('Wm VAF vector length')




