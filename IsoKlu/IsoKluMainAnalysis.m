


% Build hybrid decoder
[H2 IsoTrain IsoTest KluTrain KluTest] = AppendIsoSpr20minTotal(IsoBinned, KluBinned);
H2weights = computeWeightedH2(H2);
options=[]; options.PredEMGs = 1;
tempH2 = BuildModel(H2, options);tempH2.H=H2weights;
H2model = tempH2;

%BuildNormalModels -------------------------------------------------------
IsoModel = BuildModel_predMIMO3(IsoTrain, options);
KluModel = BuildModel_predMIMO3(KluTrain, options);

% Make predictions
[HonI_PredEMGs] = predictSignals_predMIMO3(H2model, IsoTest);
VAFstruct.HonI_mVAF = MultivariateVAF(HonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));
[IonI_PredEMGs] = predictSignals_predMIMO3(IsoModel, IsoTest);
VAFstruct.IonI_mVAF = MultivariateVAF(IonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));
[IonK_PredEMGs] = predictSignals_predMIMO3(IsoModel, KluTest);
VAFstruct.IonK_mVAF = MultivariateVAF(IonK_PredEMGs.preddatabin, KluTest.emgdatabin(10:end,:));

% Make predictions
[HonK_PredEMGs] = predictSignals_predMIMO3(H2model, KluTest);
VAFstruct.HonK_mVAF = MultivariateVAF(HonK_PredEMGs.preddatabin, KluTest.emgdatabin(10:end,:));
[KonK_PredEMGs] = predictSignals_predMIMO3(KluModel, KluTest);
VAFstruct.KonK_mVAF = MultivariateVAF(KonK_PredEMGs.preddatabin, KluTest.emgdatabin(10:end,:));
[KonI_PredEMGs] = predictSignals_predMIMO3(KluModel, IsoTest);
VAFstruct.KonI_mVAF = MultivariateVAF(KonI_PredEMGs.preddatabin, IsoTest.emgdatabin(10:end,:));


figure; hold on
MS=30;
plot(1,VAFstruct.HonI_mVAF(1),'.c','MarkerSize',MS)
plot(1,VAFstruct.IonI_mVAF(1),'.m','MarkerSize',MS)
plot(1,VAFstruct.KonI_mVAF(1),'.b','MarkerSize',MS)
plot(2,VAFstruct.HonK_mVAF(1),'.c','MarkerSize',MS)
plot(2,VAFstruct.KonK_mVAF(1),'.b','MarkerSize',MS)
plot(2,VAFstruct.IonK_mVAF(1),'.m','MarkerSize',MS)
xlim([0.5 2.5])
ylim([0 1])


