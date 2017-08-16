% GeneralizableAnalysisPapaScript
% This script is a "papa script" that builds decoders, saves actual and
% predicted EMG, and then makes and saves figures in the appropriate
% folders so that I can just open a folder and look at summary figures/data
% for that day.

%clear
%Step 1a: Initialize folders
% monkeyname = 'Kevin';
% HybridEMGlist=Kevin_HybridData_EMGQualityInfo();
% BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Kevin\';
% SubFolder={'05-19-15s','05-21-15s','05-25-15s','05-26-15s','06-04-15s'};


monkeyname = 'Jango';
HybridEMGlist=Jango_HybridData_EMGQualityInfo();
%HybridEMGlist=Jango_TryingMoreEMGs();
BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Jango\';
SubFolder = {'07-24-14s','07-25-14s', '08-19-14s', '08-20-14s',...
  '08-21-14s','09-23-14s','10-10-14s','10-11-14s'...
  '10-12-14s'};


for z = 1:length(SubFolder)
    % Step 1b:  Load data into workspace | Open folder directory for saving figs 
    cd([BaseFolder SubFolder{z} '\']);
    foldername = [BaseFolder SubFolder{z} '\'];
    hyphens = find(SubFolder{z}=='-'); SubFolder{z}(hyphens)=[];
    load([foldername 'HybridData_' monkeyname '_' SubFolder{z}(1,1:6)]);
    datalabel = SubFolder{z}(1:6);

% Find the right EMGlist
% Only keep EMG data for the 4 wrist muscles
EMGlistIndex = find(strcmp(HybridEMGlist,datalabel));
binnedData = IsoBinned;
IsoBinned.emgguide = cellstr(IsoBinned.emgguide); WmBinned.emgguide = cellstr(WmBinned.emgguide);SprBinned.emgguide = cellstr(SprBinned.emgguide);
for j=1:length(HybridEMGlist{EMGlistIndex,2})
    EMGindtemp = strmatch(HybridEMGlist{EMGlistIndex,2}(j,:),(binnedData.emgguide)); emg_vector(j) = EMGindtemp(1);
end
IsoBinned.emgguide = IsoBinned.emgguide(emg_vector); IsoBinned.emgdatabin = IsoBinned.emgdatabin(:,emg_vector);
WmBinned.emgguide = WmBinned.emgguide(emg_vector); WmBinned.emgdatabin = WmBinned.emgdatabin(:,emg_vector);
SprBinned.emgguide = SprBinned.emgguide(emg_vector); SprBinned.emgdatabin = SprBinned.emgdatabin(:,emg_vector);

% Normalize EMGs according to the biggest EMG across all 3 tasks
[IsoEMGsNormed WmEMGsNormed SprEMGsNormed] = NormalizeGeneralizableEMGs(IsoBinned.emgdatabin,WmBinned.emgdatabin,SprBinned.emgdatabin, 1);
IsoBinned.emgdatabin=IsoEMGsNormed; WmBinned.emgdatabin=WmEMGsNormed; SprBinned.emgdatabin=SprEMGsNormed;
%Get rid of neurons that fire <0.05 spike per second in any fiel
badSpikeInds_Iso=findLowFiringNeurons(IsoBinned);
badSpikeInds_Wm=findLowFiringNeurons(WmBinned);
badSpikeInds_Spr=findLowFiringNeurons(SprBinned);
allBadSpikeInds=unique(cat(2,badSpikeInds_Iso,badSpikeInds_Wm,badSpikeInds_Spr));
IsoBinned.spikeratedata(:,allBadSpikeInds)=[];IsoBinned.neuronIDs(allBadSpikeInds,:)=[];
WmBinned.spikeratedata(:,allBadSpikeInds)=[];WmBinned.neuronIDs(allBadSpikeInds,:)=[];
SprBinned.spikeratedata(:,allBadSpikeInds)=[];SprBinned.neuronIDs(allBadSpikeInds,:)=[];
% remove outliers
[IsoBinned.emgdatabin, WmBinned.emgdatabin, SprBinned.emgdatabin] = GDremoveEMGoutliers(IsoBinned.emgdatabin, WmBinned.emgdatabin, SprBinned.emgdatabin);
% Make the baseline the same by subtracting by 1 percentile (quantile, 0.01)
[IsoBinned, WmBinned, SprBinned] = FixBaseline_HybridData(IsoBinned,WmBinned,SprBinned);

% Step 3: make and save predictions
%BuildDecodersMakePredictions_NoFolds
BuildDecodersMakePredictions_NoFolds_30min

% Make mega VAF struct
if z == 1
    MegaVAFstruct = VAFstruct;
    else
    MegaVAFstruct = [MegaVAFstruct VAFstruct];
end

%AllIsoFits(z)=IsoFitVAF; AllWmFits(z) = WmFitVAF; AllSprFits(z) = SprFitVAF;

% Clear variables
clearvars -except monkeyname BaseFolder SubFolder meanHonI_PC_mse meanIonI_PC_mse meanWonI_PC_mse meanHonW_PC_mse meanWonW_PC_mse meanIonW_PC_mse...
    stdHonI_PC_mse stdIonI_PC_mse stdWonI_PC_mse stdHonW_PC_mse stdWonW_PC_mse stdIonW_PC_mse meanHonS_PC_mse meanIonS_PC_mse meanWonS_PC_mse meanSonS_PC_mse ...
        stdHonS_PC_mse stdIonS_PC_mse stdWonS_PC_mse stdSonS_PC_mse z MegaVAFstruct MegaIndivVAFstruct  HybridEMGlist ...
        AllDaysIonI AllDaysWonW AllDaysWonI AllDaysIonW AllDaysHonI AllDaysHonW AllDaysSonS AllDaysIonS AllDaysWonS AllDaysHonS ...
        AllDaysH3onS AllDaysH3onI AllDaysH3onW AllDaysSonI AllDaysSonW AllIsoFits AllWmFits AllSprFits

end

% save = 0;foldername = '';
% for a=1:length(SubFolder)
% PlotVAFAcrossDaysWithH3(a,1001,MegaVAFstruct(a).WonW_vaf_mean, MegaVAFstruct(a).WonW_vaf_ste, MegaVAFstruct(a).HonW_vaf_mean, MegaVAFstruct(a).HonW_vaf_ste,MegaVAFstruct(a).H3onW_vaf_mean, MegaVAFstruct(a).H3onW_vaf_ste, MegaVAFstruct(a).IonW_vaf_mean, MegaVAFstruct(a).IonW_vaf_ste, save,foldername, [monkeyname ' | ', ' Wm VAFs Across Days'])
% PlotVAFAcrossDaysWithH3(a,1000,MegaVAFstruct(a).IonI_vaf_mean, MegaVAFstruct(a).IonI_vaf_ste, MegaVAFstruct(a).HonI_vaf_mean, MegaVAFstruct(a).HonI_vaf_ste, MegaVAFstruct(a).H3onI_vaf_mean, MegaVAFstruct(a).H3onI_vaf_ste, MegaVAFstruct(a).WonI_vaf_mean, MegaVAFstruct(a).WonI_vaf_ste, save,foldername, [monkeyname ' | ', ' Iso VAFs Across Days'])
% PlotVAFAcrossDays_wSpringWithH3(a,1004,MegaVAFstruct(a).SonS_vaf_mean, MegaVAFstruct(a).SonS_vaf_ste, MegaVAFstruct(a).HonS_vaf_mean,MegaVAFstruct(a).HonS_vaf_ste, MegaVAFstruct(a).H3onS_vaf_mean,MegaVAFstruct(a).H3onS_vaf_ste,MegaVAFstruct(a).WonS_vaf_mean,MegaVAFstruct(a).WonS_vaf_ste, MegaVAFstruct(a).IonS_vaf_mean,MegaVAFstruct(a).IonS_vaf_ste,save,foldername, [monkeyname ' | ', 'Spring VAFs Across Days'])   
% end
