%F_AcrossDayDecoderPerformance_NoFolds
% Run this after running the main script

[meanHonI, steHonI] = FindMeanAndSTE([MegaVAFstruct.HonI_mVAF]);
[meanHonW, steHonW] = FindMeanAndSTE([MegaVAFstruct.HonW_mVAF]);
[meanHonS, steHonS] = FindMeanAndSTE([MegaVAFstruct.HonS_mVAF]);

[meanWonI, steWonI] = FindMeanAndSTE([MegaVAFstruct.WonI_mVAF]);
[meanSonI, steSonI] = FindMeanAndSTE([MegaVAFstruct.SonI_mVAF]);
[meanIonI, steIonI] = FindMeanAndSTE([MegaVAFstruct.IonI_mVAF]);

[meanWonW, steWonW] = FindMeanAndSTE([MegaVAFstruct.WonW_mVAF]);
[meanSonW, steSonW] = FindMeanAndSTE([MegaVAFstruct.SonW_mVAF]);
[meanIonW, steIonW] = FindMeanAndSTE([MegaVAFstruct.IonW_mVAF]);

[meanWonS, steWonS] = FindMeanAndSTE([MegaVAFstruct.WonS_mVAF]);
[meanSonS, steSonS] = FindMeanAndSTE([MegaVAFstruct.SonS_mVAF]);
[meanIonS, steIonS] = FindMeanAndSTE([MegaVAFstruct.IonS_mVAF]);


figure;
subplot(2,2,1); hold on
ylim([0 1]); xlim([0.5 3.5]); LW=2;MS=20;
h1 = errorbar(1,meanHonI, steHonI,steHonI,'.c','LineWidth',LW,'MarkerSize',MS);
h2 = errorbar(1,meanIonI, steIonI,steIonI,'.m','LineWidth',LW,'MarkerSize',MS);
h3 = errorbar(1,meanWonI, steWonI,steWonI,'.g','LineWidth',LW,'MarkerSize',MS);
h4 = errorbar(1,meanSonI, steSonI,steSonI,'.b','LineWidth',LW,'MarkerSize',MS);

legend('Hybrid','Isometric','Movement','Spring')
legend boxoff

h9 = errorbar(2,meanHonW, steHonW,steHonW,'.c','LineWidth',LW,'MarkerSize',MS);
h10 = errorbar(2,meanIonW, steIonW,steIonW,'.m','LineWidth',LW,'MarkerSize',MS);
h11 = errorbar(2,meanWonW, steWonW,steWonW,'.g','LineWidth',LW,'MarkerSize',MS);
h12 = errorbar(2,meanSonW, steSonW,steSonW,'.b','LineWidth',LW,'MarkerSize',MS);

h13 = errorbar(3,meanHonS, steHonS,steHonS,'.c','LineWidth',LW,'MarkerSize',MS);
h14 = errorbar(3,meanIonS, steIonS,steIonS,'.m','LineWidth',LW,'MarkerSize',MS);
h15 = errorbar(3,meanWonS, steWonS,steWonS,'.g','LineWidth',LW,'MarkerSize',MS);
h16 = errorbar(3,meanSonS, steSonS,steSonS,'.b','LineWidth',LW,'MarkerSize',MS);

set(gca,'XTick',1:3);set(gca,'XTickLabel',{'Iso','Movement','Spring'})
MillerFigure

%% Compute SSEs

[meanSonI_ste, steSonI_ste] = FindMeanAndSTE([SSEratio.SonI]);
[meanWonI_ste, steWonI_ste] = FindMeanAndSTE([SSEratio.WonI]);
[meanHonI_ste, steHonI_ste] = FindMeanAndSTE([SSEratio.HonI]);

[meanSonW_ste, steSonW_ste] = FindMeanAndSTE([SSEratio.SonW]);
[meanIonW_ste, steIonW_ste] = FindMeanAndSTE([SSEratio.IonW]);
[meanHonW_ste, steHonW_ste] = FindMeanAndSTE([SSEratio.HonW]);

[meanWonS_ste, steWonS_ste] = FindMeanAndSTE([SSEratio.WonS]);
[meanIonS_ste, steIonS_ste] = FindMeanAndSTE([SSEratio.IonS]);
[meanHonS_ste, steHonS_ste] = FindMeanAndSTE([SSEratio.HonS]);

% Plot
subplot(2,2,3); hold on
ylim([0 1]); xlim([0.5 3.5]); LW=2;MS=10;
set(gca,'XTick',1:3);set(gca,'XTickLabel',{'Iso','Movement','Spring'})
MillerFigure

errorbar(1,meanSonI_ste, steSonI_ste,steSonI_ste,'.b','LineWidth',LW,'MarkerSize',MS);
errorbar(1,meanWonI_ste, steWonI_ste,steWonI_ste,'.g','LineWidth',LW,'MarkerSize',MS);
errorbar(1,meanHonI_ste, steHonI_ste,steHonI_ste,'.c','LineWidth',LW,'MarkerSize',MS);

errorbar(2,meanSonW_ste, steSonW_ste,steSonW_ste,'.b','LineWidth',LW,'MarkerSize',MS);
errorbar(2,meanIonW_ste, steIonW_ste,steIonW_ste,'.m','LineWidth',LW,'MarkerSize',MS);
errorbar(2,meanHonW_ste, steHonW_ste,steHonW_ste,'.c','LineWidth',LW,'MarkerSize',MS);

errorbar(3,meanWonS_ste, steWonS_ste,steWonS_ste,'.g','LineWidth',LW,'MarkerSize',MS);
errorbar(3,meanIonS_ste, steIonS_ste,steIonS_ste,'.m','LineWidth',LW,'MarkerSize',MS);
errorbar(3,meanHonS_ste, steHonS_ste,steHonS_ste,'.c','LineWidth',LW,'MarkerSize',MS);


%% 

% With H2


[meanH2onI, steH2onI] = FindMeanAndSTE([MegaVAFstruct.H2onI_mVAF]);
[meanH2onW, steH2onW] = FindMeanAndSTE([MegaVAFstruct.H2onW_mVAF]);
[meanH2onS, steH2onS] = FindMeanAndSTE([MegaVAFstruct.H2onS_mVAF]);

errorbar(1,meanH2onI, steH2onI,steH2onI,'.','Color',[0.6 0 .6],'LineWidth',LW,'MarkerSize',MS);
errorbar(2,meanH2onW, steH2onW,steH2onW,'.','Color',[0.6 0 .6],'LineWidth',LW,'MarkerSize',MS);
errorbar(3,meanH2onS, steH2onS,steH2onS,'.','Color',[0.6 0 .6],'LineWidth',LW,'MarkerSize',MS);

LW=2;MS=20;
errorbar(1,meanH2onI, steH2onI,steH2onI,'.k','LineWidth',LW,'MarkerSize',MS);
errorbar(2,meanH2onW, steH2onW,steH2onW,'.k','LineWidth',LW,'MarkerSize',MS);
errorbar(3,meanH2onS, steH2onS,steH2onS,'.k','LineWidth',LW,'MarkerSize',MS);


% Iso-Spring Hybrid
errorbar(1,meanH2onI, steH2onI,steH2onI,'.','Color',[1 .5 .5],'LineWidth',LW,'MarkerSize',MS);
errorbar(2,meanH2onW, steH2onW,steH2onW,'.','Color',[1 .5 .5],'LineWidth',LW,'MarkerSize',MS);
errorbar(3,meanH2onS, steH2onS,steH2onS,'.','Color',[1 .5 .5],'LineWidth',LW,'MarkerSize',MS);




