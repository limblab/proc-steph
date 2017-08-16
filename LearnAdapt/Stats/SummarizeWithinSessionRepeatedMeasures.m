%SummarizeWithinSessionRepeatedMeasures
% run this after running AcrossDayStatsAnalysis

for a=1:length(PathLengthsPerTargetCell_ref)
Pathpval(a)=RepeatedMeasuresWithinASession(PathLengthsPerTargetCell_ref,a);
end
Pathpval

for a=1:length(ErrorAnglesPerTargetCell_ref)
Errorpval(a)=RepeatedMeasuresWithinASession(ErrorAnglesPerTargetCell_ref,a);
end
Errorpval

for a=1:length(StrategyAnglesPerTargetCell_ref)
Strategypval(a)=RepeatedMeasuresWithinASession(StrategyAnglesPerTargetCell_ref,a);
end
Strategypval