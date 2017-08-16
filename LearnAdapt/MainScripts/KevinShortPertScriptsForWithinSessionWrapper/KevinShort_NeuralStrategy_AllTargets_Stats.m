function Tp=KevinShort_NeuralStrategy_AllTargets_Stats(binnedPerturbation1,binnedPerturbation2,binnedPerturbation3, N2E, E2F_normal)

 binnedPerturbationPreds1=MakeNeuralStrategyFile(binnedPerturbation1, N2E, E2F_normal);
 binnedPerturbationPreds2=MakeNeuralStrategyFile(binnedPerturbation2, N2E, E2F_normal);
 binnedPerturbationPreds3=MakeNeuralStrategyFile(binnedPerturbation3, N2E, E2F_normal);
[ErrorAngles1]=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbationPreds1,5,'k',0,0.8);
[ErrorAngles2]=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbationPreds2,5,'k',0,.8);
[ErrorAngles3]=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbationPreds3,5,'k',0,.8);

ErrorAngles=cat(1,ErrorAngles1,ErrorAngles2,ErrorAngles3);

% Stats signrank ---------------------------------------------------------
numSamples=40;
Tp=(signrank(ErrorAngles(1:numSamples),ErrorAngles(end-numSamples+1:end)))./2;

end

function binnedPerturbationPreds=MakeNeuralStrategyFile(binnedPerturbationNumber, N2E, E2F_normal)

% Put trajectory predictions into binnedRotatedPreds
[~, PertBrain_NormalDecoder_PositionPreds] = ApplyCascadeDecoders(binnedPerturbationNumber, N2E, E2F_normal);
binnedPerturbationPreds=binnedPerturbationNumber;
binnedPerturbationPreds.cursorposbin=PertBrain_NormalDecoder_PositionPreds;

end