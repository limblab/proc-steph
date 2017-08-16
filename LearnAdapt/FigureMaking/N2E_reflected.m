
% FCU FCR ECU ECRb
% need to swap 2 and 4

N2E_reflected=N2E;
N2E_FCR=N2E.H(:,2);
N2E_ECR=N2E.H(:,4);

ReflectedH=N2E.H;
ReflectedH(:,2)=N2E_ECR;
ReflectedH(:,4)=N2E_FCR;
N2E_reflected.H=ReflectedH;


[~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_normal);
[PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedIsoHC,PertDecoder_NormBrain_Pos,0.5);
plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)



[~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedIsoHC, N2E_reflected, E2F_normal);
[PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedIsoHC,PertDecoder_NormBrain_Pos,0.5);
plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)


[~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedIsoHC, N2E_messed, E2F_normal);
[PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedIsoHC,PertDecoder_NormBrain_Pos,0.5);
plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)



N2E_messed=N2E;
N2E_FCU=N2E.H(:,1);
N2E_ECU=N2E.H(:,3);

MessedH=N2E.H;
MessedH(:,1)=N2E_ECU;
MessedH(:,3)=N2E_FCU;
N2E_messed.H=MessedH;