%SummarizeAllKindsOfWithinSessionRepeatedMeasures

[ErrorAnglesPerTargetCell_rot, StrategyAnglesPerTargetCell_rot, PathLengthsPerTargetCell_rot, BinarySuccessPerTargetCell_rot, PathEfficiencyPerTargetCell_rot]= AcrossDaysStatsAnalysis('Jango','rot');
[ErrorAnglesPerTargetCell_ref, StrategyAnglesPerTargetCell_ref, PathLengthsPerTargetCell_ref, BinarySuccessPerTargetCell_ref, PathEfficiencyPerTargetCell_ref]= AcrossDaysStatsAnalysis('Jango','ref');


[ErrorAnglesPerTargetCell_ref, StrategyAnglesPerTargetCell_ref, PathLengthsPerTargetCell_ref, BinarySuccessPerTargetCell_ref,PathEfficiencyPerTargetCell_ref]= AcrossDaysStatsAnalysis('Kevin','ref');
[ErrorAnglesPerTargetCell_rot, StrategyAnglesPerTargetCell_rot, PathLengthsPerTargetCell_rot, BinarySuccessPerTargetCell_rot,PathEfficiencyPerTargetCell_rot]= AcrossDaysStatsAnalysis('Kevin','rot');



for Day=1:length(PathLengthsPerTargetCell_ref)
%     pval_PL_ref_T15(Day)=RepeatedMeasuresWithinASession_Targets1and5(PathLengthsPerTargetCell_ref,Day);
%     pval_PL_ref_TAll(Day)=RepeatedMeasuresWithinASession(PathLengthsPerTargetCell_ref,Day);
%     pval_PL_ref_T234678(Day)=RepeatedMeasuresWithinASession_Targets234678(PathLengthsPerTargetCell_ref,Day);
%     pval_PL_ref_T1245(Day)=RepeatedMeasuresWithinASession_Targets1245(PathLengthsPerTargetCell_ref,Day);

pval_PE_ref_T15(Day)=RepeatedMeasuresWithinASession_Targets1and5(PathEfficiencyPerTargetCell_ref,Day);
pval_PE_ref_TAll(Day)=RepeatedMeasuresWithinASession(PathEfficiencyPerTargetCell_ref,Day);
pval_PE_ref_T234678(Day)=RepeatedMeasuresWithinASession_Targets234678(PathEfficiencyPerTargetCell_ref,Day);
pval_PE_ref_T1245(Day)=RepeatedMeasuresWithinASession_Targets1245(PathEfficiencyPerTargetCell_ref,Day);
pval_PE_ref_KT1248(Day)=RepeatedMeasuresWithinASession_KevinTargets1248(PathEfficiencyPerTargetCell_ref,Day);

% pval_NS_ref_T15(Day)=RepeatedMeasuresWithinASession_Targets1and5(StrategyAnglesPerTargetCell_ref,Day);
% pval_NS_ref_TAll(Day)=RepeatedMeasuresWithinASession(StrategyAnglesPerTargetCell_ref,Day);
% pval_NS_ref_T234678(Day)=RepeatedMeasuresWithinASession_Targets234678(StrategyAnglesPerTargetCell_ref,Day);
% pval_NS_ref_T1245(Day)=RepeatedMeasuresWithinASession_Targets1245(StrategyAnglesPerTargetCell_ref,Day);
% 
pval_TE_ref_T15(Day)=RepeatedMeasuresWithinASession_Targets1and5(ErrorAnglesPerTargetCell_ref,Day);
pval_TE_ref_TAll(Day)=RepeatedMeasuresWithinASession(ErrorAnglesPerTargetCell_ref,Day);
pval_TE_ref_T234678(Day)=RepeatedMeasuresWithinASession_Targets234678(ErrorAnglesPerTargetCell_ref,Day);
pval_TE_ref_T1245(Day)=RepeatedMeasuresWithinASession_Targets1245(ErrorAnglesPerTargetCell_ref,Day);
end

% Path efficiency
pval_PE_ref_TAll
[pval_PE_ref_TAll_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_PE_ref_TAll)




pval_PL_ref_T15
[pval_PL_ref_T15_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_PL_ref_T15)

pval_NS_ref_T15
[pval_PL_ref_T15_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_PL_ref_T15)

pval_TE_ref_T15
[pval_TE_ref_T15_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_TE_ref_T15)


pval_PL_ref_T234678
[pval_PL_ref_T234678_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_PL_ref_T234678)


pval_NS_ref_T234678
pval_TE_ref_T234678

pval_PL_ref_TAll
[pval_PL_ref_TAll_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_PL_ref_TAll)

pval_NS_ref_TAll
[pval_NS_ref_TAll_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_NS_ref_TAll)

pval_TE_ref_TAll
[pval_TE_ref_TAll_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_TE_ref_TAll)


pval_PL_ref_T1245
pval_NS_ref_T1245
pval_TE_ref_T1245


% Rotated--------------------------------

for Day=1:length(PathLengthsPerTargetCell_rot)
% pval_PL_rot_T15(Day)=RepeatedMeasuresWithinASession_Targets1and5(PathLengthsPerTargetCell_rot,Day);
% pval_PL_rot_TAll(Day)=RepeatedMeasuresWithinASession(PathLengthsPerTargetCell_rot,Day);
% pval_PL_rot_T234678(Day)=RepeatedMeasuresWithinASession_Targets234678(PathLengthsPerTargetCell_rot,Day);
% pval_PL_rot_T1245(Day)=RepeatedMeasuresWithinASession_Targets234678(PathLengthsPerTargetCell_rot,Day);

%pval_PE_rot_T15(Day)=RepeatedMeasuresWithinASession_Targets1and5(PathEfficiencyPerTargetCell_rot,Day);
pval_PE_rot_TAll(Day)=RepeatedMeasuresWithinASession(PathEfficiencyPerTargetCell_rot,Day);
%pval_PE_rot_T234678(Day)=RepeatedMeasuresWithinASession_Targets234678(PathEfficiencyPerTargetCell_rot,Day);
%pval_PE_rot_T1245(Day)=RepeatedMeasuresWithinASession_Targets1245(PathEfficiencyPerTargetCell_rot,Day);
%pval_PE_rot_KT1248(Day)=RepeatedMeasuresWithinASession_KevinTargets1248(PathEfficiencyPerTargetCell_rot,Day);

% pval_NS_rot_T15(Day)=RepeatedMeasuresWithinASession_Targets1and5(StrategyAnglesPerTargetCell_rot,Day);
% pval_NS_rot_TAll(Day)=RepeatedMeasuresWithinASession(StrategyAnglesPerTargetCell_rot,Day);
% pval_NS_rot_T234678(Day)=RepeatedMeasuresWithinASession_Targets234678(StrategyAnglesPerTargetCell_rot,Day);
% pval_NS_rot_T1245(Day)=RepeatedMeasuresWithinASession_Targets234678(StrategyAnglesPerTargetCell_rot,Day);
% 
% pval_TE_rot_T15(Day)=RepeatedMeasuresWithinASession_Targets1and5(ErrorAnglesPerTargetCell_rot,Day);
 pval_TE_rot_TAll(Day)=RepeatedMeasuresWithinASession(ErrorAnglesPerTargetCell_rot,Day);
% pval_TE_rot_T234678(Day)=RepeatedMeasuresWithinASession_Targets234678(ErrorAnglesPerTargetCell_rot,Day);
% pval_TE_rot_T1245(Day)=RepeatedMeasuresWithinASession_Targets1245(ErrorAnglesPerTargetCell_rot,Day);
end


% Path efficiency
pval_PE_rot_TAll
[pval_PE_rot_TAll_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_PE_rot_TAll)





pval_PL_rot_TAll
[pval_PL_rot_TAll_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_PL_rot_TAll)

pval_NS_rot_TAll
[pval_NS_rot_TAll_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_NS_rot_TAll)

pval_TE_rot_TAll
[pval_TE_rot_TAll_summary, tally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(pval_TE_rot_TAll)


pval_PL_rot_T1245
pval_NS_rot_T1245
pval_TE_rot_T1245


