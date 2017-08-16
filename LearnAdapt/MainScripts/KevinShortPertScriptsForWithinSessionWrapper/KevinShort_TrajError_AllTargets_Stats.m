function Tp=KevinShort_TrajError_AllTargets_Stats(binnedPerturbation1,binnedPerturbation2,binnedPerturbation3,TimeAfterGo)


ErrorAngles_PertBC1=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbation1,1,'k',0,TimeAfterGo);
ErrorAngles_PertBC2=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbation2,1,'k',0,TimeAfterGo);
ErrorAngles_PertBC3=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbation3,1,'k',0,TimeAfterGo);


[AllErrorAngles_PertBC] = cat(1,ErrorAngles_PertBC1,ErrorAngles_PertBC2,ErrorAngles_PertBC3);

% Stats signrank ---------------------------------------------------------
numSamples=40;
Tp=(signrank(AllErrorAngles_PertBC(1:numSamples),AllErrorAngles_PertBC(end-numSamples+1:end)))./2;


end