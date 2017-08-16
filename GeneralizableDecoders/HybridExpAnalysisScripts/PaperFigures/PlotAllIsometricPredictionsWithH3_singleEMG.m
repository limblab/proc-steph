function PlotAllIsometricPredictionsWithH3_singleEMG(IsoBinned,IsoTest,IonIact,HonIpred,IonIpred,WonIpred,SonIpred,H3onIpred,VAFstruct,emgInd,save,foldername, filename)
% Run this after you run the main generalizability code

if nargin < 8
    save=0;
end

%Make figures
% Make figure showing hybrid, across, within predictions
linewidth = 1.5;
x = (0:0.05:length(IonIact)*.05-0.05)';
% Plot predictions of isometric data---------------------------------------
%--------------------------------------------------------------------------
hold on;
plot(x,IonIact(:,emgInd),'k','LineWidth', linewidth)
plot(x,IonIpred(:,emgInd),'b','LineWidth', linewidth)
plot(x,HonIpred(:,emgInd),'y','LineWidth', linewidth)
plot(x,WonIpred(:,emgInd),'g', 'LineWidth', linewidth)
plot(x,SonIpred(:,emgInd),'Color', [0.5 0 1],'LineWidth', linewidth)
plot(x,H3onIpred(:,emgInd),'c','LineWidth', linewidth)
xlabel('Time (sec)')
xlim([200 220]);ylim([-.15 1]);
title(strcat(num2str(IsoBinned.meta.datetime(1:9)), ':', IsoBinned.emgguide(emgInd), ' Predictions | Isometric data'))
muscleVAF.IonI = calculateVAF(IonIpred(:,emgInd),IonIact(:,emgInd));
muscleVAF.HonI = calculateVAF(HonIpred(:,emgInd),IonIact(:,emgInd));
muscleVAF.WonI = calculateVAF(WonIpred(:,emgInd),IonIact(:,emgInd));
muscleVAF.SonI = calculateVAF(SonIpred(:,emgInd),IonIact(:,emgInd));
muscleVAF.H3onI = calculateVAF(H3onIpred(:,emgInd),IonIact(:,emgInd));
legend('Actual',strcat('Within | vaf=',num2str(muscleVAF.IonI)),strcat('Hybrid | vaf=',num2str(muscleVAF.HonI)),strcat('Move | vaf=',num2str(muscleVAF.WonI)),strcat('Spring | vaf=',num2str(muscleVAF.SonI)),strcat('H3 | vaf=',num2str(muscleVAF.H3onI)))
MillerFigure

% Save figure
if save == 1
    SaveFigure(foldername, strcat(filename,'_',char(IsoBinned.emgguide(emgInd))))
end


end