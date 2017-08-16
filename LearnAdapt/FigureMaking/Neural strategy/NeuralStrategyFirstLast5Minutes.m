%NeuralStrategy and also first and last fiveminutes

% Put trajectory predictions into binnedRotatedPreds
binnedPerturbation=binnedRotatedBC;
%binnedPerturbation=binnedReflectedBC;
[~, PertBrain_NormalDecoder_PositionPreds] = ApplyCascadeDecoders(binnedPerturbation, N2E, E2F_normal);
binnedPerturbationPreds=binnedPerturbation;
binnedPerturbationPreds.cursorposbin=PertBrain_NormalDecoder_PositionPreds;
PlotInitialTrajectoryOffset_IdealBaseVector(binnedPerturbationPreds,1)

% First 5 minutes
FileLength=length(binnedPerturbationPreds.timeframe);
FirstFive = cutBinnedDataFile(binnedPerturbationPreds, 6001, FileLength); % last 5 minutes (cut away first 10 min)

% Last 5 minutes
LastFive = cutBinnedDataFile(binnedPerturbationPreds, 1, FileLength-6000); % last 5 minutes (cut away first 10 min)
LastFive.timeframe=binnedPerturbationPreds.timeframe(FileLength-6000:FileLength);
LastFive.timeframe(6001)=[];

[TrajX, TrajY, TgtNum] = InitialTrajectories(FirstFive,0.6);
plotInitialTrajectoriesPerTarget(FirstFive,TrajX,TrajY, TgtNum);
title('First five')

TrajX=[]; TrajY=[]; TgtNum=[];

[TrajX, TrajY, TgtNum] = InitialTrajectories(LastFive,0.6);
plotInitialTrajectoriesPerTarget(FirstFive,TrajX,TrajY, TgtNum);
title('Last five')
