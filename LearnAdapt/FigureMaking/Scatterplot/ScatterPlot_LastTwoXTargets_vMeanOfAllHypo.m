function [meanHypoPercentSuccessAllDays]=ScatterPlot_LastTwoXTargets_vMeanOfAllHypo(monkeyname,taskType)
%
% [meanHypoPercentSuccessAllDays]=ScatterPlot_LastTwoXTargets_vMeanOfAllHypo('Jango','rot')
% title('Jango rot')
% [meanHypoPercentSuccessAllDays]=ScatterPlot_LastTwoXTargets_vMeanOfAllHypo('Jango','ref')
% title('Jango ref')
% [meanHypoPercentSuccessAllDays]=ScatterPlot_LastTwoXTargets_vMeanOfAllHypo('Kevin','rot')
% title('Kevin rot')
% [meanHypoPercentSuccessAllDays]=ScatterPlot_LastTwoXTargets_vMeanOfAllHypo('Kevin','ref')
% title('Kevin ref')






[~,~,~, BinarySuccess]= AcrossDaysStatsAnalysis(monkeyname,taskType);


MetricCell=BinarySuccess;
NumOfTrials=10;
AllData=[];Labels=[];
for Day=[1 2 length(MetricCell)-1 length(MetricCell)]
    for Tgt=1:8
        Data(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
    end
    if Day==1 || Day==2
        currentstring = repmat({'First2Days'}, [NumOfTrials 1]);
        Labels=cat(1,Labels,currentstring);
        currentstring=[];
        AllData=cat(1,AllData,Data);
    end
    if Day==length(MetricCell)-1 || Day==length(MetricCell)
        currentstring = repmat({'Last2Days'}, [NumOfTrials 1]);
        Labels=cat(1,Labels,currentstring);
        currentstring=[];
        AllData=cat(1,AllData,Data);
    end
end

FirstTwoDays=(AllData(1:length(AllData)/2,:));
LastTwoDays=(AllData((length(AllData)/2)+1:end,:));

for Tgt=1:8
    FirstTwoPoints=FirstTwoDays(:,Tgt);
    PercentSuccess_FirstTwoDays(Tgt)=(length(find(FirstTwoPoints==1)))/length(FirstTwoPoints);
    
    LastTwoPoints=LastTwoDays(:,Tgt);
    PercentSuccess_LastTwoDays(Tgt)=(length(find(LastTwoPoints==1)))/length(LastTwoPoints);
end
PercentSuccess_FirstTwoDays=PercentSuccess_FirstTwoDays*100;
PercentSuccess_LastTwoDays=PercentSuccess_LastTwoDays*100;



% Hypothetical success-----------------------------------------------

[~, IndividualTrialSuccess]=PlotHypotheticalSuccessWithPerturbation(monkeyname,taskType);
for a=1:length(IndividualTrialSuccess)
    IndividualTrialSuccessPerDay{a,1}=SeparateOutByTarget(IndividualTrialSuccess{a,1}(:,1),IndividualTrialSuccess{a,1}(:,2));
end


for Day=1:length(IndividualTrialSuccessPerDay)
    for Tgt=1:8
    HypoPercentSuccessSingleDay= IndividualTrialSuccessPerDay{Day,1}{1,Tgt};
    HypoPercentSuccessAllDays(Day,Tgt)=(length(find(HypoPercentSuccessSingleDay==1)))/length(HypoPercentSuccessSingleDay);
    end
end
HypoPercentSuccessAllDays=HypoPercentSuccessAllDays*100;

meanHypoPercentSuccessAllDays=mean(HypoPercentSuccessAllDays);
steHypoPercentSuccessAllDays=std(HypoPercentSuccessAllDays)/(sqrt(length(HypoPercentSuccessAllDays(:,1))));
%errorbar(x,y,err,'horizontal')

close all

figure; hold on
x=[0:10:100];y=[0:10:100];
plot(x,y,'-','Color',[0.8 0.8 0.8])
errorbar(meanHypoPercentSuccessAllDays,PercentSuccess_LastTwoDays,steHypoPercentSuccessAllDays,'horizontal','.','MarkerSize',10,'Color',[.6 0.2 1])
MillerFigure;
ylim([-1 100]);xlim([-1 100])
set(gca,'Ytick',0:20:100);set(gca,'Xtick',0:20:100)


end


