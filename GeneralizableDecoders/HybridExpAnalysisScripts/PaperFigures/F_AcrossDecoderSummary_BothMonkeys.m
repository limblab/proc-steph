%F_AcrossDecoderSummary_BothMonkeys

% Run this after running the main script for jango

%plot vafs for jango
subplot(2,2,1)
F_Subfunction_computeAcrossMeansAndPlot
set(gca,'XTick',[1:3])
set(gca,'XTickLabel',{'Iso','Movement','Spring'})

%Hybrid lin - Jango
[meanHonI_hybrid_lin_J, steHonI_hybrid_lin_J] = FindMeanAndSTE([MegaVAFstruct_J.HonI_mVAF]);
[meanHonW_hybrid_lin_J, steHonW_hybrid_lin_J] = FindMeanAndSTE([MegaVAFstruct_J.HonW_mVAF]);
[meanHonS_hybrid_lin_J, steHonS_hybrid_lin_J] = FindMeanAndSTE([MegaVAFstruct_J.HonS_mVAF]);

LW=2;MS=10;
errorbar(1.15,meanHonI_hybrid_lin_J, steHonI_hybrid_lin_J,steHonI_hybrid_lin_J,'.c','LineWidth',LW,'MarkerSize',MS);
errorbar(2.15,meanHonW_hybrid_lin_J, steHonW_hybrid_lin_J,steHonW_hybrid_lin_J,'.c','LineWidth',LW,'MarkerSize',MS);
errorbar(3.15,meanHonS_hybrid_lin_J, steHonS_hybrid_lin_J,steHonS_hybrid_lin_J,'.c','LineWidth',LW,'MarkerSize',MS);



% plot %gen for jango
subplot(2,2,3)
F_AcrossPercentGeneralizability
set(gca,'XTick',[1:3])
set(gca,'XTickLabel',{'Iso','Movement','Spring'})

% Make 2 more plots after running the main script for kevin
%plot vafs for kevin
subplot(2,2,2)
F_Subfunction_computeAcrossMeansAndPlot
set(gca,'XTick',[1:3])
set(gca,'XTickLabel',{'Iso','Movement','Spring'})

%Hybrid lin - Jango
[meanHonI_hybrid_lin_K, steHonI_hybrid_lin_K] = FindMeanAndSTE([MegaVAFstruct_K.HonI_mVAF]);
[meanHonW_hybrid_lin_K, steHonW_hybrid_lin_K] = FindMeanAndSTE([MegaVAFstruct_K.HonW_mVAF]);
[meanHonS_hybrid_lin_K, steHonS_hybrid_lin_K] = FindMeanAndSTE([MegaVAFstruct_K.HonS_mVAF]);

LW=2;MS=10;
errorbar(1.15,meanHonI_hybrid_lin_K, steHonI_hybrid_lin_K,steHonI_hybrid_lin_K,'.c','LineWidth',LW,'MarkerSize',MS);
errorbar(2.15,meanHonW_hybrid_lin_K, steHonW_hybrid_lin_K,steHonW_hybrid_lin_K,'.c','LineWidth',LW,'MarkerSize',MS);
errorbar(3.15,meanHonS_hybrid_lin_K, steHonS_hybrid_lin_K,steHonS_hybrid_lin_K,'.c','LineWidth',LW,'MarkerSize',MS);



% plot %gen for kevin
subplot(2,2,4)
F_AcrossPercentGeneralizability
set(gca,'XTick',[1:3])
set(gca,'XTickLabel',{'Iso','Movement','Spring'})

