function [ErrorAngles, TargetNumberPerTrial,Tp]=PlotNeuralStrategyAngleError_AllTrials(binnedPerturbation,N2E,E2F_normal,NumOfSamples,TimeAfterGo)

% Put trajectory predictions into binnedRotatedPreds
[~, PertBrain_NormalDecoder_PositionPreds] = ApplyCascadeDecoders(binnedPerturbation, N2E, E2F_normal);
binnedPerturbationPreds=binnedPerturbation;
binnedPerturbationPreds.cursorposbin=PertBrain_NormalDecoder_PositionPreds;

[ErrorAngles, TargetNumberPerTrial,Tp]=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbationPreds,NumOfSamples,'k',1,TimeAfterGo);

end