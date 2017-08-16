% Plot per target example

% Plot percent success separately for each target across days
colors = [ 0 .6 1; 1 .4 0];
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure
for Tgt=1:8
    location= subplotLocations(Tgt);
    subplot(5,5,location); hold on
    for Day=1:length(MetricStruct)
        plot(Day,PercentSuccess(Day,Tgt),'.','Color',colors(taskNum,:),'MarkerSize',12)
    end
    title(strcat(['Target ', num2str(Tgt)]))
    MillerFigure;
    ylim([0 100]); xlim([0 length(MetricStruct)+1])
    set(gca,'Xtick',1:length(MetricStruct))
    set(gca,'Ytick',0:20:100)
end
MillerFigure