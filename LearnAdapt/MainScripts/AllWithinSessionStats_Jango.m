% All Within Session Stats Jango


[J_Rot_PL_AllTargetsP, J_Rot_PL_PerTargetP, J_Rot_TE_AllTargetsP, J_Rot_TE_PerTargetP,J_Rot_NS_AllTargetsP, J_Rot_NS_PerTargetP]=LearnAdaptWrapper_WithinSessionMetrics('Jango','rot',0);
[J_Rot_PL_PerT_StatsSummary J_Rot_PL_PerT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Rot_PL_PerTargetP);
[J_Rot_TE_PerT_StatsSummary J_Rot_TE_PerT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Rot_TE_PerTargetP);
[J_Rot_NS_PerT_StatsSummary J_Rot_NS_PerT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Rot_NS_PerTargetP);

[J_Rot_PL_AllT_StatsSummary J_Rot_PL_AllT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Rot_PL_AllTargetsP);
[J_Rot_TE_AllT_StatsSummary J_Rot_TE_AllT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Rot_TE_AllTargetsP);
[J_Rot_NS_AllT_StatsSummary J_Rot_NS_AllT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Rot_NS_AllTargetsP);


[J_Ref_PL_AllTargetsP, J_Ref_PL_PerTargetP, J_Ref_TE_AllTargetsP, J_Ref_TE_PerTargetP,J_Ref_NS_AllTargetsP, J_Ref_NS_PerTargetP]=LearnAdaptWrapper_WithinSessionMetrics('Jango','ref',0);
[J_Ref_PL_PerT_StatsSummary J_Ref_PL_PerT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Ref_PL_PerTargetP);
[J_Ref_TE_PerT_StatsSummary J_Ref_TE_PerT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Ref_TE_PerTargetP);
[J_Ref_NS_PerT_StatsSummary J_Ref_NS_PerT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Ref_NS_PerTargetP);

[J_Ref_PL_AllT_StatsSummary J_Ref_PL_AllT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Ref_PL_AllTargetsP);
[J_Ref_TE_AllT_StatsSummary J_Ref_TE_AllT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Ref_TE_AllTargetsP);
[J_Ref_NS_AllT_StatsSummary J_Ref_NS_AllT_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummary(J_Ref_NS_AllTargetsP);