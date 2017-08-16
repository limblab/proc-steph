% May not use this script anymore but not sure. MetricPerTargetPerDay.m is
% good

% First run something like
% [ErrorAnglesPerTargetCell,StrategyAnglesPerTargetCell, PathLengthsPerTargetCell, BinarySuccessPerTargetCell]= AcrossDaysStatsAnalysis(monkeyname,tasktype)
% [ErrorAnglesPerTargetCell_rot, StrategyAnglesPerTargetCell_rot, PathLengthsPerTargetCell_rot, BinarySuccessPerTargetCell_rot]= AcrossDaysStatsAnalysis('Kevin','rot')

PlotSymbol='v';
%PlotSymbol='.';

%mean angle error per target per day
MetricStruct=PathLengthsPerTargetCell_rot;
%MetricStruct=ErrorAnglesPerTargetCell_rot;
for Day=1:length(MetricStruct)
    for Tgt=1:8
        MeanAnglePerTarget(Day,Tgt)=mean(PathLengthsPerTargetCell{Day,1}{1,Tgt});
        steAnglePerTarget(Day,Tgt)=(std(PathLengthsPerTargetCell{Day,1}{1,Tgt}))/sqrt(length((PathLengthsPerTargetCell{Day,1}{1,Tgt})));
    end
end

FirstDay=1; LastDay=length(MetricStruct);
NumOfTrials=20;Tgt=1;
for Tgt=1:8
Targetp(Tgt)=signrank(MetricStruct{FirstDay,1}{1,Tgt}(1:NumOfTrials),MetricStruct{LastDay,1}{1,Tgt}(1:NumOfTrials));
end
Targetp = Targetp/2;

% Plot percent success separately for each target across days
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure
for Tgt=1:8
    location= subplotLocations(Tgt);
    subplot(5,5,location); hold on
    for Day=1:length(MetricStruct)
        errorbar(Day,MeanAnglePerTarget(Day,Tgt),steAnglePerTarget(Day,Tgt),steAnglePerTarget(Day,Tgt),PlotSymbol,'Color',colors(Tgt,:),'MarkerSize',2)
    end
    title(strcat(['Target ', num2str(Tgt)]))
    MillerFigure;
    ylim([0 140]); xlim([0 length(MetricStruct)+1])
    if Targetp(Tgt)<0.05
        xlabel('Significant')
    end
    set(gca,'Xtick',1:length(MetricStruct))
    set(gca,'Ytick',0:20:140)
end
MillerFigure


% Only plot first and second day
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure; hold on
for Tgt=1:8
    % location= subplotLocations(Tgt);
    %subplot(5,5,location); hold on
    errorbar(1,MeanAnglePerTarget(FirstDay,Tgt),steAnglePerTarget(FirstDay,Tgt),steAnglePerTarget(FirstDay,Tgt),PlotSymbol,'Color',colors(Tgt,:),'MarkerSize',2)
    errorbar(2,MeanAnglePerTarget(LastDay,Tgt),steAnglePerTarget(LastDay,Tgt),steAnglePerTarget(LastDay,Tgt),PlotSymbol,'Color',colors(Tgt,:),'MarkerSize',2)
    plot([1 2],[MeanAnglePerTarget(1,Tgt) MeanAnglePerTarget(length(MetricStruct),Tgt)])
    ylim([0 140])
    set(gca,'Ytick',0:20:140)
end
MillerFigure










% Plot mean for each target for each day

% % Target1
% for Tgt=1:8
%     figure;hold on
%     for Day=1:8
%         errorbar(Day,MeanAnglePerTarget(Day,Tgt),steAnglePerTarget(Day,Tgt),steAnglePerTarget(Day,Tgt),'g.','MarkerSize',12)
%         MillerFigure;ylim([0 180]); xlim([0 9])
%     end
% end
