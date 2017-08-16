function KO_PlotEMGsPerTarget(FRandTheta1_mid, FRandTheta2_mid, FRandTheta3_mid, FRandTheta4_mid, FRandTheta1_prone, FRandTheta2_prone, FRandTheta3_prone, FRandTheta4_prone)

[meanEMG1_mid] = KO_GetEMGPerTarget(FRandTheta1_mid);
[meanEMG2_mid] = KO_GetEMGPerTarget(FRandTheta2_mid);
[meanEMG3_mid] = KO_GetEMGPerTarget(FRandTheta3_mid);
[meanEMG4_mid] = KO_GetEMGPerTarget(FRandTheta4_mid);

[meanEMG1_prone] = KO_GetEMGPerTarget(FRandTheta1_prone);
[meanEMG2_prone] = KO_GetEMGPerTarget(FRandTheta2_prone);
[meanEMG3_prone] = KO_GetEMGPerTarget(FRandTheta3_prone);
[meanEMG4_prone] = KO_GetEMGPerTarget(FRandTheta4_prone);

MarkerSize=10;
figure; hold on;
plot(ones(8,1), meanEMG1_mid,'b.','MarkerSize',MarkerSize);
plot(2*ones(8,1),meanEMG2_mid,'b.','MarkerSize',MarkerSize);
plot(3*ones(8,1), meanEMG3_mid,'b.','MarkerSize',MarkerSize);
plot(4*ones(8,1),meanEMG4_mid,'b.','MarkerSize',MarkerSize);
plot(ones(8,1), meanEMG1_prone,'g.','MarkerSize',MarkerSize);
plot(2*ones(8,1),meanEMG2_prone,'g.','MarkerSize',MarkerSize);
plot(3*ones(8,1), meanEMG3_prone,'g.','MarkerSize',MarkerSize);
plot(4*ones(8,1),meanEMG4_prone,'g.','MarkerSize',MarkerSize);

end
