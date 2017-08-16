function PlotAllIsometricAcrossPredictionssingleEMG_withRNN(IsoBinned,IonIact,IonIpred,WonIpred,SonIpred,HonIpred,RNNHonIpred,emgInd,save,foldername, filename)
% Run this after you run the main generalizability code

if nargin < 9
    save=0;
end

%Make figures
% Make figure showing across, within predictions
linewidth = 1;
x = (0:0.05:length(IonIact)*.05-0.05)';
% Plot predictions of isometric data---------------------------------------
%--------------------------------------------------------------------------
hold on;
start=180;stop=200;
plot(x,IonIact(:,emgInd),'k','LineWidth', linewidth)
plot(x,IonIpred(:,emgInd),'m','LineWidth', linewidth)
plot(x,HonIpred(:,emgInd),'c','LineWidth', linewidth)
plot(x,WonIpred(:,emgInd),'g', 'LineWidth', linewidth)
plot(x,SonIpred(:,emgInd),'b','LineWidth', linewidth)
plot(x,RNNHonIpred(:,emgInd),'y','LineWidth', linewidth)
xlabel('Time (sec)')
xlim([start stop]);ylim([-.15 1]);
title(strcat(num2str(IsoBinned.meta.datetime(1:9)), ':', IsoBinned.emgguide(emgInd), ' Predictions | Isometric data'))
% %vafs of the whole segment
% muscleVAF.IonI = calculateVAF(IonIpred(:,emgInd),IonIact(:,emgInd));
% muscleVAF.HonI = calculateVAF(HonIpred(:,emgInd),IonIact(:,emgInd));
% muscleVAF.WonI = calculateVAF(WonIpred(:,emgInd),IonIact(:,emgInd));
% muscleVAF.SonI = calculateVAF(SonIpred(:,emgInd),IonIact(:,emgInd));
startbinned=start/.05;stopbinned=stop/.05;
muscleVAF.IonI = calculateVAF(IonIpred(startbinned:stopbinned,emgInd),IonIact(startbinned:stopbinned,emgInd));
muscleVAF.HonI = calculateVAF(HonIpred(startbinned:stopbinned,emgInd),IonIact(startbinned:stopbinned,emgInd));
muscleVAF.WonI = calculateVAF(WonIpred(startbinned:stopbinned,emgInd),IonIact(startbinned:stopbinned,emgInd));
muscleVAF.SonI = calculateVAF(SonIpred(startbinned:stopbinned,emgInd),IonIact(startbinned:stopbinned,emgInd));
muscleVAF.RNNHonI = calculateVAF(RNNHonIpred(startbinned:stopbinned,emgInd),IonIact(startbinned:stopbinned,emgInd));

legend('Actual',strcat('Within | vaf=',num2str(muscleVAF.IonI)),strcat('Hybrid | vaf=',num2str(muscleVAF.HonI)),strcat('Move | vaf=',num2str(muscleVAF.WonI)),strcat('Spring | vaf=',num2str(muscleVAF.SonI)),strcat('RNN | vaf=',num2str(muscleVAF.RNNHonI)))
MillerFigure

% Save figure
if save == 1
    SaveFigure(foldername, strcat(filename,'_',char(IsoBinned.emgguide(emgInd))))
end


end