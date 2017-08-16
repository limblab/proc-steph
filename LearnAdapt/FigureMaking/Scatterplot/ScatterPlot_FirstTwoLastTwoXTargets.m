function ScatterPlot_FirstTwoLastTwoXTargets(monkeyname,taskType)

% Run these first
%[ErrorAngles_rot_J, StrategyAngles_rot_J, PathLengths_rot_J, BinarySuccess_rot_J, PathEfficiency_rot_J]= AcrossDaysStatsAnalysis('Jango','rot');


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


MetricCell=IndividualTrialSuccessPerDay;
NumOfTrials=10;
AllHypoData=[];Labels=[];
for Day=[1 2 length(MetricCell)-1 length(MetricCell)]
    for Tgt=1:8
        HypoData(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
    end
    if Day==1 || Day==2
        currentstring = repmat({'First2Days'}, [NumOfTrials 1]);
        Labels=cat(1,Labels,currentstring);
        currentstring=[];
        AllHypoData=cat(1,AllHypoData,HypoData);
    end
    if Day==length(MetricCell)-1 || Day==length(MetricCell)
        currentstring = repmat({'Last2Days'}, [NumOfTrials 1]);
        Labels=cat(1,Labels,currentstring);
        currentstring=[];
        AllHypoData=cat(1,AllHypoData,HypoData);
    end
end

FirstTwoHypoDays=(AllHypoData(1:length(AllHypoData)/2,:));
LastTwoHypoDays=(AllHypoData((length(AllHypoData)/2)+1:end,:));

for Tgt=1:8
    FirstTwoHypoPoints=FirstTwoHypoDays(:,Tgt);
    PercentSuccess_FirstTwoHypoDays(Tgt)=(length(find(FirstTwoHypoPoints==1)))/length(FirstTwoHypoPoints);
    
    LastTwoHypoPoints=LastTwoHypoDays(:,Tgt);
    PercentSuccess_LastTwoHypoDays(Tgt)=(length(find(LastTwoHypoPoints==1)))/length(LastTwoHypoPoints);
end
PercentSuccess_FirstTwoHypoDays=PercentSuccess_FirstTwoHypoDays*100;
PercentSuccess_LastTwoHypoDays=PercentSuccess_LastTwoHypoDays*100;
    
close all

figure; hold on
plot(PercentSuccess_FirstTwoHypoDays,PercentSuccess_FirstTwoDays,'.','MarkerSize',20,'Color',[0 0.8 1.0])
plot(PercentSuccess_LastTwoHypoDays,PercentSuccess_LastTwoDays,'.','MarkerSize',20,'Color',[.6 0.2 1])
MillerFigure;
ylim([0 100]);xlim([0 100])
set(gca,'Ytick',0:20:100);set(gca,'Xtick',0:20:100)


end


