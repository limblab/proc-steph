function ProcessDataforJosh(z)

monkeyname = 'Jango';
HybridEMGlist=Jango_HybridData_EMGQualityInfo();
%HybridEMGlist=Jango_TryingMoreEMGs();
BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Jango\';
SubFolder = {'07-24-14s','07-25-14s', '08-19-14s', '08-20-14s',...
  '08-21-14s','09-23-14s','10-10-14s','10-11-14s'...
  '10-12-14s'};

% monkeyname = 'Kevin';
% HybridEMGlist=Kevin_HybridData_EMGQualityInfo();
% BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Kevin\';
% SubFolder={'05-19-15s','05-21-15s','05-25-15s','05-26-15s','06-04-15s'};


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
% Make the baseline the same by subtracting by 1 percentile (quantile, 0.1)
[IsoBinned, WmBinned, SprBinned] = FixBaseline_HybridData(IsoBinned,WmBinned,SprBinned);

% Step 1| Make sure you are using the same neurons for both files
[IsoBinned, WmBinned] = SameNeuronsAcrossBinnedDataFiles(IsoBinned,WmBinned);
[SprBinned, WmBinned] = SameNeuronsAcrossBinnedDataFiles(SprBinned,WmBinned);
[SprBinned, IsoBinned] =  SameNeuronsAcrossBinnedDataFiles(SprBinned,IsoBinned);
[WmBinned, IsoBinned] =  SameNeuronsAcrossBinnedDataFiles(WmBinned,IsoBinned);

% Step 2| Make test/train data and hybrid file
[Hybrid3 IsoTrain IsoTest WmTrain WmTest SprTrain SprTest] = AppendIsoWmSpr30minTotal(IsoBinned,WmBinned,SprBinned);

clearvars -except Hybrid3 IsoBinned IsoTest IsoTrain SprBinned SprTest SprTrain WmBinned WmTest WmTrain datalabel
save(strcat('C:\Users\LimbLabSteph\Dropbox\HybridData\JangoGDdata4_',datalabel))

