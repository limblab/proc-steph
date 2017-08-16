
function [PercentSuccess]=PlotBinarySuccess_PerTarget_PerDay(monkeyname, taskType)

if strcmp(monkeyname,'Kevin')
    if strcmp(taskType,'ref')
        [~,~,~, BinarySuccessPerTargetCell_ref]= AcrossDaysStatsAnalysis('Kevin','ref');
    end
    if strcmp(taskType,'rot')
        [~,~,~, BinarySuccessPerTargetCell_rot]= AcrossDaysStatsAnalysis('Kevin','rot')   ; 
    end
else if strcmp(monkeyname,'Jango')
        if strcmp(taskType,'ref')
            [~,~,~, BinarySuccessPerTargetCell_ref]= AcrossDaysStatsAnalysis('Jango','ref');
        end
        if strcmp(taskType,'rot')
            [~,~,~, BinarySuccessPerTargetCell_rot]= AcrossDaysStatsAnalysis('Jango','rot') ;
        end
    end
end


if strcmp(taskType,'rot')
    MetricStruct=BinarySuccessPerTargetCell_rot;taskNum=1;
end
if strcmp(taskType,'ref')
    MetricStruct=BinarySuccessPerTargetCell_ref;taskNum=2;
end


for Day=1:length(MetricStruct)
    for Tgt=1:8
        PercentSuccess(Day,Tgt)=length(find(MetricStruct{Day,1}{1,Tgt}==1))/length(MetricStruct{Day,1}{1,Tgt});
    end
end
PercentSuccess=PercentSuccess.*100;

% FirstDay=1; LastDay=length(MetricStruct);
% NumOfTrials=20;Tgt=1;
% for Tgt=1:8
% Targetp(Tgt)=signrank(MetricStruct{FirstDay,1}{1,Tgt}(1:NumOfTrials),MetricStruct{LastDay,1}{1,Tgt}(1:NumOfTrials));
% end
% Targetp = Targetp/2;

% Plot percent success separately for each target across days
colors = [ 0 .6 1; 1 .4 0];
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




