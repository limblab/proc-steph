function [Targetp]=PlotNeuralStrategyAngleError_PerTarget(binnedPerturbation,N2E,E2F_normal,SubplotTitle,SecAfterGo)

% Put trajectory predictions into binnedRotatedPreds
[~, PertBrain_NormalDecoder_PositionPreds] = ApplyCascadeDecoders(binnedPerturbation, N2E, E2F_normal);
binnedPerturbationPreds=binnedPerturbation;
binnedPerturbationPreds.cursorposbin=PertBrain_NormalDecoder_PositionPreds;

% Plot
[Targetp]=PlotInitialTrajectoryOffset_IdealBaseVector(binnedPerturbationPreds,SecAfterGo,1,SubplotTitle);

end