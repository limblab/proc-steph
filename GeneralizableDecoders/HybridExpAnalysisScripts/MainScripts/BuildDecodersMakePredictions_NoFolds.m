%BuildDecodersMakePredictions_NoFolds

% Step 1| Make sure you are using the same neurons for both files
[IsoBinned, WmBinned] = SameNeuronsAcrossBinnedDataFiles(IsoBinned,WmBinned);
[SprBinned, WmBinned] = SameNeuronsAcrossBinnedDataFiles(SprBinned,WmBinned);
[SprBinned, IsoBinned] =  SameNeuronsAcrossBinnedDataFiles(SprBinned,IsoBinned);
[WmBinned, IsoBinned] =  SameNeuronsAcrossBinnedDataFiles(WmBinned,IsoBinned);

% Step 2| Make test/train data and hybrid file
[~, IsoTrain, IsoTest, WmTrain, WmTest]= AppendIsoWmHalves(IsoBinned,WmBinned);
[~,~,~, SprTrain, SprTest] = makeHybridFileFixed(SprBinned,WmBinned);
[Hybrid3] = AppendIsoWmSprThirds(IsoBinned,WmBinned,SprBinned);

% Step 3| Build Decoders
% Build hybrid decoder ---------------------------------------------------
options=[]; options.PredEMGs = 1;
[hybridH3] = quickHybridDecoder(Hybrid3); % This gets you the hybrid weights
Fakehybrid3 = BuildModel(Hybrid3, options); % This gives you a structure for the hybrid decoder to later input into other functions
Fakehybrid3.H = hybridH3;
H3model = Fakehybrid3; % Now you have the decoder variable structure with the correct H weights in it


%BuildNormalModels -------------------------------------------------------
IsoModel = BuildModel(IsoTrain, options);
WmModel = BuildModel(WmTrain, options);
SprModel = BuildModel(SprTrain, options);


% Make predictions
[HonI_PredEMGs] = predictSignals(H3model, IsoTest); 
VAFstruct.HonI_mVAF = MultivariateVAF(HonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));
[IonI_PredEMGs] = predictSignals(IsoModel, IsoTest);
VAFstruct.IonI_mVAF = MultivariateVAF(IonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));
[WonI_PredEMGs] = predictSignals(WmModel, IsoTest);
VAFstruct.WonI_mVAF = MultivariateVAF(WonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));
[SonI_PredEMGs] = predictSignals(SprModel, IsoTest);
VAFstruct.SonI_mVAF = MultivariateVAF(SonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));

[HonW_PredEMGs] = predictSignals(H3model, WmTest);
VAFstruct.HonW_mVAF = MultivariateVAF(HonW_PredEMGs.preddatabin, WmTest.emgdatabin(10:end,:));
[WonW_PredEMGs] = predictSignals(WmModel, WmTest);
VAFstruct.WonW_mVAF = MultivariateVAF(WonW_PredEMGs.preddatabin, WmTest.emgdatabin(10:end,:));
[IonW_PredEMGs] = predictSignals(IsoModel, WmTest);
VAFstruct.IonW_mVAF = MultivariateVAF(IonW_PredEMGs.preddatabin, WmTest.emgdatabin(10:end,:));
[SonW_PredEMGs] = predictSignals(SprModel, WmTest);
VAFstruct.SonW_mVAF = MultivariateVAF(SonW_PredEMGs.preddatabin, WmTest.emgdatabin(10:end,:));

[HonS_PredEMGs] = predictSignals(H3model, SprTest);
VAFstruct.HonS_mVAF = MultivariateVAF(HonS_PredEMGs.preddatabin, SprTest.emgdatabin(10:end,:));
[SonS_PredEMGs] = predictSignals(SprModel, SprTest);
VAFstruct.SonS_mVAF = MultivariateVAF(SonS_PredEMGs.preddatabin, SprTest.emgdatabin(10:end,:));
[IonS_PredEMGs] = predictSignals(IsoModel, SprTest);
VAFstruct.IonS_mVAF = MultivariateVAF(IonS_PredEMGs.preddatabin, SprTest.emgdatabin(10:end,:));
[WonS_PredEMGs] = predictSignals(WmModel, SprTest);
VAFstruct.WonS_mVAF = MultivariateVAF(WonS_PredEMGs.preddatabin, SprTest.emgdatabin(10:end,:));


% Look at fits (train and test using the same data)
[IsoFitPredData] = predictSignals(IsoModel,IsoTrain);
IsoAct=IsoTrain.emgdatabin(10:end,:);
% Calculate multivariate VAF
for ind=1:length(IsoFitPredData.preddatabin)
    PredNorm(ind,1) = norm(IsoFitPredData.preddatabin(ind,:));
    ActNorm(ind,1) = norm(IsoAct(ind,:));
end
IsoFitVAF  = 1 - sum( (PredNorm-ActNorm).^2 ) ./ sum( (ActNorm - repmat(mean(ActNorm),size(ActNorm,1),1)).^2 );

[WmFitPredData] = predictSignals(WmModel,WmTrain);
WmAct=WmTrain.emgdatabin(10:end,:);
% Calculate multivariate VAF
for ind=1:length(WmFitPredData.preddatabin)
    PredNorm(ind,1) = norm(WmFitPredData.preddatabin(ind,:));
    ActNorm(ind,1) = norm(WmAct(ind,:));
end
WmFitVAF  = 1 - sum( (PredNorm-ActNorm).^2 ) ./ sum( (ActNorm - repmat(mean(ActNorm),size(ActNorm,1),1)).^2 );

[SprFitPredData] = predictSignals(SprModel,SprTrain);
SprAct=SprTrain.emgdatabin(10:end,:);
% Calculate multivariate VAF
for ind=1:length(SprFitPredData.preddatabin)
    PredNorm(ind,1) = norm(SprFitPredData.preddatabin(ind,:));
    ActNorm(ind,1) = norm(SprAct(ind,:));
end
SprFitVAF  = 1 - sum( (PredNorm-ActNorm).^2 ) ./ sum( (ActNorm - repmat(mean(ActNorm),size(ActNorm,1),1)).^2 );






