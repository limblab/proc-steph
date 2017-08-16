function Tp=PlotInitialTrajectoryOffset_IdealBase_AllTrials_AllBlocks(binnedIsoHC,binnedNormalBC,binnedPerturbation,binnedWashout,MonkeyandDate, tasktype,NumOfSamples,TimeAfterGo)

figure
subplot(1,4,1)
ErrorAngles_IsoHC=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedIsoHC,1,'k',0,TimeAfterGo);
plot(movmean(ErrorAngles_IsoHC,NumOfSamples),'k.')
xlabel('Hand control')
ylim([0 90])
MillerFigure
title(strcat(MonkeyandDate,'TrajOffset'), 'Interpreter', 'none')

subplot(1,4,2)
ErrorAngles_NormalBC=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedNormalBC,1,'k',0,TimeAfterGo);
plot(movmean(ErrorAngles_NormalBC,NumOfSamples),'k.')
xlabel('Normal BC')
ylim([0 90])
MillerFigure

subplot(1,4,3)
ErrorAngles_PertBC=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbation,1,'k',0,TimeAfterGo);
% Stats signrank ---------------------------------------------------------
numSamples=40;
Tp=(signrank(ErrorAngles_PertBC(1:numSamples),ErrorAngles_PertBC(end-numSamples+1:end)))./2;
% -------------------------------------------------------------------------
plot(movmean(ErrorAngles_PertBC,NumOfSamples),'c.')
if Tp<=0.05
    title('Significant')
end
xlabel([strcat(tasktype),' BC'])
ylim([0 90])
MillerFigure


subplot(1,4,4)
ErrorAngles_WashBC=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedWashout,1,'k',0,TimeAfterGo);
plot(movmean(ErrorAngles_WashBC,NumOfSamples),'m.')
ylim([0 90])
xlabel('Washout')
MillerFigure

end
