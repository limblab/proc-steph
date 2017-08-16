%WithinDay_BinarySuccessStatsWrapper

[~,~,~, BinarySuccess_rot_J]= AcrossDaysStatsAnalysis('Jango','rot');
close all
for Day=1:length(BinarySuccess_rot_J)
  pvals(:,Day) =  WithinDay_BinarySuccessStats(BinarySuccess_rot_J,Day);
end
[statsVarSummary, statsVarTally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pvals)



[~,~,~, BinarySuccess_ref_J]= AcrossDaysStatsAnalysis('Jango','ref');
close all
for Day=1:length(BinarySuccess_ref_J)
  pvals(:,Day) =  WithinDay_BinarySuccessStats(BinarySuccess_ref_J,Day);
end
[statsVarSummary, statsVarTally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pvals)




[~,~,~, BinarySuccess_rot_K]= AcrossDaysStatsAnalysis('Kevin','rot');
close all
for Day=1:length(BinarySuccess_rot_K)
  pvals(:,Day) =  WithinDay_BinarySuccessStats(BinarySuccess_rot_K,Day);
end
[statsVarSummary, statsVarTally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pvals)



[~,~,~, BinarySuccess_ref_K]= AcrossDaysStatsAnalysis('Kevin','ref');
close all
for Day=1:length(BinarySuccess_ref_K)
  pvals(:,Day) =  WithinDay_BinarySuccessStats(BinarySuccess_ref_K,Day);
end
[statsVarSummary, statsVarTally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pvals)