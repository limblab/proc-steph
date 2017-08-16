function ranovatbl=RepeatedMeasuresAcrossSessions_JangoTargets1245(MetricCell)
% first run something like
% [ErrorAnglesPerTargetCell_rot, StrategyAnglesPerTargetCell_rot, PathLengthsPerTargetCell_rot, BinarySuccessPerTargetCell_rot]= AcrossDaysStatsAnalysis('Jango','rot')


%MetricCell=PathLengthsPerTargetCell_rot;

% Put first 5 trials for each target in a matrix
% NumOfTrials=5;
% AllData=[];Labels=[];
% for Day=1:length(MetricCell)
%     for Tgt=1:8
%         Data(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
%         Lili(Day,Tgt)=lillietest(Data(:,Tgt));  
%     end
%     currentstring = repmat({strcat('Day',num2str(Day))}, [NumOfTrials 1]);
%     Labels=cat(1,Labels,currentstring);
%     currentstring=[];
%     AllData=cat(1,AllData,Data);
% end

% Put first X trials per target into day 1 and day 2 and last day and
% second to last day
NumOfTrials=10;
AllData=[];Labels=[];
for Day=[1 2 length(MetricCell)-1 length(MetricCell)]
    for Tgt=1:8
        Data(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
        Lili(Day,Tgt)=lillietest(Data(:,Tgt));
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


% Make a table
t = table(Labels,AllData(:,1),AllData(:,2),AllData(:,4),...
    AllData(:,5),...
'VariableNames',{'Day','target1','target2','target4',...
'target5'});
Meas = dataset([1 2 3 4]','VarNames',{'Measurements'});  


% Fit a repeated measures model, where the measurements are the responses
% and the Day is the predictor variable. 
rm = fitrm(t,'target1-target5~Day','WithinDesign',Meas); 


% Perform repeated measures analysis of variance. 
ranovatbl = ranova(rm);







