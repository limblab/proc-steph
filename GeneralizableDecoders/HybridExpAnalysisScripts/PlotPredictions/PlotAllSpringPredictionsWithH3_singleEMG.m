function PlotAllSpringPredictionsWithH3_singleEMG(SprBinned,SprTest,SonSact,SonSpred,HonSpred,IonSpred,WonSpred,H3onSpred,VAFstruct,emgInd,save,foldername, filename)
% Run this after you run the main generalizability code

if nargin < 9
    save=0;
end


%Make figures
% Make figure showing hybrid, across, within predictions
linewidth = 1.5;
x = (0:0.05:length(SonSact)*.05-0.05)';
% Plot predictions of isometric data---------------------------------------
%--------------------------------------------------------------------------
hold on;
plot(x,SonSact(:,emgInd),'k','LineWidth', linewidth)
plot(x,SonSpred(:,emgInd),'Color',[0.5 0 1],'LineWidth', linewidth)
plot(x,HonSpred(:,emgInd),'y','LineWidth', linewidth)
plot(x,IonSpred(:,emgInd),'b','LineWidth', linewidth)
plot(x,WonSpred(:,emgInd),'g','LineWidth', linewidth)
plot(x,H3onSpred(:,emgInd),'c','LineWidth', linewidth)
xlabel('Time (sec)')
xlim([30 50]);ylim([-.15 1])
muscleVAF.SonS = calculateVAF(SonSpred(:,emgInd),SonSact(:,emgInd));
muscleVAF.HonS = calculateVAF(HonSpred(:,emgInd),SonSact(:,emgInd));
muscleVAF.IonS = calculateVAF(IonSpred(:,emgInd),SonSact(:,emgInd));
muscleVAF.WonS = calculateVAF(WonSpred(:,emgInd),SonSact(:,emgInd));
muscleVAF.H3onS = calculateVAF(H3onSpred(:,emgInd),SonSact(:,emgInd));
title(strcat(num2str(SprBinned.meta.datetime(1:9)), ':', SprBinned.emgguide(emgInd), ' Predictions | Spring data'))
legend('Actual',strcat('Within | vaf=',num2str(muscleVAF.SonS)),strcat('Hybrid | vaf=',num2str(muscleVAF.HonS)),strcat('I on S | vaf=',num2str(muscleVAF.IonS)),strcat('W on S | vaf=',num2str(muscleVAF.WonS)),strcat('H3 on S | vaf=',num2str(muscleVAF.H3onS)));
MillerFigure


% Save figure
if save == 1
    SaveFigure(foldername, filename)
end
 

end