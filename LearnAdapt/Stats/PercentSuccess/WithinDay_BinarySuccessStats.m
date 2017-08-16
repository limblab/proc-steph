function pvals=WithinDay_BinarySuccessStats(BinarySuccessPerTargetCell,Day)
% Run these first
%[ErrorAngles_rot_J, StrategyAngles_rot_J, PathLengths_rot_J, BinarySuccess_rot_J, PathEfficiency_rot_J]= AcrossDaysStatsAnalysis('Jango','rot');
%[pvals_rot_J]=WithinDay_BinarySuccessStats(BinarySuccess_rot_J)

%[ErrorAngles_ref_J, StrategyAngles_ref_J, PathLengths_ref_J, BinarySuccess_ref_J, PathEfficiency_ref_J]= AcrossDaysStatsAnalysis('Jango','ref');
%[pvals_ref_J]=WithinDay_BinarySuccessStats(BinarySuccess_ref_J)

%[ErrorAngles_rot_K, StrategyAngles_rot_K, PathLengths_rot_K, BinarySuccess_rot_K,PathEfficiency_rot_K]= AcrossDaysStatsAnalysis('Kevin','rot');
%[pvals_rot_K]=WithinDay_BinarySuccessStats(BinarySuccess_rot_K)

%[ErrorAngles_ref_K, StrategyAngles_ref_K, PathLengths_ref_K, BinarySuccess_ref_K,PathEfficiency_ref_K]= AcrossDaysStatsAnalysis('Kevin','ref');
%[pvals_ref_K]=WithinDay_BinarySuccessStats(BinarySuccess_ref_K)

MetricCell=BinarySuccessPerTargetCell;

%Put first 10 trials for each target in a matrix
NumOfTrials=10;
AllData=[];Labels=[];EarlyData=[];LateData=[];
for Tgt=1:8
    EarlyData(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
    LateData(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(end-NumOfTrials+1:end);
end
Earlystring = repmat({'EarlyData'}, [NumOfTrials 1]);
Latestring = repmat({'LateData'}, [NumOfTrials 1]);
Labels=cat(1,Earlystring,Latestring);
currentstring=[];
AllData=cat(1,EarlyData,LateData);

% Separate Chi-squared test for each target
NumOfSamples=NumOfTrials;
for Tgt=1:8
    Points1=EarlyData(:,Tgt);
    SuccessPoints1=(length(find(Points1==1)))/length(Points1);
    
    Points2=LateData(:,Tgt);
    SuccessPoints2=(length(find(Points2==1)))/length(Points2);
    
    AllSuccessPoints =[SuccessPoints1 SuccessPoints2];
    pvals(Tgt,1) = getCHIpValue(AllSuccessPoints,NumOfSamples);
end




