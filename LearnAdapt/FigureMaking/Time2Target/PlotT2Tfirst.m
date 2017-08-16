% PlotT2Tfirst

% just a quick piece of code to look at means per target across days

MetricCell=T2T_FirstPerTargetCell_rot;
for Day=1:length(MetricCell)
    for Tgt=1:8
        meanT2TfirstPerTarget(Day,Tgt)=mean(MetricCell{Day,1}{1,Tgt});
    end
end
    
    figure; hold on
    colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
    for Tgt=1:8
    plot(meanT2TfirstPerTarget(:,Tgt),'Color',colors(Tgt,:))
    end