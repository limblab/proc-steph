function PlotAllSpringAcrossPredictionssingleEMG(SprBinned,SonSact,SonSpred,IonSpred,WonSpred,HonSpred,emgInd,save,foldername, filename)
% Run this after you run the main generalizability code

if nargin < 8
    save=0;
end

%Make figures
% Make figure showing across, within predictions
linewidth = 1.5;
x = (0:0.05:length(SonSact)*.05-0.05)';
% Plot predictions of isometric data---------------------------------------
%--------------------------------------------------------------------------
hold on;
start=195;stop=215;
start=86;stop=106;
plot(x,SonSact(:,emgInd),'k','LineWidth', linewidth)
plot(x,SonSpred(:,emgInd),'b','LineWidth', linewidth)
plot(x,HonSpred(:,emgInd),'c','LineWidth', linewidth)
plot(x,IonSpred(:,emgInd),'m', 'LineWidth', linewidth)
plot(x,WonSpred(:,emgInd),'g','LineWidth', linewidth)
xlabel('Time (sec)')
xlim([start stop]);ylim([-.1 1]);set(gca,'YTick', -.1:.1:1);
title(strcat(num2str(SprBinned.meta.datetime(1:9)), ':', SprBinned.emgguide(emgInd), ' Predictions | Spring data'))
% %vafs of the whole segment
% muscleVAF.SonS = calculateVAF(SonSpred(:,emgInd),SonSact(:,emgInd));
% muscleVAF.HonS = calculateVAF(HonSpred(:,emgInd),SonSact(:,emgInd));
% muscleVAF.IonS = calculateVAF(IonSpred(:,emgInd),SonSact(:,emgInd));
% muscleVAF.WonS = calculateVAF(WonSpred(:,emgInd),SonSact(:,emgInd));
startbinned=start/.05;stopbinned=stop/.05;
muscleVAF.SonS = calculateVAF(SonSpred(startbinned:stopbinned,emgInd),SonSact(startbinned:stopbinned,emgInd));
muscleVAF.HonS = calculateVAF(HonSpred(startbinned:stopbinned,emgInd),SonSact(startbinned:stopbinned,emgInd));
muscleVAF.IonS = calculateVAF(IonSpred(startbinned:stopbinned,emgInd),SonSact(startbinned:stopbinned,emgInd));
muscleVAF.WonS = calculateVAF(WonSpred(startbinned:stopbinned,emgInd),SonSact(startbinned:stopbinned,emgInd));
legend('Actual',strcat('Within | vaf=',num2str(muscleVAF.SonS)),strcat('Hybrid | vaf=',num2str(muscleVAF.HonS)),strcat('Iso | vaf=',num2str(muscleVAF.IonS)),strcat('Move | vaf=',num2str(muscleVAF.WonS)))
MillerFigure

% Save figure
if save == 1
    SaveFigure(foldername, strcat(filename,'_',char(IsoBinned.emgguide(emgInd))))
end


end