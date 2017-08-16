% PlotPathEfficiencySingleDay


[~, TargetNumber, PathEfficiency] = CalculatePathEfficiency(binnedIsoHC);
PathEfficiencyPerTargetCell=SeparateOutByTarget(PathEfficiency, TargetNumber);

% Plot percent success separately for each target across days
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure
for Tgt=1:8
    location= subplotLocations(Tgt);
    subplot(5,5,location); hold on
    plot(PathEfficiencyPerTargetCell{1,Tgt},'Color',colors(Tgt,:))
    title(strcat(['Target ', num2str(Tgt)]))
    MillerFigure;
    ylim([0 1])
    set(gca,'Ytick',0:.2:1)
end
MillerFigure