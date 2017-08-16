% Pert Decoder Through Normal Brain Figure


%%needs to be fixed 4/17

% ROTATED DECODER APPLIED TO NORMAL NEURAL ACTIVITY --------------
%load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_082615_binnedDec_rot.mat')
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_050115_binnedDec_rot.mat')
[~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedNormalBC, N2E, E2F_rotated);
[PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedNormalBC,PertDecoder_NormBrain_Pos,0.5);
plotInitialTrajectoriesPerTarget(binnedNormalBC,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)
title('Rotated Decoder Applied to Normal Activity')


clear

% REFLECTED DECODER APPLIED TO NORMAL NEURAL ACTIVITY --------------
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_073115_binnedDec_ref.mat')
[~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedNormal1, N2E, E2F_reflected);
[PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedNormal1,PertDecoder_NormBrain_Pos,0.5);
plotInitialTrajectoriesPerTarget(binnedNormal1,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)

title('Reflected Decoder Applied to Normal Activity')


% MUSCLE TUNING ---------------------------------------------------
LearnAdapt_MuscleTuningData(binnedIsoHC,0.8)
%suptitle('Muscle Tuning During Normal Hand Control')

