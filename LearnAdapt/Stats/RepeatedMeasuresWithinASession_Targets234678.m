function pval=RepeatedMeasuresWithinASession_Targets234678(MetricCell,Day)
% first run something like
%[ErrorAnglesPerTargetCell_rot, StrategyAnglesPerTargetCell_rot, PathLengthsPerTargetCell_rot, BinarySuccessPerTargetCell_rot]= AcrossDaysStatsAnalysis('Jango','rot')
% ex: MetricCell=PathLengthsPerTargetCell_rot

%Put first 10 trials for each target in a matrix
NumOfTrials=10;
AllData=[];Labels=[];EarlyData=[];LateData=[];
for Tgt=1:8
    EarlyData(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
    LateData(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(end-NumOfTrials+1:end);
    % Lili(Day,Tgt)=lillietest(Data(:,Tgt));
end
Earlystring = repmat({'EarlyData'}, [NumOfTrials 1]);
Latestring = repmat({'LateData'}, [NumOfTrials 1]);
Labels=cat(1,Earlystring,Latestring);
currentstring=[];
AllData=cat(1,EarlyData,LateData);

% Make a table
t = table(Labels,AllData(:,2),AllData(:,3),AllData(:,4),...
    AllData(:,6),AllData(:,7),AllData(:,8),...
'VariableNames',{'Epoch','target2','target3','target4',...
'target6','target7','target8'});
Meas = dataset([1 2 3 4 5 6]','VarNames',{'Measurements'});  


% Fit a repeated measures model, where the measurements are the responses
% and the Epoch is the predictor variable. 
rm = fitrm(t,'target2-target8~Epoch','WithinDesign',Meas); 


% Perform repeated measures analysis of variance. 
ranovatbl = ranova(rm);

pval=ranovatbl.pValue(2);

