
%EarlyVLateTrajectories
binnedPerturbation=binnedRotatedBC;

% First 5 minutes
FileLength=length(binnedPerturbation.timeframe);
FirstFive = cutBinnedDataFile(binnedPerturbation, 6001, FileLength); % last 5 minutes (cut away first 10 min)

% Last 5 minutes
LastFive = cutBinnedDataFile(binnedPerturbation, 1, FileLength-6000); % last 5 minutes (cut away first 10 min)
LastFive.timeframe=binnedPerturbation.timeframe(FileLength-6000:FileLength);
LastFive.timeframe(6001)=[];

[TrajectoriesX_NormalBC, TrajectoriesY_NormalBC, TargetNumber_NormalBC] = InitialTrajectories(FirstFive,.4);
plotInitialTrajectoriesPerTarget(FirstFive,TrajectoriesX_NormalBC,TrajectoriesY_NormalBC, TargetNumber_NormalBC);
title('First 5 minutes')

[TrajectoriesX_NormalBC, TrajectoriesY_NormalBC, TargetNumber_NormalBC] = InitialTrajectories(LastFive,.4);
plotInitialTrajectoriesPerTarget(LastFive,TrajectoriesX_NormalBC,TrajectoriesY_NormalBC, TargetNumber_NormalBC);
title('Last 5 minutes')


%%
 [~, NormDecoder_PertBrain_Pos] = ApplyCascadeDecoders(FirstFive, N2E, E2F_normal);
[PredTrajX_NormDec_PertBrain, PredTrajY_NormDec_PertBrain, TargetNum_NormDec_PertBrain]= InitialTrajectories_UsingPredictions(FirstFive,NormDecoder_PertBrain_Pos,1);
plotInitialTrajectoriesPerTarget(FirstFive,PredTrajX_NormDec_PertBrain, PredTrajY_NormDec_PertBrain, TargetNum_NormDec_PertBrain)
title('Ref Brain, Normal Decoder | First 5 minutes')

 [~, NormDecoder_PertBrain_Pos] = ApplyCascadeDecoders(LastFive, N2E, E2F_normal);
[PredTrajX_NormDec_PertBrain, PredTrajY_NormDec_PertBrain, TargetNum_NormDec_PertBrain]= InitialTrajectories_UsingPredictions(LastFive,NormDecoder_PertBrain_Pos,1);
plotInitialTrajectoriesPerTarget(LastFive,PredTrajX_NormDec_PertBrain, PredTrajY_NormDec_PertBrain, TargetNum_NormDec_PertBrain)
title('Ref Brain, Normal Decoder | Last 5 minutes')



% Put trajectory predictions into binnedRotatedPreds
[~, RefBrain_NormalDecoder_PositionPreds] = ApplyCascadeDecoders(binnedReflectedBC, N2E, E2F_normal);
binnedReflectedPreds=binnedReflectedBC;
binnedReflectedPreds.cursorposbin=RefBrain_NormalDecoder_PositionPreds;
PlotInitialTrajectoryOffset_IdealBaseVector(binnedReflectedPreds)





% ------------------------------------------------------------------------


% Rotated

binnedPerturbation=binnedRotatedBC;


% First 5 minutes
FileLength=length(binnedPerturbation.timeframe);
FirstFive = cutBinnedDataFile(binnedPerturbation, 6001, FileLength); % last 5 minutes (cut away first 10 min)

% Last 5 minutes
LastFive = cutBinnedDataFile(binnedPerturbation, 1, FileLength-6000); % last 5 minutes (cut away first 10 min)
LastFive.timeframe=binnedPerturbation.timeframe(FileLength-6000:FileLength);
LastFive.timeframe(6001)=[];

[TrajectoriesX_NormalBC, TrajectoriesY_NormalBC, TargetNumber_NormalBC] = InitialTrajectories(FirstFive,0.5);
plotInitialTrajectoriesPerTarget(FirstFive,TrajectoriesX_NormalBC,TrajectoriesY_NormalBC, TargetNumber_NormalBC);
title('Rotated | First 5 minutes')

[TrajectoriesX_NormalBC, TrajectoriesY_NormalBC, TargetNumber_NormalBC] = InitialTrajectories(LastFive,1);
plotInitialTrajectoriesPerTarget(LastFive,TrajectoriesX_NormalBC,TrajectoriesY_NormalBC, TargetNumber_NormalBC);
title('Rotated | Last 5 minutes')


 [~, NormDecoder_PertBrain_Pos] = ApplyCascadeDecoders(FirstFive, N2E, E2F_normal);
[PredTrajX_NormDec_PertBrain, PredTrajY_NormDec_PertBrain, TargetNum_NormDec_PertBrain]= InitialTrajectories_UsingPredictions(FirstFive,NormDecoder_PertBrain_Pos,0.5);
plotInitialTrajectoriesPerTarget(FirstFive,PredTrajX_NormDec_PertBrain, PredTrajY_NormDec_PertBrain, TargetNum_NormDec_PertBrain)
title('Rot Brain, Normal Decoder | First 5 minutes')

 [~, NormDecoder_PertBrain_Pos] = ApplyCascadeDecoders(LastFive, N2E, E2F_normal);
[PredTrajX_NormDec_PertBrain, PredTrajY_NormDec_PertBrain, TargetNum_NormDec_PertBrain]= InitialTrajectories_UsingPredictions(LastFive,NormDecoder_PertBrain_Pos,0.5);
plotInitialTrajectoriesPerTarget(LastFive,PredTrajX_NormDec_PertBrain, PredTrajY_NormDec_PertBrain, TargetNum_NormDec_PertBrain)
title('Rot Brain, Normal Decoder | Last 5 minutes')



% Put trajectory predictions into binnedRotatedPreds
[~, RotBrain_NormalDecoder_PositionPreds] = ApplyCascadeDecoders(binnedRotatedBC, N2E, E2F_normal);
binnedRotatedPreds=binnedRotatedBC;
binnedRotatedPreds.cursorposbin=RotBrain_NormalDecoder_PositionPreds;
PlotInitialTrajectoryOffset_IdealBaseVector(binnedRotatedPreds)













