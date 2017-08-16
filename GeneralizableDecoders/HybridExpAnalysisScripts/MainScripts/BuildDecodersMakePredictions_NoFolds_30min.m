%BuildDecodersMakePredictions_NoFolds

% Step 1| Make sure you are using the same neurons for both files
[IsoBinned, WmBinned] = SameNeuronsAcrossBinnedDataFiles(IsoBinned,WmBinned);
[SprBinned, WmBinned] = SameNeuronsAcrossBinnedDataFiles(SprBinned,WmBinned);
[SprBinned, IsoBinned] =  SameNeuronsAcrossBinnedDataFiles(SprBinned,IsoBinned);
[WmBinned, IsoBinned] =  SameNeuronsAcrossBinnedDataFiles(WmBinned,IsoBinned);

% Step 2| Make test/train data and hybrid file
[Hybrid3 IsoTrain IsoTest WmTrain WmTest SprTrain SprTest] = AppendIsoWmSpr30minTotal(IsoBinned,WmBinned,SprBinned);



% Step 3| Build Decoders
% Build hybrid decoder ---------------------------------------------------
useCorrelations=0;
options=[]; options.PredEMGs = 1;
if useCorrelations==1
[H3weights] = quickHybridDecoder(Hybrid3); % This gets you the hybrid weights
else if useCorrelations==0
        H3weights = computeWeightedHybrid(Hybrid3);
    end
end
Fakehybrid3 = BuildModel(Hybrid3, options); % This gives you a structure for the hybrid decoder to later input into other functions
Fakehybrid3.H = H3weights;
H3model = Fakehybrid3; % Now you have the decoder variable structure with the correct H weights in it
% For implementing H2
BuildH2=1;
if BuildH2==1
 % [H2 IsoTrain IsoTest WmTrain WmTest] = AppendIsoSpr20minTotal(IsoBinned, WmBinned);
    %[H2 SprTrain SprTest WmTrain WmTest] = AppendIsoSpr20minTotal(SprBinned, WmBinned);
     [H2 IsoTrain IsoTest SprTrain SprTest] = AppendIsoSpr20minTotal(IsoBinned, SprBinned);
    H2weights = computeWeightedH2(H2);
    tempH2 = BuildModel(H2, options);tempH2.H=H2weights;
    H2model = tempH2;
end


%BuildNormalModels -------------------------------------------------------
IsoModel = BuildModel_predMIMO3(IsoTrain, options);
WmModel = BuildModel_predMIMO3(WmTrain, options);
SprModel = BuildModel_predMIMO3(SprTrain, options);


% Make predictions
[HonI_PredEMGs] = predictSignals_predMIMO3(H3model, IsoTest);
VAFstruct.HonI_mVAF = MultivariateVAF(HonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));
[IonI_PredEMGs] = predictSignals_predMIMO3(IsoModel, IsoTest);
VAFstruct.IonI_mVAF = MultivariateVAF(IonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));
[WonI_PredEMGs] = predictSignals_predMIMO3(WmModel, IsoTest);
VAFstruct.WonI_mVAF = MultivariateVAF(WonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));
[SonI_PredEMGs] = predictSignals_predMIMO3(SprModel, IsoTest);
VAFstruct.SonI_mVAF = MultivariateVAF(SonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));

[HonW_PredEMGs] = predictSignals_predMIMO3(H3model, WmTest);
VAFstruct.HonW_mVAF = MultivariateVAF(HonW_PredEMGs.preddatabin, WmTest.emgdatabin(10:end,:));
[WonW_PredEMGs] = predictSignals_predMIMO3(WmModel, WmTest);
VAFstruct.WonW_mVAF = MultivariateVAF(WonW_PredEMGs.preddatabin, WmTest.emgdatabin(10:end,:));
[IonW_PredEMGs] = predictSignals_predMIMO3(IsoModel, WmTest);
VAFstruct.IonW_mVAF = MultivariateVAF(IonW_PredEMGs.preddatabin, WmTest.emgdatabin(10:end,:));
[SonW_PredEMGs] = predictSignals_predMIMO3(SprModel, WmTest);
VAFstruct.SonW_mVAF = MultivariateVAF(SonW_PredEMGs.preddatabin, WmTest.emgdatabin(10:end,:));

[HonS_PredEMGs] = predictSignals_predMIMO3(H3model, SprTest);
VAFstruct.HonS_mVAF = MultivariateVAF(HonS_PredEMGs.preddatabin, SprTest.emgdatabin(10:end,:));
[SonS_PredEMGs] = predictSignals_predMIMO3(SprModel, SprTest);
VAFstruct.SonS_mVAF = MultivariateVAF(SonS_PredEMGs.preddatabin, SprTest.emgdatabin(10:end,:));
[IonS_PredEMGs] = predictSignals_predMIMO3(IsoModel, SprTest);
VAFstruct.IonS_mVAF = MultivariateVAF(IonS_PredEMGs.preddatabin, SprTest.emgdatabin(10:end,:));
[WonS_PredEMGs] = predictSignals_predMIMO3(WmModel, SprTest);
VAFstruct.WonS_mVAF = MultivariateVAF(WonS_PredEMGs.preddatabin, SprTest.emgdatabin(10:end,:));

if BuildH2==1
    [H2onI_PredEMGs] = predictSignals_predMIMO3(H2model, IsoTest);
    VAFstruct.H2onI_mVAF = MultivariateVAF(H2onI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));
    [H2onW_PredEMGs] = predictSignals_predMIMO3(H2model, WmTest);
    VAFstruct.H2onW_mVAF = MultivariateVAF(H2onW_PredEMGs.preddatabin, WmTest.emgdatabin(10:end,:));
    [H2onS_PredEMGs] = predictSignals_predMIMO3(H2model, SprTest);
    VAFstruct.H2onS_mVAF = MultivariateVAF(H2onS_PredEMGs.preddatabin, SprTest.emgdatabin(10:end,:));
    
    %save(strcat(BaseFolder,'Results\','Lin_', monkeyname,'_', datalabel, '_results'),'H2onI_PredEMGs','H2onW_PredEMGs',...
    %'H2onS_PredEMGs','HonI_PredEMGs','HonW_PredEMGs','HonS_PredEMGs','IonI_PredEMGs','IonW_PredEMGs','IonS_PredEMGs',...
    %'WonW_PredEMGs','WonI_PredEMGs','WonS_PredEMGs','SonS_PredEMGs','SonW_PredEMGs','SonI_PredEMGs','IsoTest',...
    %'WmTest','SprTest','VAFstruct');
end

 save(strcat(BaseFolder,'Results\','Lin_', monkeyname,'_', datalabel, '_results'),'HonI_PredEMGs',...
     'HonW_PredEMGs','HonS_PredEMGs','IonI_PredEMGs','IonW_PredEMGs','IonS_PredEMGs',...
    'WonW_PredEMGs','WonI_PredEMGs','WonS_PredEMGs','SonS_PredEMGs','SonW_PredEMGs','SonI_PredEMGs','IsoTest',...
    'WmTest','SprTest','VAFstruct');



% Look at fits (train and test using the same data)
[IsoFitPredData] = predictSignals_predMIMO3(IsoModel,IsoTrain);
IsoAct=IsoTrain.emgdatabin(10:end,:);
% Calculate multivariate VAF
for ind=1:length(IsoFitPredData.preddatabin)
    PredNorm(ind,1) = norm(IsoFitPredData.preddatabin(ind,:));
    ActNorm(ind,1) = norm(IsoAct(ind,:));
end
IsoFitVAF  = 1 - sum( (PredNorm-ActNorm).^2 ) ./ sum( (ActNorm - repmat(mean(ActNorm),size(ActNorm,1),1)).^2 );

[WmFitPredData] = predictSignals_predMIMO3(WmModel,WmTrain);
WmAct=WmTrain.emgdatabin(10:end,:);
% Calculate multivariate VAF
for ind=1:length(WmFitPredData.preddatabin)
    PredNorm(ind,1) = norm(WmFitPredData.preddatabin(ind,:));
    ActNorm(ind,1) = norm(WmAct(ind,:));
end
WmFitVAF  = 1 - sum( (PredNorm-ActNorm).^2 ) ./ sum( (ActNorm - repmat(mean(ActNorm),size(ActNorm,1),1)).^2 );

[SprFitPredData] = predictSignals_predMIMO3(SprModel,SprTrain);
SprAct=SprTrain.emgdatabin(10:end,:);
% Calculate multivariate VAF
for ind=1:length(SprFitPredData.preddatabin)
    PredNorm(ind,1) = norm(SprFitPredData.preddatabin(ind,:));
    ActNorm(ind,1) = norm(SprAct(ind,:));
end
SprFitVAF  = 1 - sum( (PredNorm-ActNorm).^2 ) ./ sum( (ActNorm - repmat(mean(ActNorm),size(ActNorm,1),1)).^2 );






