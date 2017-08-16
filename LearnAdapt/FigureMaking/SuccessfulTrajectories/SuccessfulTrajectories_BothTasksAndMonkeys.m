
% JANGO

% first day, mean of all successes from Go to 
% load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_080415_binnedDec_rot.mat')
% [TrajectoriesX, TrajectoriesY, TargetNumber] = SuccessfulInitialTrajectories(binnedRotatedBC,1.2);
% [NewTrajX, NewTrajY, NewTargetNumber]=First_X_trajectoriesToEachTarget(TrajectoriesX,TrajectoriesY,TargetNumber);
% %plotInitialTrajectoriesPerTarget(binnedRotatedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
% plotInitialTrajectoriesPerTarget(binnedRotatedBC,NewTrajX,NewTrajY, NewTargetNumber)
% title('First rotated day')
% axis off
% load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_080515_binnedDec_rot.mat')
% [TrajectoriesX2, TrajectoriesY2, TargetNumber2] = SuccessfulInitialTrajectories(binnedRotatedBC,1);
% [NewTrajX2, NewTrajY2, NewTargetNumber2]=First_X_trajectoriesToEachTarget(TrajectoriesX2,TrajectoriesY2,TargetNumber2);
% NewTrajX3=cat(1,NewTrajX,NewTrajX2);NewTrajY3=cat(1,NewTrajY,NewTrajY2);NewTargetNumber3=cat(1,NewTargetNumber,NewTargetNumber2);
% plotInitialTrajectoriesPerTarget(binnedRotatedBC,NewTrajX3,NewTrajY3, NewTargetNumber3)
% axis off

% all trajectories
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_080415_binnedDec_rot.mat')
[TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedRotatedBC,1);
[NewTrajX, NewTrajY, NewTargetNumber]=First_X_trajectoriesToEachTarget(TrajectoriesX,TrajectoriesY,TargetNumber);
%plotInitialTrajectoriesPerTarget(binnedRotatedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
plotInitialTrajectoriesPerTarget(binnedRotatedBC,NewTrajX,NewTrajY, NewTargetNumber)
title('First rotated day all trajectories')
axis off


% last day, mean of all successes from Go to 
% load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_092915_binnedDec_rot.mat')
% [TrajectoriesX, TrajectoriesY, TargetNumber] = SuccessfulInitialTrajectories(binnedRotatedBC,1);
% [NewTrajX, NewTrajY, NewTargetNumber]=First_X_trajectoriesToEachTarget(TrajectoriesX,TrajectoriesY,TargetNumber);
% %plotInitialTrajectoriesPerTarget(binnedRotatedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
% plotInitialTrajectoriesPerTarget(binnedRotatedBC,NewTrajX,NewTrajY, NewTargetNumber)
% title('Last rotated day successful trajectories')
% axis off

% last rotated day all trajectories
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_092915_binnedDec_rot.mat')
[TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedRotatedBC,1);
[NewTrajX, NewTrajY, NewTargetNumber]=First_X_trajectoriesToEachTarget(TrajectoriesX,TrajectoriesY,TargetNumber);
%plotInitialTrajectoriesPerTarget(binnedRotatedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
plotInitialTrajectoriesPerTarget(binnedRotatedBC,NewTrajX,NewTrajY, NewTargetNumber)
title('Last rotated day all trajectories')
axis off



% reflected first day
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_073115_binnedDec_ref.mat')
[TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedReflectedBC,1);
[NewTrajX, NewTrajY, NewTargetNumber]=First_X_trajectoriesToEachTarget(TrajectoriesX,TrajectoriesY,TargetNumber);
%plotInitialTrajectoriesPerTarget(binnedRotatedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
plotInitialTrajectoriesPerTarget(binnedReflectedBC,NewTrajX,NewTrajY, NewTargetNumber)
title('First reflected day')
axis off


% reflected last day
 load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_092815_binnedDec_ref.mat')
[TrajectoriesX, TrajectoriesY, TargetNumber] =SuccessfulInitialTrajectories(binnedReflectedBC,1);
[NewTrajX, NewTrajY, NewTargetNumber]=First_X_trajectoriesToEachTarget(TrajectoriesX,TrajectoriesY,TargetNumber);
%plotInitialTrajectoriesPerTarget(binnedRotatedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
plotInitialTrajectoriesPerTarget(binnedReflectedBC,NewTrajX,NewTrajY, NewTargetNumber)
title('Last reflected day')
axis off







% KEVIN
% first day, mean of all successes from Go to 
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\ShorPert_Kevin_040315_binnedDec_rot.mat')
[TrajectoriesX, TrajectoriesY, TargetNumber] = SuccessfulInitialTrajectories(binnedRotated1,1);
plotInitialTrajectoriesPerTarget(binnedRotated1,TrajectoriesX,TrajectoriesY, TargetNumber)
axis off


% last day, mean of all successes from Go to 
 load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_061315_binnedDec_rot.mat')
[TrajectoriesX, TrajectoriesY, TargetNumber] = SuccessfulInitialTrajectories(binnedRotatedBC,1);
plotInitialTrajectoriesPerTarget(binnedRotatedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
axis off


% reflected first day
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\ShorPert_Kevin_040215_binnedDec_ref.mat')
[TrajectoriesX, TrajectoriesY, TargetNumber] = SuccessfulInitialTrajectories(binnedReflected1,2);
plotInitialTrajectoriesPerTarget(binnedReflected1,TrajectoriesX,TrajectoriesY, TargetNumber)
axis off


% reflected last day
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_061415_binnedDec_ref.mat')
[TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedReflectedBC,4);
[NewTrajX, NewTrajY, NewTargetNumber]=First_X_trajectoriesToEachTarget(TrajectoriesX,TrajectoriesY,TargetNumber);
%plotInitialTrajectoriesPerTarget(binnedReflectedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
plotInitialTrajectoriesPerTarget(binnedReflectedBC,NewTrajX,NewTrajY, NewTargetNumber)
title('Last reflected day')
axis off

