% Scatterplot Between Target Difficulty and Percent Success


[HypotheticalPercentSuccessPerTarget]=PlotHypotheticalSuccessWithPerturbation('Jango','rot');
[ActualPercentSuccessPerTarget]=PlotBinarySuccess_PerTarget_PerDay('Jango', 'rot');
HypotheticalPercentSuccessPerTarget=HypotheticalPercentSuccessPerTarget*100;
close all

[HypotheticalPercentSuccessPerTarget]=PlotHypotheticalSuccessWithPerturbation('Jango','ref');
[ActualPercentSuccessPerTarget]=PlotBinarySuccess_PerTarget_PerDay('Jango', 'ref');
HypotheticalPercentSuccessPerTarget=HypotheticalPercentSuccessPerTarget*100;
close all

[HypotheticalPercentSuccessPerTarget]=PlotHypotheticalSuccessWithPerturbation('Kevin','rot');
[ActualPercentSuccessPerTarget]=PlotBinarySuccess_PerTarget_PerDay('Kevin', 'rot');
HypotheticalPercentSuccessPerTarget=HypotheticalPercentSuccessPerTarget*100;
close all

[HypotheticalPercentSuccessPerTarget]=PlotHypotheticalSuccessWithPerturbation('Kevin','ref');
[ActualPercentSuccessPerTarget]=PlotBinarySuccess_PerTarget_PerDay('Kevin', 'ref');
HypotheticalPercentSuccessPerTarget=HypotheticalPercentSuccessPerTarget*100;
close all

% Plot percent success separately for each target across days
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure
MarkerSizes=[6 8 10 12 14 16 18 20];
for Tgt=1:8
    location= subplotLocations(Tgt);
    %subplot(5,5,location);
    hold on
    plot(HypotheticalPercentSuccessPerTarget(:,Tgt),ActualPercentSuccessPerTarget(:,Tgt),'o','MarkerSize',MarkerSizes(Tgt),'Color',colors(Tgt,:))
    MillerFigure;
    ylim([0 100]);xlim([0 100])
    set(gca,'Ytick',0:20:100);set(gca,'Xtick',0:20:100)
end
MillerFigure
axis square
x=0:10:100;y=0:10:100;
plot(x,y,'-','Color',[.8 .8 .8])


