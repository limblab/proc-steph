function [pvals]=AcrossDay_BinarySuccessStats(BinarySuccessPerTargetCell)
% Run these first
%[ErrorAngles_rot_J, StrategyAngles_rot_J, PathLengths_rot_J, BinarySuccess_rot_J, PathEfficiency_rot_J]= AcrossDaysStatsAnalysis('Jango','rot');
%[pvals_rot_J]=AcrossDay_BinarySuccessStats(BinarySuccess_rot_J)

%[ErrorAngles_ref_J, StrategyAngles_ref_J, PathLengths_ref_J, BinarySuccess_ref_J, PathEfficiency_ref_J]= AcrossDaysStatsAnalysis('Jango','ref');
%[pvals_ref_J]=AcrossDay_BinarySuccessStats(BinarySuccess_ref_J)

%[ErrorAngles_rot_K, StrategyAngles_rot_K, PathLengths_rot_K, BinarySuccess_rot_K,PathEfficiency_rot_K]= AcrossDaysStatsAnalysis('Kevin','rot');
%[pvals_rot_K]=AcrossDay_BinarySuccessStats(BinarySuccess_rot_K)

%[ErrorAngles_ref_K, StrategyAngles_ref_K, PathLengths_ref_K, BinarySuccess_ref_K,PathEfficiency_ref_K]= AcrossDaysStatsAnalysis('Kevin','ref');
%[pvals_ref_K]=AcrossDay_BinarySuccessStats(BinarySuccess_ref_K)




% Put first X trials per target into day 1 and day 2 and last day and
% second to last day
MetricCell=BinarySuccessPerTargetCell;
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

% You now have AllData: this variable includes binary success for the first
% two days and for the last two days
FirstTwoDays=(AllData(1:length(AllData)/2,:));
LastTwoDays=(AllData((length(AllData)/2)+1:end,:));


% Separate Chi-squared test for each target
NumOfSamples=NumOfTrials*2;
for Tgt=1:8
    Points1=FirstTwoDays(:,Tgt);
    SuccessPoints1=(length(find(Points1==1)))/length(Points1);
    
    Points2=LastTwoDays(:,Tgt);
    SuccessPoints2=(length(find(Points2==1)))/length(Points2);
    
    AllSuccessPoints =[SuccessPoints1 SuccessPoints2];
    pvals(Tgt,1) = getCHIpValue(AllSuccessPoints,NumOfSamples);
end






