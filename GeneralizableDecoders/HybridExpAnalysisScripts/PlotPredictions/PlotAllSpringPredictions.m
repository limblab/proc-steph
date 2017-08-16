function PlotAllSpringPredictions(SprBinned,SprTest,SonSact,SonSpred,HonSpred,IonSpred,WonSpred, VAFstruct,emgInd,save,foldername, filename)
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
plot(x,SonSpred(:,emgInd),'b','LineWidth', linewidth)
plot(x,HonSpred(:,emgInd),'g','LineWidth', linewidth)
plot(x,IonSpred(:,emgInd),'r','LineWidth', linewidth)
plot(x,WonSpred(:,emgInd),'m','LineWidth', linewidth)
xlabel('Time (sec)')
xlim([30 50]);ylim([-.15 1])
muscleVAF.SonS = calculateVAF(SonSpred(:,emgInd),SonSact(:,emgInd));
muscleVAF.HonS = calculateVAF(HonSpred(:,emgInd),SonSact(:,emgInd));
muscleVAF.IonS = calculateVAF(IonSpred(:,emgInd),SonSact(:,emgInd));
muscleVAF.WonS = calculateVAF(WonSpred(:,emgInd),SonSact(:,emgInd));
title(strcat(num2str(SprBinned.meta.datetime(1:9)), ':', SprBinned.emgguide(emgInd), ' Predictions | Spring data'))
legend('Actual',strcat('Within | vaf=',num2str(muscleVAF.SonS)),strcat('Hybrid | vaf=',num2str(muscleVAF.HonS)),strcat('I on S | vaf=',num2str(muscleVAF.IonS)),strcat('W on S | vaf=',num2str(muscleVAF.WonS)));
MillerFigure


% Save figure
if save == 1
    SaveFigure(foldername, filename)
end
 

end