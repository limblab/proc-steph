function Tp=PlotPathLenghs_GenericFiles_AllTargets(binnedIsoHC,binnedNormalBC,binnedPerturabation,binnedWashoutBC,MonkeyandDate,tasktype)


SampleSmoothing=20;
figure
subplot(1,4,1)
[AllPathLengths_IsoHC] = CalculateAllPathLengths(binnedIsoHC);
plot(movmean(AllPathLengths_IsoHC,SampleSmoothing),'k.')
xlabel('Hand control')
ylim([0 70])
MillerFigure
title(MonkeyandDate(1:end-1), 'Interpreter', 'none')

subplot(1,4,2)
[AllPathLengths_NormalBC] = CalculateAllPathLengths(binnedNormalBC);
plot(movmean(AllPathLengths_NormalBC,SampleSmoothing),'k.')
xlabel('Normal BC')
ylim([0 90])
MillerFigure

subplot(1,4,3)
[AllPathLengths_PertBC] = CalculateAllPathLengths(binnedPerturabation);
% Stats signrank ---------------------------------------------------------
numSamples=40;
Tp=(signrank(AllPathLengths_PertBC(1:numSamples),AllPathLengths_PertBC(end-numSamples+1:end)))/2;
% -------------------------------------------------------------------------
plot(movmean(AllPathLengths_PertBC,SampleSmoothing),'c.')
if Tp<=0.05
    title('Significant')
end
xlabel([strcat(tasktype),' BC'])
ylim([0 90])
MillerFigure


subplot(1,4,4)
[AllPathLengths_WashBC] = CalculateAllPathLengths(binnedWashoutBC);
plot(movmean(AllPathLengths_WashBC,SampleSmoothing),'m.')
ylim([0 90])
xlabel('Washout')
MillerFigure



end
