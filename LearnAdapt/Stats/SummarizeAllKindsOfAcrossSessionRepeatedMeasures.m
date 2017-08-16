

[ErrorAnglesPerTargetCell_rot, StrategyAnglesPerTargetCell_rot, PathLengthsPerTargetCell_rot, BinarySuccessPerTargetCell_rot, PathEfficiencyPerTargetCell_rot]= AcrossDaysStatsAnalysis('Jango','rot');
[ErrorAnglesPerTargetCell_ref, StrategyAnglesPerTargetCell_ref, PathLengthsPerTargetCell_ref, BinarySuccessPerTargetCell_ref, PathEfficiencyPerTargetCell_ref]= AcrossDaysStatsAnalysis('Jango','ref');


[ErrorAnglesPerTargetCell_ref, StrategyAnglesPerTargetCell_ref, PathLengthsPerTargetCell_ref, BinarySuccessPerTargetCell_ref,PathEfficiencyPerTargetCell_ref]= AcrossDaysStatsAnalysis('Kevin','ref');
[ErrorAnglesPerTargetCell_rot, StrategyAnglesPerTargetCell_rot, PathLengthsPerTargetCell_rot, BinarySuccessPerTargetCell_rot,PathEfficiencyPerTargetCell_rot]= AcrossDaysStatsAnalysis('Kevin','rot');


ranovatbl=RepeatedMeasuresAcrossSessions(StrategyAnglesPerTargetCell_ref);
pStrat_Tall_ref=ranovatbl{2,5}

ranovatbl=RepeatedMeasuresAcrossSessions(ErrorAnglesPerTargetCell_ref);
pError_Tall_ref=ranovatbl{2,5}


% path efficience
ranovatbl=RepeatedMeasuresAcrossSessions(PathEfficiencyPerTargetCell_ref);
pEff_across_Tall_ref=ranovatbl{2,5}
ylim([0 .8]); xlim([0.5 2.5]);set(gca,'Ytick',0:.2:1);set(gca,'Yticklabel',0:.2:1)

ranovatbl=RepeatedMeasuresAcrossSessions_JangoTargets1245(PathEfficiencyPerTargetCell_ref)
pEff_across_JT1245_ref=ranovatbl{2,5}


%-----------------------------------ROTATED
ranovatbl=RepeatedMeasuresAcrossSessions(StrategyAnglesPerTargetCell_rot);
pStrat_across_Tall_rot=ranovatbl{2,5}

ranovatbl=RepeatedMeasuresAcrossSessions(ErrorAnglesPerTargetCell_rot);
pError_across_Tall_rot=ranovatbl{2,5}

% path efficience
ranovatbl=RepeatedMeasuresAcrossSessions(PathEfficiencyPerTargetCell_rot);
pEff_across_Tall_rot=ranovatbl{2,5}
ylim([0 .8]); xlim([0.5 2.5]);set(gca,'Ytick',0:.2:1);set(gca,'Yticklabel',0:.2:1)

