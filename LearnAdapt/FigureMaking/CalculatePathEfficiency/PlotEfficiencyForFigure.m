


[~,PathEfficiencyTargets,AllPathEfficiency_Perturbation] = CalculatePathEfficiency(binnedPerturbation);
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
end
ylim([0 25]);set(gca,'YTick',0:5:25);set(gca,'YTickLabel',0:5:25);xlim([0 35])