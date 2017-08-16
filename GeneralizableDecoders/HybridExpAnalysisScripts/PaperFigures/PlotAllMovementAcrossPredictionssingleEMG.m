function PlotAllMovementAcrossPredictionssingleEMG(WmBinned,WonWact,WonWpred,IonWpred,SonWpred,HonWpred,emgInd,save,foldername, filename)
% Run this after you run the main generalizability code

if nargin < 8
    save=0;
end

%Make figures
% Make figure showing across, within predictions
linewidth = 1.5;
x = (0:0.05:length(WonWact)*.05-0.05)';
% Plot predictions of isometric data---------------------------------------
%--------------------------------------------------------------------------
hold on;
start=60;stop=80; %original
start=80;stop=100;
plot(x,WonWact(:,emgInd),'k','LineWidth', linewidth)
plot(x,WonWpred(:,emgInd),'g','LineWidth', linewidth)
plot(x,HonWpred(:,emgInd),'c','LineWidth', linewidth)
plot(x,IonWpred(:,emgInd),'m', 'LineWidth', linewidth)
plot(x,SonWpred(:,emgInd),'b','LineWidth', linewidth)
xlabel('Time (sec)')
xlim([start stop]);ylim([-.15 1]);
title(strcat(num2str(WmBinned.meta.datetime(1:9)), ':', WmBinned.emgguide(emgInd), ' Predictions | Movement data'))
% %vafs of the whole segment
% muscleVAF.WonW = calculateVAF(WonWpred(:,emgInd),WonWact(:,emgInd));
% muscleVAF.HonW = calculateVAF(HonWpred(:,emgInd),WonWact(:,emgInd));
% muscleVAF.IonW = calculateVAF(IonWpred(:,emgInd),WonWact(:,emgInd));
% muscleVAF.SonW = calculateVAF(SonWpred(:,emgInd),WonWact(:,emgInd));
startbinned=start/.05;stopbinned=stop/.05;
muscleVAF.WonW = calculateVAF(WonWpred(startbinned:stopbinned,emgInd),WonWact(startbinned:stopbinned,emgInd));
muscleVAF.HonW = calculateVAF(HonWpred(startbinned:stopbinned,emgInd),WonWact(startbinned:stopbinned,emgInd));
muscleVAF.IonW = calculateVAF(IonWpred(startbinned:stopbinned,emgInd),WonWact(startbinned:stopbinned,emgInd));
muscleVAF.SonW = calculateVAF(SonWpred(startbinned:stopbinned,emgInd),WonWact(startbinned:stopbinned,emgInd));
legend('Actual',strcat('Within | vaf=',num2str(muscleVAF.WonW)),strcat('Hybrid | vaf=',num2str(muscleVAF.HonW)),strcat('Iso | vaf=',num2str(muscleVAF.IonW)),strcat('Spring | vaf=',num2str(muscleVAF.SonW)))
MillerFigure

% Save figure
if save == 1
    SaveFigure(foldername, strcat(filename,'_',char(IsoBinned.emgguide(emgInd))))
end


end