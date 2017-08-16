%DynamicRangeWrapper

monkeyname = 'Jango';
HybridEMGlist=Jango_HybridData_EMGQualityInfo();

% monkeyname = 'Kevin';
% HybridEMGlist=Kevin_HybridData_EMGQualityInfo();

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
%Get rid of neurons that fire <0.05 spike per second in any field
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

% Step 2| Make test/train data and hybrid file
[Hybrid3 IsoTrain IsoTest WmTrain WmTest SprTrain SprTest] = AppendIsoWmSpr30minTotal(IsoBinned,WmBinned,SprBinned);
binnedData=IsoBinned;





% 
% For the actual v pred comparison
% 
% %BuildNormalModel ---------------------------------------------------------
% options=[]; options.PredEMGs = 1;
% IsoModel = BuildModel_predMIMO3(IsoTrain, options);
% % Make Predictions --------------------------------------------------------
% [IonI_PredEMGs] = predictSignals_predMIMO3(IsoModel, IsoTest);
% VAFstruct.IonI_mVAF = MultivariateVAF(IonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));
% 
% IsoTest.timeframe=(600:0.05:600+(6000)*.05-0.05)';
% binnedData=IsoTest;
% 
% 
% % for the preds
% IonI_PredEMGs.preddatabin=cat(1,nan(9,length(binnedData.emgdatabin(1,:))), IonI_PredEMGs.preddatabin);
% binnedData.emgdatabin=IonI_PredEMGs.preddatabin;
% clearvars -except binnedData


