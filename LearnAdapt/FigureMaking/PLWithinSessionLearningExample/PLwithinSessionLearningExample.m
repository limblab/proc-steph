
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_061315_binnedDec_rot.mat')
 [AllPathLengths_Perturbation,PathLengthTargets] = CalculateAllPathLengths(binnedRotatedBC);
 NumOfSamples=5;
PathLengthPerTargetCell=SeparateOutByTarget(AllPathLengths_Perturbation, PathLengthTargets);
% Go through and smooth each target
for Tgt=1:8
    SmoothPLPerTargetCell{1,Tgt}=movmean(PathLengthPerTargetCell{1,Tgt},NumOfSamples);
end
 
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure; hold on; MillerFigure;
for Tgt=1:8
    location= subplotLocations(Tgt);
    %subplot(5,5,location); hold on
   plot(SmoothPLPerTargetCell{1,Tgt},'.-','Color',colors(Tgt,:),'MarkerSize',5)
    title('Rot Smooth')    
end


colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure; hold on
for Tgt=1:8
    location= subplotLocations(Tgt);
    %subplot(5,5,location); hold on
    plot(PathLengthPerTargetCell{1,Tgt},'.-','Color',colors(Tgt,:),'MarkerSize',5)
    title('Rot All')
    MillerFigure;
end
MillerFigure

%%

clear
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_061415_binnedDec_ref.mat')
 [AllPathLengths_Perturbation,PathLengthTargets] = CalculateAllPathLengths(binnedReflectedBC);
 NumOfSamples=5;
PathLengthPerTargetCell=SeparateOutByTarget(AllPathLengths_Perturbation, PathLengthTargets);
% Go through and sdmooth each target
for Tgt=1:8
    SmoothPLPerTargetCell{1,Tgt}=movmean(PathLengthPerTargetCell{1,Tgt},NumOfSamples);
end
 
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure; hold on; MillerFigure;
for Tgt=1:8
    location= subplotLocations(Tgt);
    %subplot(5,5,location); hold on
   plot(SmoothPLPerTargetCell{1,Tgt},'.-','Color',colors(Tgt,:),'MarkerSize',5)
    title('Ref Smooth')    
end


colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure; hold on
for Tgt=1:8
    location= subplotLocations(Tgt);
    %subplot(5,5,location); hold on
    plot(PathLengthPerTargetCell{1,Tgt},'.-','Color',colors(Tgt,:),'MarkerSize',5)
    title('Ref All')
    MillerFigure;
end
MillerFigure

