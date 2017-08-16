%F_Subfunct_Jion_computeAcrossMeansAndPlot


[meanHonI, steHonI] = FindMeanAndSTE([MegaVAFstruct_J.HonI_mVAF]);
[meanWonI, steWonI] = FindMeanAndSTE([MegaVAFstruct_J.WonI_mVAF]);
[meanSonI, steSonI] = FindMeanAndSTE([MegaVAFstruct_J.SonI_mVAF]);
[meanIonI, steIonI] = FindMeanAndSTE([MegaVAFstruct_J.IonI_mVAF]);

[meanWonW, steWonW] = FindMeanAndSTE([MegaVAFstruct_J.WonW_mVAF]);
[meanSonW, steSonW] = FindMeanAndSTE([MegaVAFstruct_J.SonW_mVAF]);
[meanIonW, steIonW] = FindMeanAndSTE([MegaVAFstruct_J.IonW_mVAF]);

[meanSonS, steSonS] = FindMeanAndSTE([MegaVAFstruct_J.SonS_mVAF]);
[meanWonS, steWonS] = FindMeanAndSTE([MegaVAFstruct_J.WonS_mVAF]);
[meanIonS, steIonS] = FindMeanAndSTE([MegaVAFstruct_J.IonS_mVAF]);


%Plot!
hold on; ylim([0 1]); xlim([0.5 3.5]); LW=2;MS=10;
h2 = errorbar(1,meanIonI, steIonI,steIonI,'.m','LineWidth',LW,'MarkerSize',MS);
h3 = errorbar(1.05,meanWonI, steWonI,steWonI,'.g','LineWidth',LW,'MarkerSize',MS);
h4 = errorbar(1.1,meanSonI, steSonI,steSonI,'.b','LineWidth',LW,'MarkerSize',MS);

legend('Isometric','Movement','Spring')
legend boxoff

h10 = errorbar(2,meanIonW, steIonW,steIonW,'.m','LineWidth',LW,'MarkerSize',MS);
h11 = errorbar(2.05,meanWonW, steWonW,steWonW,'.g','LineWidth',LW,'MarkerSize',MS);
h12 = errorbar(2.1,meanSonW, steSonW,steSonW,'.b','LineWidth',LW,'MarkerSize',MS);

h14 = errorbar(3,meanIonS, steIonS,steIonS,'.m','LineWidth',LW,'MarkerSize',MS);
h15 = errorbar(3.05,meanWonS, steWonS,steWonS,'.g','LineWidth',LW,'MarkerSize',MS);
h16 = errorbar(3.1,meanSonS, steSonS,steSonS,'.b','LineWidth',LW,'MarkerSize',MS);

%labels
ylabel('VAF')