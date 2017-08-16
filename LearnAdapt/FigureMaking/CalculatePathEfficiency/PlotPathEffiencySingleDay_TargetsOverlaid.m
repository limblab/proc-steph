% PlotPathEffiencySingleDay_TargetsOverlaid



load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_061315_binnedDec_rot.mat')
 [~,PathEfficiencyTargets,AllPathEfficiency_Perturbation] = CalculatePathEfficiency(binnedRotatedBC);
 NumOfSamples=5;
PathEfficiencyPerTargetCell=SeparateOutByTarget(AllPathEfficiency_Perturbation, PathEfficiencyTargets);
% Go through and smooth each target
for Tgt=1:8
    SmoothPLPerTargetCell{1,Tgt}=movmean(PathEfficiencyPerTargetCell{1,Tgt},NumOfSamples);
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
    plot(PathEfficiencyPerTargetCell{1,Tgt},'.-','Color',colors(Tgt,:),'MarkerSize',5)
    title('Rot All')
    MillerFigure;
end
MillerFigure

%%

clear
% load last reflected kevin session
%load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_061415_binnedDec_ref.mat')
 [~,PathEfficiencyTargets,AllPathEfficiency_Perturbation] = CalculatePathEfficiency(binnedReflectedBC);
 NumOfSamples=5;
PathEfficiencyPerTargetCell=SeparateOutByTarget(AllPathEfficiency_Perturbation, PathEfficiencyTargets);
% Go through and sdmooth each target
for Tgt=1:8
    SmoothPLPerTargetCell{1,Tgt}=movmean(PathEfficiencyPerTargetCell{1,Tgt},NumOfSamples);
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
    plot(PathEfficiencyPerTargetCell{1,Tgt},'.-','Color',colors(Tgt,:),'MarkerSize',5)
    title('Ref All')
    MillerFigure;
end
MillerFigure

