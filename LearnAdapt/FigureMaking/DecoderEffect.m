%Decoder effect figure

% Normal Hand control through rot decoder
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_082615_binnedDec_rot.mat')
[~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_rotated);
[PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedIsoHC,PertDecoder_NormBrain_Pos,.5);
plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)
title('Normal HC brain through Rot Decoder')

% Normal Hand control through normal decoder
[~, NormDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_normal);
[PredTrajX_NormDec_NormBrain, PredTrajY_NormDec_NormBrain, TargetNum_NormDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedIsoHC,NormDecoder_NormBrain_Pos,0.5);
plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_NormDec_NormBrain, PredTrajY_NormDec_NormBrain, TargetNum_NormDec_NormBrain)
title('Normal HC brain through Normal Decoder')


clear

load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_080915_binnedDec_ref.mat')
[~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_reflected);
[PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedIsoHC,PertDecoder_NormBrain_Pos,0.5);
plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)
title('Normal HC brain through Ref Decoder')

% Normal Hand control through normal decoder
[~, NormDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_normal);
[PredTrajX_NormDec_NormBrain, PredTrajY_NormDec_NormBrain, TargetNum_NormDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedIsoHC,NormDecoder_NormBrain_Pos,0.5);
plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_NormDec_NormBrain, PredTrajY_NormDec_NormBrain, TargetNum_NormDec_NormBrain)
title('Normal HC brain through Normal Decoder')


% MUSCLE TUNING ---------------------------------------------------
LearnAdapt_MuscleTuningData(binnedIsoHC,0.5)

% thetaticks(0:45:360)
% thetaticklabel(1:8)


%Kevin---------------------------------------
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_050115_binnedDec_rot.mat')
[~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_rotated);
[PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedIsoHC,PertDecoder_NormBrain_Pos,.5);
plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)
title('Normal HC brain through Ref Decoder')

clear

load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\ShorPert_Kevin_042315_binnedDec_ref.mat')
[~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_reflected);
[PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedIsoHC,PertDecoder_NormBrain_Pos,.5);
plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)
title('Normal HC brain through Ref Decoder')

% MUSCLE TUNING ---------------------------------------------------
LearnAdapt_MuscleTuningData(binnedIsoHC,0.5)