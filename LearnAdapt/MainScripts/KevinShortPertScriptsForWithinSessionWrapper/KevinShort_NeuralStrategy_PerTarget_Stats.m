function Tp=KevinShort_NeuralStrategy_PerTarget_Stats(binnedPerturbation1,binnedPerturbation2,binnedPerturbation3, N2E, E2F_normal)

 binnedPerturbationPreds1=MakeNeuralStrategyFile(binnedPerturbation1, N2E, E2F_normal);
 binnedPerturbationPreds2=MakeNeuralStrategyFile(binnedPerturbation2, N2E, E2F_normal);
 binnedPerturbationPreds3=MakeNeuralStrategyFile(binnedPerturbation3, N2E, E2F_normal);
 [ErrorAngles1, TargetNumberPerTrial1]=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbationPreds1,5,'k',0,.8);
 [ErrorAngles2, TargetNumberPerTrial2]=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbationPreds2,5,'k',0,.8);
 [ErrorAngles3, TargetNumberPerTrial3]=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbationPreds3,5,'k',0,.8);
 
 ErrorAngles=cat(1,ErrorAngles1,ErrorAngles2,ErrorAngles3);
 TargetNumberPerTrial=cat(1,TargetNumberPerTrial1,TargetNumberPerTrial2,TargetNumberPerTrial3);
 
 ErrorAnglesPerTargetCell=SeparateOutByTarget(ErrorAngles, TargetNumberPerTrial);
 
 % Stats signrank ----------------------------------------------------------
 numSamples=10;
 Tp(1)=signrank(ErrorAnglesPerTargetCell{1,1}(1:numSamples),ErrorAnglesPerTargetCell{1,1}(end-numSamples+1:end));
 Tp(2)=signrank(ErrorAnglesPerTargetCell{1,2}(1:numSamples),ErrorAnglesPerTargetCell{1,2}(end-numSamples+1:end));
Tp(3)=signrank(ErrorAnglesPerTargetCell{1,3}(1:numSamples),ErrorAnglesPerTargetCell{1,3}(end-numSamples+1:end));
Tp(4)=signrank(ErrorAnglesPerTargetCell{1,4}(1:numSamples),ErrorAnglesPerTargetCell{1,4}(end-numSamples+1:end));
Tp(5)=signrank(ErrorAnglesPerTargetCell{1,5}(1:numSamples),ErrorAnglesPerTargetCell{1,5}(end-numSamples+1:end));
Tp(6)=signrank(ErrorAnglesPerTargetCell{1,6}(1:numSamples),ErrorAnglesPerTargetCell{1,6}(end-numSamples+1:end));
Tp(7)=signrank(ErrorAnglesPerTargetCell{1,7}(1:numSamples),ErrorAnglesPerTargetCell{1,7}(end-numSamples+1:end));
Tp(8)=signrank(ErrorAnglesPerTargetCell{1,8}(1:numSamples),ErrorAnglesPerTargetCell{1,8}(end-numSamples+1:end));
Tp=Tp';
Tp=Tp./2;
% -------------------------------------------------------------------------

end

function binnedPerturbationPreds=MakeNeuralStrategyFile(binnedPerturbationNumber, N2E, E2F_normal)

% Put trajectory predictions into binnedRotatedPreds
[~, PertBrain_NormalDecoder_PositionPreds] = ApplyCascadeDecoders(binnedPerturbationNumber, N2E, E2F_normal);
binnedPerturbationPreds=binnedPerturbationNumber;
binnedPerturbationPreds.cursorposbin=PertBrain_NormalDecoder_PositionPreds;

end