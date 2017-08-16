
% Initial Trajectories Figure
% First traj to each target for each day
PlotFirstTrajectoryToEachTarget_ForEachDay('Jango','ref')
PlotFirstTrajectoryToEachTarget_ForEachDay('Jango','rot')
% Make sure you are looking from Go to Go+0.5seconds

PlotFirstTrajectoryToEachTarget_ForEachDay('Kevin','ref')
PlotFirstTrajectoryToEachTarget_ForEachDay('Kevin','rot')








% Rotated -----------------------------------------------------------------
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_082615_binnedDec_rot.mat')
binnedPerturbation=binnedRotatedBC;
% Plot Normal Case
[TrajectoriesX_NormalBC, TrajectoriesY_NormalBC, TargetNumber_NormalBC] = InitialTrajectories(binnedNormalBC,.5);
plotInitialTrajectoriesPerTarget(binnedNormalBC,TrajectoriesX_NormalBC,TrajectoriesY_NormalBC, TargetNumber_NormalBC);
title('Jango 8/26 NormalBC Initial Trajectories')
% Plot Rotated Case
[TrajectoriesX_PertBC, TrajectoriesY_PertBC, TargetNumber_PertBC] = InitialTrajectories(binnedPerturbation,.5);
plotInitialTrajectoriesPerTarget(binnedPerturbation,TrajectoriesX_PertBC,TrajectoriesY_PertBC, TargetNumber_PertBC)
title('Jango 8/26 Rotated Initial Trajectories')

% Reflected ---------------------------------------------------------------
clear
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_082415_binnedDec_ref.mat')
binnedPerturbation=binnedReflectedBC;
% Plot Normal Case
[TrajectoriesX_NormalBC, TrajectoriesY_NormalBC, TargetNumber_NormalBC] = InitialTrajectories(binnedNormalBC,.5);
plotInitialTrajectoriesPerTarget(binnedNormalBC,TrajectoriesX_NormalBC,TrajectoriesY_NormalBC, TargetNumber_NormalBC);
title('Jango 8/24 NormalBC Initial Trajectories')
% Plot Reflected Cage
[TrajectoriesX_PertBC, TrajectoriesY_PertBC, TargetNumber_PertBC] = InitialTrajectories(binnedPerturbation,.5);
plotInitialTrajectoriesPerTarget(binnedPerturbation,TrajectoriesX_PertBC,TrajectoriesY_PertBC, TargetNumber_PertBC)
title('Jango 8/24 Reflected Initial Trajectories')



