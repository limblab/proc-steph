% PlotPositionAndVelocityPredictions

LineWidth=1.5;

figure; hold on;
title('Spring')
plot(SonS_kin_predStruct.timeframe,SonS_kin_actTrunk(:,1),'k','LineWidth',LineWidth)
plot(SonS_kin_predStruct.timeframe,SonS_kin_predStruct.preddatabin(:,1),'Color',[0.5 0 1],'LineWidth',LineWidth)
plot(SonS_kin_predStruct.timeframe,HonS_kin_predStruct.preddatabin(:,1),'c','LineWidth',LineWidth)
plot(SonS_kin_predStruct.timeframe,IonS_kin_predStruct.preddatabin(:,1),'b','LineWidth',LineWidth)
plot(SonS_kin_predStruct.timeframe,WonS_kin_predStruct.preddatabin(:,1),'g','LineWidth',LineWidth)
legend('Actual',['Spring vaf: ' num2str(mean(SonS_kin_vaf(:,1)))],['H3 vaf: ' num2str(mean(HonS_kin_vaf(:,1)))],['Iso vaf: ' num2str(mean(IonS_kin_vaf(:,1)))],['Move vaf: ' num2str(mean(WonS_kin_vaf(:,1)))])
MillerFigure
xlabel('Time (seconds)')


figure; hold on;
title('Spring')
plot(SonS_kin_actTrunk(:,1),'k')
plot(IonS_kin_predStruct.preddatabin(:,1),'b','LineWidth',LineWidth)
plot(WonS_kin_predStruct.preddatabin(:,1),'r','LineWidth',LineWidth)
legend('Actual',['Iso vaf: ' num2str(mean(IonS_kin_vaf(:,1)))],['Move vaf: ' num2str(mean(WonS_kin_vaf(:,1)))])


%-

figure; hold on;
title('Movement')
plot(WonW_kin_predStruct.timeframe,WonW_kin_actTrunk(:,1),'k','LineWidth',LineWidth)
plot(WonW_kin_predStruct.timeframe,SonW_kin_predStruct.preddatabin(:,1),'Color',[0.5 0 1],'LineWidth',LineWidth)
plot(WonW_kin_predStruct.timeframe,HonW_kin_predStruct.preddatabin(:,1),'c','LineWidth',LineWidth)
plot(WonW_kin_predStruct.timeframe,IonW_kin_predStruct.preddatabin(:,1),'b','LineWidth',LineWidth)
plot(WonW_kin_predStruct.timeframe,WonW_kin_predStruct.preddatabin(:,1),'g','LineWidth',LineWidth)
legend('Actual',['Spring vaf: ' num2str(mean(SonW_kin_vaf(:,1)))],['H3 vaf: ' num2str(mean(HonW_kin_vaf(:,1)))],['Iso vaf: ' num2str(mean(IonW_kin_vaf(:,1)))],['Move vaf: ' num2str(mean(WonW_kin_vaf(:,1)))])
MillerFigure
xlabel('Time (seconds)')


figure; hold on;
title('Movement Position')
plot(WonW_kin_actTrunk(:,1),'k')
plot(IonW_kin_predStruct.preddatabin(:,1),'b','LineWidth',LineWidth)
plot(WonW_kin_predStruct.preddatabin(:,1),'r','LineWidth',LineWidth)
legend('Actual',['Iso vaf: ' num2str(mean(IonW_kin_vaf(:,1)))],['Move vaf: ' num2str(mean(WonW_kin_vaf(:,1)))])
MillerFigure

