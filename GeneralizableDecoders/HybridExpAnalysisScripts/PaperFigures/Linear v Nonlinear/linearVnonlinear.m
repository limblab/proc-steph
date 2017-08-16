%LinearVersusNonlinearSummaryAcrossDays_BothMonkeys_WithJoshNumbers
% Load VAFs and SSE ratios for both monkeys

% Nonlinear analysis ------------------------------------------------------
%VAFs
%Within rnn - Jango
[meanIonI_within_rnn_J, steIonI_within_rnn_J] = FindMeanAndSTE(within_rnn_Iso_vafs(1:9));
[meanWonW_within_rnn_J, steWonW_within_rnn_J] = FindMeanAndSTE(within_rnn_Wm_vafs(1:9));
[meanSonS_within_rnn_J, steSonS_within_rnn_J] = FindMeanAndSTE(within_rnn_Spr_vafs(1:9));
%Within rnn - Kevin
[meanIonI_within_rnn_K, steIonI_within_rnn_K] = FindMeanAndSTE(within_rnn_Iso_vafs(10:14));
[meanWonW_within_rnn_K, steWonW_within_rnn_K] = FindMeanAndSTE(within_rnn_Wm_vafs(10:14));
[meanSonS_within_rnn_K, steSonS_within_rnn_K] = FindMeanAndSTE(within_rnn_Spr_vafs(10:14));
%Hybrid rnn - Jango
[meanHonI_hybrid_rnn_J, steHonI_hybrid_rnn_J] = FindMeanAndSTE(hybrid_rnn_Iso_vafs(1:9));
[meanHonW_hybrid_rnn_J, steHonW_hybrid_rnn_J] = FindMeanAndSTE(hybrid_rnn_Wm_vafs(1:9));
[meanHonS_hybrid_rnn_J, steHonS_hybrid_rnn_J] = FindMeanAndSTE(hybrid_rnn_Spr_vafs(1:9));
%Hybrid rnn - Kevin
[meanHonI_hybrid_rnn_K, steHonI_hybrid_rnn_K] = FindMeanAndSTE(hybrid_rnn_Iso_vafs(10:14));
[meanHonW_hybrid_rnn_K, steHonW_hybrid_rnn_K] = FindMeanAndSTE(hybrid_rnn_Wm_vafs(10:14));
[meanHonS_hybrid_rnn_K, steHonS_hybrid_rnn_K] = FindMeanAndSTE(hybrid_rnn_Spr_vafs(10:14));

%%
% Linear analysis ---------------------------------------------------------
%VAFs
%Within lin - Jango
[meanIonI_within_lin_J, steIonI_within_lin_J] = FindMeanAndSTE([MegaVAFstruct_J.IonI_mVAF]); 
[meanWonW_within_lin_J, steWonW_within_lin_J] = FindMeanAndSTE([MegaVAFstruct_J.WonW_mVAF]);
[meanSonS_within_lin_J, steSonS_within_lin_J] = FindMeanAndSTE([MegaVAFstruct_J.SonS_mVAF]);
%Hybrid lin - Jango
[meanHonI_hybrid_lin_J, steHonI_hybrid_lin_J] = FindMeanAndSTE([MegaVAFstruct_J.HonI_mVAF]);
[meanHonW_hybrid_lin_J, steHonW_hybrid_lin_J] = FindMeanAndSTE([MegaVAFstruct_J.HonW_mVAF]);
[meanHonS_hybrid_lin_J, steHonS_hybrid_lin_J] = FindMeanAndSTE([MegaVAFstruct_J.HonS_mVAF]);

%Within lin - Kevin
[meanIonI_within_lin_K, steIonI_within_lin_K] = FindMeanAndSTE([MegaVAFstruct_K.IonI_mVAF]);
[meanWonW_within_lin_K, steWonW_within_lin_K] = FindMeanAndSTE([MegaVAFstruct_K.WonW_mVAF]);
[meanSonS_within_lin_K, steSonS_within_lin_K] = FindMeanAndSTE([MegaVAFstruct_K.SonS_mVAF]);
%Hybrid lin - Kevin
[meanHonI_hybrid_lin_K, steHonI_hybrid_lin_K] = FindMeanAndSTE([MegaVAFstruct_K.HonI_mVAF]);
[meanHonW_hybrid_lin_K, steHonW_hybrid_lin_K] = FindMeanAndSTE([MegaVAFstruct_K.HonW_mVAF]);
[meanHonS_hybrid_lin_K, steHonS_hybrid_lin_K] = FindMeanAndSTE([MegaVAFstruct_K.HonS_mVAF]);




%%
figure;
% Make Jango VAF plot
subplot(2,2,1); hold on
title('Monkey J');ylabel('VAF')
MillerFigure
ylim([0 1]); xlim([0.5 3.5]); LW=1.5;MS=10;
errorbar(1,meanIonI_within_rnn_J, steIonI_within_rnn_J,steIonI_within_rnn_J,'.m','LineWidth',LW,'MarkerSize',MS);
errorbar(1.05,meanHonI_hybrid_rnn_J, steHonI_hybrid_rnn_J,steHonI_hybrid_rnn_J,'.k','LineWidth',LW,'MarkerSize',MS);
errorbar(2,meanWonW_within_rnn_J, steWonW_within_rnn_J,steWonW_within_rnn_J,'.g','LineWidth',LW,'MarkerSize',3);
errorbar(2.05,meanHonW_hybrid_rnn_J, steHonW_hybrid_rnn_J,steHonW_hybrid_rnn_J,'.k','LineWidth',LW,'MarkerSize',MS);
errorbar(3,meanSonS_within_rnn_J, steSonS_within_rnn_J,steSonS_within_rnn_J,'.b','LineWidth',LW,'MarkerSize',3);
errorbar(3.05,meanHonS_hybrid_rnn_J, steHonS_hybrid_rnn_J,steHonS_hybrid_rnn_J,'.k','LineWidth',LW,'MarkerSize',MS);
set(gca,'YTick', 0:.2:1);set(gca,'XTick',1:3);set(gca,'XTickLabel',{'Iso','Movement','Spring'})
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 10,'Fontname','Arial')
set(findall(gcf,'type','text'),'fontSize',10,'fontWeight','bold','Fontname','Arial')
% Plot the linear predictions
LW=1;MS=10;
errorbar(1.2,meanIonI_within_lin_J, steIonI_within_lin_J,steIonI_within_lin_J,'.r','LineWidth',LW,'MarkerSize',MS);
errorbar(1.25,meanHonI_hybrid_lin_J, steHonI_hybrid_lin_J,steHonI_hybrid_lin_J,'.c','LineWidth',LW,'MarkerSize',MS);
errorbar(2.2,meanWonW_within_lin_J, steWonW_within_lin_J,steWonW_within_lin_J,'.','Color',[0 .6 0],'LineWidth',LW,'MarkerSize',3);
errorbar(2.25,meanHonW_hybrid_lin_J, steHonW_hybrid_lin_J,steHonW_hybrid_lin_J,'.c','LineWidth',LW,'MarkerSize',MS);
errorbar(3.2,meanSonS_within_lin_J, steSonS_within_lin_J,steSonS_within_lin_J,'.','Color',[0 0 .8], 'LineWidth',LW,'MarkerSize',3);
errorbar(3.25,meanHonS_hybrid_lin_J, steHonS_hybrid_lin_J,steHonS_hybrid_lin_J,'.c','LineWidth',LW,'MarkerSize',MS);


% Make Kevin VAF plot
subplot(2,2,2); hold on
ylim([0 1]); xlim([.5 3.5])
title('Monkey K'); MillerFigure
errorbar(1,meanIonI_within_rnn_K, steIonI_within_rnn_K,steIonI_within_rnn_K,'.m','LineWidth',LW,'MarkerSize',3);
errorbar(1.05,meanHonI_hybrid_rnn_K, steHonI_hybrid_rnn_K,steHonI_hybrid_rnn_K,'.k','LineWidth',LW,'MarkerSize',MS);
errorbar(2,meanWonW_within_rnn_K, steWonW_within_rnn_K,steWonW_within_rnn_K,'.g','LineWidth',LW,'MarkerSize',3);
errorbar(2.05,meanHonW_hybrid_rnn_K, steHonW_hybrid_rnn_K,steHonW_hybrid_rnn_K,'.k','LineWidth',LW,'MarkerSize',MS);
errorbar(3,meanSonS_within_rnn_K, steSonS_within_rnn_K,steSonS_within_rnn_K,'.b','LineWidth',LW,'MarkerSize',3);
errorbar(3.05,meanHonS_hybrid_rnn_K, steHonS_hybrid_rnn_K,steHonS_hybrid_rnn_K,'.k','LineWidth',LW,'MarkerSize',MS);
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 10,'Fontname','Arial')
set(findall(gcf,'type','text'),'fontSize',10,'fontWeight','bold','Fontname','Arial')
set(gca,'YTick', 0:.2:1); set(gca,'XTick',1:3);set(gca,'XTickLabel',{'Iso','Movement','Spring'})

% Plot the linear hybrid and within predictions
LW=1;MS=10;
errorbar(1.2,meanIonI_within_lin_K, steIonI_within_lin_K,steIonI_within_lin_K,'.r','LineWidth',LW,'MarkerSize',MS);
errorbar(1.25,meanHonI_hybrid_lin_K, steHonI_hybrid_lin_K,steHonI_hybrid_lin_K,'.c','LineWidth',LW,'MarkerSize',MS);
errorbar(2.2,meanWonW_within_lin_K, steWonW_within_lin_K,steWonW_within_lin_K,'.','Color',[0 .6 0],'LineWidth',LW,'MarkerSize',3);
errorbar(2.25,meanHonW_hybrid_lin_K, steHonW_hybrid_lin_K,steHonW_hybrid_lin_K,'.c','LineWidth',LW,'MarkerSize',MS);
errorbar(3.2,meanSonS_within_lin_K, steSonS_within_lin_K,steSonS_within_lin_K,'.','Color',[0 0 .8], 'LineWidth',LW,'MarkerSize',3);
errorbar(3.25,meanHonS_hybrid_lin_K, steHonS_hybrid_lin_K,steHonS_hybrid_lin_K,'.c','LineWidth',LW,'MarkerSize',MS);



%% Compute SSEs
% Jango linear SSE ratio
[meanLINHonI_sse_J, steLINHonI_sse_J] = FindMeanAndSTE([SSEratio_lin_J.HonI]);
[meanLINHonW_sse_J, steLINHonW_sse_J] = FindMeanAndSTE([SSEratio_lin_J.HonW]);
[meanLINHonS_sse_J, steLINHonS_sse_J] = FindMeanAndSTE([SSEratio_lin_J.HonS]);

% Jango RNN SSE ratio
[meanRNNHonI_sse_J, steRNNHonI_sse_J] = FindMeanAndSTE([SSEratio_rnn_J.HonI]);
[meanRNNHonW_sse_J, steRNNHonW_sse_J] = FindMeanAndSTE([SSEratio_rnn_J.HonW]);
[meanRNNHonS_sse_J, steRNNHonS_sse_J] = FindMeanAndSTE([SSEratio_rnn_J.HonS]);

% Kevin linear SSE ratio
[meanLINHonI_sse_K, steLINHonI_sse_K] = FindMeanAndSTE([SSEratio_lin_K.HonI]);
[meanLINHonW_sse_K, steLINHonW_sse_K] = FindMeanAndSTE([SSEratio_lin_K.HonW]);
[meanLINHonS_sse_K, steLINHonS_sse_K] = FindMeanAndSTE([SSEratio_lin_K.HonS]);

% Kevin RNN SSE ratio
[meanRNNHonI_sse_K, steRNNHonI_sse_K] = FindMeanAndSTE([SSEratio_rnn_K.HonI]);
[meanRNNHonW_sse_K, steRNNHonW_sse_K] = FindMeanAndSTE([SSEratio_rnn_K.HonW]);
[meanRNNHonS_sse_K, steRNNHonS_sse_K] = FindMeanAndSTE([SSEratio_rnn_K.HonS]);

%%

% Jango plot 2: ratio of SSEs
subplot(2,2,3); hold on
ylim([0 1]); xlim([0.3 3.5]); ylabel('SSE ratio');MillerFigure
errorbar(1,meanRNNHonI_sse_J, steRNNHonI_sse_J,steRNNHonI_sse_J,'.m','LineWidth',LW,'MarkerSize',10);
errorbar(2,meanRNNHonW_sse_J, steRNNHonW_sse_J,steRNNHonW_sse_J,'.g','LineWidth',LW,'MarkerSize',10);
errorbar(3,meanRNNHonS_sse_J, steRNNHonS_sse_J,steRNNHonS_sse_J,'.b','LineWidth',LW,'MarkerSize',10);
errorbar(1.2,meanLINHonI_sse_J, steLINHonI_sse_J,steLINHonI_sse_J,'.m','LineWidth',LW,'MarkerSize',10);
errorbar(2.2,meanLINHonW_sse_J, steLINHonW_sse_J,steLINHonW_sse_J,'.g','LineWidth',LW,'MarkerSize',10);
errorbar(3.2,meanLINHonS_sse_J, steLINHonS_sse_J,steLINHonS_sse_J,'.b','LineWidth',LW,'MarkerSize',10);
set(gca,'YTick', [0:.2:1]);
set(gca,'XTick',1:3);set(gca,'XTickLabel',{'Iso','Movement','Spring'})
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 15,'Fontname','Arial')
set(findall(gcf,'type','text'),'fontSize',20,'fontWeight','bold','Fontname','Arial')

% Kevin plot 2: ratio of SSEs
subplot(2,2,4); hold on
ylim([0 1]); xlim([0.3 3.5]); ylabel('SSE ratio');MillerFigure
errorbar(1,meanRNNHonI_sse_K, steRNNHonI_sse_K,steRNNHonI_sse_K,'.m','LineWidth',LW,'MarkerSize',10);
errorbar(2,meanRNNHonW_sse_K, steRNNHonW_sse_K,steRNNHonW_sse_K,'.g','LineWidth',LW,'MarkerSize',10);
errorbar(3,meanRNNHonS_sse_K, steRNNHonS_sse_K,steRNNHonS_sse_K,'.b','LineWidth',LW,'MarkerSize',10);
errorbar(1.2,meanLINHonI_sse_K, steLINHonI_sse_K,steLINHonI_sse_K,'.m','LineWidth',LW,'MarkerSize',10);
errorbar(2.2,meanLINHonW_sse_K, steLINHonW_sse_K,steLINHonW_sse_K,'.g','LineWidth',LW,'MarkerSize',10);
errorbar(3.2,meanLINHonS_sse_K, steLINHonS_sse_K,steLINHonS_sse_K,'.b','LineWidth',LW,'MarkerSize',10);
set(gca,'YTick', [0:.2:1]);
set(gca,'XTick',1:3);set(gca,'XTickLabel',{'Iso','Movement','Spring'})
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 15,'Fontname','Arial')
set(findall(gcf,'type','text'),'fontSize',20,'fontWeight','bold','Fontname','Arial')





