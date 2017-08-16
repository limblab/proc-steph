
function PlotEMGforKinematicsSanityCheck(IsoBinned,WmBinned,SprBinned)

% Get the data for the 4 muscles isolated in variables for each task
binnedData = IsoBinned;
EMGind1 = strmatch('ECR',(binnedData.emgguide)); EMGind1 = EMGind1(1);
EMGind2 = strmatch('FCU',(binnedData.emgguide)); EMGind2 = EMGind2(1);
EMGind3 = strmatch('FCR',(binnedData.emgguide)); EMGind3 = EMGind3(1);
emg_vector = [EMGind1 EMGind2 EMGind3];
IsoEMGs = IsoBinned.emgdatabin(:,emg_vector);
WmEMGs = WmBinned.emgdatabin(:,emg_vector);
SprEMGs = SprBinned.emgdatabin(:,emg_vector);

figure; hold on;
plot(IsoEMGs,'g')
plot(SprEMGs,'m')
plot(WmEMGs,'b')




%figure; LineWidth=1.5; EMGlist = ['ECR'; 'ECU';'FCR';'FCU'];
figure; LineWidth=1.5; EMGlist = ['ECR';'FCU';'FCR'];
for c=1:3
    subplot(3,1,c);hold on;
    title(EMGlist(c,:));
    if c==1
         legend({'Move','Iso','Spr'})
    end
    plot(0:0.05:50-.05,WmEMGs(1:1000,c),'Color',[1 0.5 0],'LineWidth',3); ylim([0 30]);%xlim([2 20])%xlim([40 160]) %xlim([0 160])
    plot(0:0.05:50-.05,IsoEMGs(1:1000,c),'.-','Color',[0.5 0.5 1],'LineWidth',1.5); %ylim([0 30]);xlim([2 20])%xlim([40 160]) %xlim([0 160])
    plot(0:0.05:50-.05,SprEMGs(1:1000,c),'Color',[0 0 0],'LineWidth',2); ylim([0 30]);%xlim([2 20])%xlim([0 160])
    MillerFigure
end
xlabel('Time (sec)')
  legend({'Move','Iso','Spr'})
  
end