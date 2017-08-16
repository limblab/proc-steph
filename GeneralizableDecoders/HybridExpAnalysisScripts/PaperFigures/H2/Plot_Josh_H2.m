%Plot_Josh_H2

[meanLin_H2IWonI_mVAF steLin_H2IWonI_mVAF] = FindMeanAndSTE(MegaVAFstruct.Lin_H2IWonI_mVAF);
[meanHyb_H2IWonI_mVAF steHyb_H2IWonI_mVAF] = FindMeanAndSTE(MegaVAFstruct.Hyb_H2IWonI_mVAF);
[meanLin_H2SWonI_mVAF steLin_H2SWonI_mVAF] = FindMeanAndSTE(MegaVAFstruct.Lin_H2SWonI_mVAF);
[meanHyb_H2SWonI_mVAF steHyb_H2SWonI_mVAF] = FindMeanAndSTE(MegaVAFstruct.Hyb_H2SWonI_mVAF);

[meanLin_H2IWonW_mVAF steLin_H2IWonW_mVAF] = FindMeanAndSTE(MegaVAFstruct.Lin_H2IWonW_mVAF);
[meanHyb_H2IWonW_mVAF steHyb_H2IWonW_mVAF] = FindMeanAndSTE(MegaVAFstruct.Hyb_H2IWonW_mVAF);
[meanLin_H2SWonW_mVAF steLin_H2SWonW_mVAF] = FindMeanAndSTE(MegaVAFstruct.Lin_H2SWonW_mVAF);
[meanHyb_H2SWonW_mVAF steHyb_H2SWonW_mVAF] = FindMeanAndSTE(MegaVAFstruct.Hyb_H2SWonW_mVAF);

[meanLin_H2IWonS_mVAF steLin_H2IWonS_mVAF] = FindMeanAndSTE(MegaVAFstruct.Lin_H2IWonS_mVAF);
[meanHyb_H2IWonS_mVAF steHyb_H2IWonS_mVAF] = FindMeanAndSTE(MegaVAFstruct.Hyb_H2IWonS_mVAF);
[meanLin_H2SWonS_mVAF steLin_H2SWonS_mVAF] = FindMeanAndSTE(MegaVAFstruct.Lin_H2SWonS_mVAF);
[meanHyb_H2SWonS_mVAF steHyb_H2SWonS_mVAF] = FindMeanAndSTE(MegaVAFstruct.Hyb_H2SWonS_mVAF);

figure; hold on;ylim([0 1])
LW=2; MS=20;
wiggle=[1 .5 .5];
%errorbar(1.2,meanLin_H2IWonI_mVAF,steLin_H2IWonI_mVAF,steLin_H2IWonI_mVAF,'.','Color',wiggle,'LineWidth',LW,'MarkerSize',MS);
%errorbar(1.2,meanLin_H2SWonI_mVAF,steLin_H2SWonI_mVAF,steLin_H2SWonI_mVAF,'.','Color',[0.6 0 0.6],'LineWidth',LW,'MarkerSize',MS);
%errorbar(1,meanHyb_H2IWonI_mVAF,steHyb_H2IWonI_mVAF,steHyb_H2IWonI_mVAF,'.','Color',wiggle,'LineWidth',LW,'MarkerSize',MS);
errorbar(1,meanHyb_H2SWonI_mVAF,steHyb_H2SWonI_mVAF,steHyb_H2SWonI_mVAF,'.','Color',[0.6 0 0.6],'LineWidth',LW,'MarkerSize',MS);

% errorbar(2.2,meanLin_H2IWonW_mVAF,steLin_H2IWonW_mVAF,steLin_H2IWonW_mVAF,'.','Color',wiggle,'LineWidth',LW,'MarkerSize',MS);
% errorbar(2.2,meanLin_H2SWonW_mVAF,steLin_H2SWonW_mVAF,steLin_H2SWonW_mVAF,'.','Color',[0.6 0 0.6],'LineWidth',LW,'MarkerSize',MS);
% errorbar(2,meanHyb_H2IWonW_mVAF,steHyb_H2IWonW_mVAF,steHyb_H2IWonW_mVAF,'.','Color',wiggle,LineWidth',LW,'MarkerSize',MS);
% errorbar(2,meanHyb_H2SWonW_mVAF,steHyb_H2SWonW_mVAF,steHyb_H2SWonW_mVAF,'.','Color',[0.6 0 0.6],'LineWidth',LW,'MarkerSize',MS);

%errorbar(3.2,meanLin_H2IWonS_mVAF,steLin_H2IWonS_mVAF,steLin_H2IWonS_mVAF,'.','Color',wiggle,'LineWidth',LW,'MarkerSize',MS);
%errorbar(3.2,meanLin_H2SWonS_mVAF,steLin_H2SWonS_mVAF,steLin_H2SWonS_mVAF,'.','Color',[0.6 0 0.6],'LineWidth',LW,'MarkerSize',MS);
errorbar(3,meanHyb_H2IWonS_mVAF,steHyb_H2IWonS_mVAF,steHyb_H2IWonS_mVAF,'.','Color',wiggle,'LineWidth',LW,'MarkerSize',MS);
%errorbar(3,meanHyb_H2SWonS_mVAF,steHyb_H2SWonS_mVAF,steHyb_H2SWonS_mVAF,'.','Color',[0.6 0 0.6],'LineWidth',LW,'MarkerSize',MS);

set(gca,'XTick',[1 3]);set(gca,'XTickLabel',{'Iso','Spring'})
MillerFigure


