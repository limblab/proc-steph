
% For Iso and Movement predictions: look at 8/21
% For Spring predictions, look at 


load('C:\Users\LimbLabSteph\Dropbox\HybridData\JangoGDdata4_082114.mat')
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\RNN_JangoGDdata4_082114_results.mat')
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\RNN_JangoGDdata4_082114_results_across.mat')
foldername='Jango';
%Load Jango 8/21 data from dropbox (GDJango and other results)
% plot all predictions using josh results
figure;PlotAllIsometricAcrossPredictionssingleEMG_withRNN(IsoTest,actual_Iso,pred_within_lin_Iso,pred_across_lin_WonI,pred_across_lin_SonI,pred_hybrid_lin_Iso,pred_hybrid_rnn_mm_Iso,1,0,foldername, '')
set(gca,'YTick', -.1:.1:1);



 load('C:\Users\LimbLabSteph\Dropbox\HybridData\JangoGDdata4_082014.mat')
 load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\RNN_JangoGDdata4_082014_results.mat')
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\RNN_JangoGDdata4_082014_results_across.mat')
foldername='Jango';
 figure
PlotAllMovementAcrossPredictionssingleEMG_withRNN(WmTest,actual_Wm,pred_within_lin_Wm,pred_across_lin_IonW,pred_across_lin_SonW,pred_hybrid_lin_Wm,pred_hybrid_rnn_mm_Wm,3,0,foldername, '')
set(gca,'YTick', -.1:.1:1);

% Spring
load('C:\Users\LimbLabSteph\Dropbox\HybridData\JangoGDdata4_082114.mat')
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\RNN_JangoGDdata4_082114_results.mat')
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\RNN_JangoGDdata4_082114_results_across.mat')
foldername='Jango';
figure
PlotAllSpringAcrossPredictionssingleEMG_withRNN(SprTest,actual_Spr,pred_within_lin_Spr,pred_across_lin_IonS,pred_across_lin_WonS,pred_hybrid_lin_Spr,pred_hybrid_rnn_mm_Spr,2,0,foldername,'')
 





% Old
figure;PlotAllIsometricAcrossPredictionssingleEMG(IsoTest,IsoTest.emgdatabin(10:end,:),IonI_PredEMGs.preddatabin,WonI_PredEMGs.preddatabin,SonI_PredEMGs.preddatabin,HonI_PredEMGs.preddatabin,1,0,foldername, '')




foldername='Jango';
 figure
PlotAllMovementAcrossPredictionssingleEMG(WmTest,WmTest.emgdatabin(10:end,:),WonW_PredEMGs.preddatabin,IonW_PredEMGs.preddatabin,SonW_PredEMGs.preddatabin,HonW_PredEMGs.preddatabin,4,0,foldername, '')



foldername='Jango';
 figure
PlotAllSpringAcrossPredictionssingleEMG(SprTest,SprTest.emgdatabin(10:end,:),SonS_PredEMGs.preddatabin,IonS_PredEMGs.preddatabin,WonS_PredEMGs.preddatabin,HonS_PredEMGs.preddatabin,2,0,foldername,'')
 


set(gca,'YTick', -.1:.1:1);



