%MetricPerTargetPerDay

% First run something like
%[ErrorAnglesPerTargetCell_ref, StrategyAnglesPerTargetCell_ref, PathLengthsPerTargetCell_ref, BinarySuccessPerTargetCell_ref]= AcrossDaysStatsAnalysis('Kevin','ref')

%PlotSymbol='v';
PlotSymbol='.';

%mean angle error per target per day
MetricStruct=PathLengthsPerTargetCell_rot;
%MetricStruct=ErrorAnglesPerTargetCell_rot;
%MetricStruct=StrategyAnglesPerTargetCell_rot;

%MetricStruct=PathLengthsPerTargetCell_ref;
%MetricStruct=ErrorAnglesPerTargetCell_ref;
%MetricStruct=StrategyAnglesPerTargetCell_ref;

for Day=1:length(MetricStruct)
    for Tgt=1:8
        MeanPerTarget(Day,Tgt)=mean(MetricStruct{Day,1}{1,Tgt});
        stePerTarget(Day,Tgt)=(std(MetricStruct{Day,1}{1,Tgt}))/sqrt(length((MetricStruct{Day,1}{1,Tgt})));
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
        errorbar(Day,MeanPerTarget(Day,Tgt),stePerTarget(Day,Tgt),stePerTarget(Day,Tgt),PlotSymbol,'Color',colors(Tgt,:),'MarkerSize',8)
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
PlotSymbol='.';
for Tgt=1:8
    % location= subplotLocations(Tgt);
    %subplot(5,5,location); hold on
    errorbar(1,MeanPerTarget(FirstDay,Tgt),stePerTarget(FirstDay,Tgt),stePerTarget(FirstDay,Tgt),PlotSymbol,'Color',colors(Tgt,:),'MarkerSize',15,'LineWidth',1.2)
    errorbar(2,MeanPerTarget(LastDay,Tgt),stePerTarget(LastDay,Tgt),stePerTarget(LastDay,Tgt),PlotSymbol,'Color',colors(Tgt,:),'MarkerSize',15,'LineWidth',1.2)
    plot([1 2],[MeanPerTarget(FirstDay,Tgt) MeanPerTarget(LastDay,Tgt)],'Color',colors(Tgt,:),'LineWidth',1.3)
    ylim([0 100])
    xlim([0.8 2.2])
    set(gca,'Xtick',1:2)
    set(gca,'XtickLabel',{'First Day', 'Last Day'})
    set(gca,'Ytick',0:20:100)
end
MillerFigure








