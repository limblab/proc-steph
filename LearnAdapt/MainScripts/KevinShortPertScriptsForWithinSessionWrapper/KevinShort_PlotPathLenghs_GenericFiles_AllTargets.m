function Tp=KevinShort_PlotPathLenghs_GenericFiles_AllTargets(binnedPerturbation1,binnedPerturbation2,binnedPerturbation3)


[AllPathLengths_PertBC1] = CalculateAllPathLengths(binnedPerturbation1);
[AllPathLengths_PertBC2] = CalculateAllPathLengths(binnedPerturbation2);
[AllPathLengths_PertBC3] = CalculateAllPathLengths(binnedPerturbation3);
[AllPathLengths_PertBC] = cat(1,AllPathLengths_PertBC1,AllPathLengths_PertBC2,AllPathLengths_PertBC3);

% Stats signrank ---------------------------------------------------------
numSamples=40;
Tp=(signrank(AllPathLengths_PertBC(1:numSamples),AllPathLengths_PertBC(end-numSamples+1:end)))/2;


end