%F2_PlotPredictions

% Pick the monkey and day you want. Run GeneralizableAnalysisPapaScript_June2016.m until right after
% BuildDecodersMakePredictions. Then:

save=0;

% Iso
figure; hold on
PlotAllIsometricAcrossPredictionssingleEMG(IsoBinned,IsoTest.emgdatabin(10:end,:),IonI_PredEMGs.preddatabin,WonI_PredEMGs.preddatabin,SonI_PredEMGs.preddatabin,HonI_PredEMGs.preddatabin,1,0,foldername, [monkeyname '_' datalabel 'IsoPredictions'])

figure; hold on;
PlotAllMovementAcrossPredictionssingleEMG(WmBinned,WmTest.emgdatabin(10:end,:),WonW_PredEMGs.preddatabin,IonW_PredEMGs.preddatabin,SonI_PredEMGs.preddatabin,HonW_PredEMGs.preddatabin,2,0,foldername, [monkeyname '_' datalabel 'WmPredictions'])

figure; hold on;
PlotAllSpringAcrossPredictionssingleEMG(SprBinned,SprTest.emgdatabin(10:end,:),SonS_PredEMGs.preddatabin,IonS_PredEMGs.preddatabin,WonS_PredEMGs.preddatabin,HonS_PredEMGs.preddatabin,1,0,foldername, [monkeyname '_' datalabel 'SprPredictions'])


%----------------------------------------------------------------------

% Isometric plot
figure
subplot(2,1,1)
hold on
PlotAllIsometricAcrossPredictionssingleEMG(IsoBinned,IsoTest.emgdatabin(10:end,:),IonI_PredEMGs.preddatabin,WonI_PredEMGs.preddatabin,SonI_PredEMGs.preddatabin,HonI_PredEMGs.preddatabin,1,0,foldername, [monkeyname '_' datalabel 'IsoPredictions'])


subplot(2,1,2)
hold on
PlotAllIsometricPredictionsWithH3_singleEMG(IsoBinned,IsoTest,IonIactTrunk,HonIpred.preddatabin,IonIpred.preddatabin,WonIpred.preddatabin,SonIpred.preddatabin,H3onIpred.preddatabin,VAFstruct,4,save,foldername, [monkeyname '_' datalabel 'IsoPredictions'])

% Movement plot
figure
subplot(2,1,1)
hold on
PlotAllMovementPredictionsWithH3_singleEMG(WmBinned,WmTest,WonWactTrunk,HonWpred.preddatabin,WonWpred.preddatabin,IonWpred.preddatabin,SonWpred.preddatabin,H3onWpred.preddatabin,VAFstruct,2,save,foldername, [monkeyname '_' datalabel 'WmPredictions'])

subplot(2,1,2)
hold on
PlotAllMovementPredictionsWithH3_singleEMG(WmBinned,WmTest,WonWactTrunk,HonWpred.preddatabin,WonWpred.preddatabin,IonWpred.preddatabin,SonWpred.preddatabin,H3onWpred.preddatabin,VAFstruct,3,save,foldername, [monkeyname '_' datalabel 'WmPredictions'])

% Spring plot
figure
subplot(2,1,1)
hold on
PlotAllSpringPredictionsWithH3_singleEMG(SprBinned,SprTest,SonSactTrunk,SonSpred.preddatabin,HonSpred.preddatabin,IonSpred.preddatabin,WonSpred.preddatabin,H3onSpred.preddatabin, VAFstruct,1,save,foldername, 'SprPredictions')

subplot(2,1,2)
hold on
PlotAllSpringPredictionsWithH3_singleEMG(SprBinned,SprTest,SonSactTrunk,SonSpred.preddatabin,HonSpred.preddatabin,IonSpred.preddatabin,WonSpred.preddatabin,H3onSpred.preddatabin, VAFstruct,4,save,foldername, 'SprPredictions')



         
     