%Old_PercentGeneralizabilityCode
% This is back from when we were computing a ratio of VAFs

% Percent Generalizability-------------------------------------------------
% for jango----------------------------------------------------------------
RNNonI_PG_rnn_J = (hybrid_rnn_Iso_vafs(1:9)./within_rnn_Iso_vafs(1:9))*100;
meanRNNonI_PG_rnn_J=mean(RNNonI_PG_rnn_J);
steRNNonI_PG_rnn_J=std(RNNonI_PG_rnn_J)/sqrt(length(RNNonI_PG_rnn_J));
% Rnn on WM
RNNonW_PG_rnn_J = (hybrid_rnn_Wm_vafs(1:9)./within_rnn_Wm_vafs(1:9))*100;
meanRNNonW_PG_rnn_J=mean(RNNonW_PG_rnn_J);
steRNNonW_PG_rnn_J=std(RNNonW_PG_rnn_J)/sqrt(length(RNNonW_PG_rnn_J));
% Rnn on Spr
RNNonS_PG_rnn_J = (hybrid_rnn_Spr_vafs(1:9)./within_rnn_Spr_vafs(1:9))*100;
meanRNNonS_PG_rnn_J=mean(RNNonS_PG_rnn_J);
steRNNonS_PG_rnn_J=std(RNNonS_PG_rnn_J)/sqrt(length(RNNonS_PG_rnn_J));
% for kevin----------------------------------------------------------------
RNNonI_PG_rnn_K = (hybrid_rnn_Iso_vafs(10:14)./within_rnn_Iso_vafs(10:14))*100;
meanRNNonI_PG_rnn_K=mean(RNNonI_PG_rnn_K);
steRNNonI_PG_rnn_K=std(RNNonI_PG_rnn_K)/sqrt(length(RNNonI_PG_rnn_K));
% Rnn on WM
RNNonW_PG_rnn_K = (hybrid_rnn_Wm_vafs(10:14)./within_rnn_Wm_vafs(10:14))*100;
meanRNNonW_PG_rnn_K=mean(RNNonW_PG_rnn_K);
steRNNonW_PG_rnn_K=std(RNNonW_PG_rnn_K)/sqrt(length(RNNonW_PG_rnn_K));
% Rnn on Spr
RNNonS_PG_rnn_K = (hybrid_rnn_Spr_vafs(10:14)./within_rnn_Spr_vafs(10:14))*100;
meanRNNonS_PG_rnn_K=mean(RNNonS_PG_rnn_K);
steRNNonS_PG_rnn_K=std(RNNonS_PG_rnn_K)/sqrt(length(RNNonS_PG_rnn_K));

% Percent Generalizability-------------------------------------------------
% for jango----------------------------------------------------------------
% lin on Iso
linonI_PG_lin_J = (meanHonI_hybrid_lin_J./meanIonI_within_lin_J)*100;
meanlinonI_PG_lin_J=mean(linonI_PG_lin_J);
stelinonI_PG_lin_J=std(linonI_PG_lin_J)/sqrt(length(linonI_PG_lin_J));
% lin on WM
linonW_PG_lin_J = (meanHonW_hybrid_lin_J./meanWonW_within_lin_J)*100;
meanlinonW_PG_lin_J=mean(linonW_PG_lin_J);
stelinonW_PG_lin_J=std(linonW_PG_lin_J)/sqrt(length(linonW_PG_lin_J));
% lin on Spr
linonS_PG_lin_J = (meanHonS_hybrid_lin_J./meanSonS_within_lin_J)*100;
meanlinonS_PG_lin_J=mean(linonS_PG_lin_J);
stelinonS_PG_lin_J=std(linonS_PG_lin_J)/sqrt(length(linonS_PG_lin_J));
% for kevin----------------------------------------------------------------
linonI_PG_lin_K = (meanHonI_hybrid_lin_K./meanIonI_within_lin_K)*100;
meanlinonI_PG_lin_K=mean(linonI_PG_lin_K);
stelinonI_PG_lin_K=std(linonI_PG_lin_K)/sqrt(length(linonI_PG_lin_K));
% lin on WM
linonW_PG_lin_K = (meanHonW_hybrid_lin_K./meanWonW_within_lin_K)*100;
meanlinonW_PG_lin_K=mean(linonW_PG_lin_K);
stelinonW_PG_lin_K=std(linonW_PG_lin_K)/sqrt(length(linonW_PG_lin_K));
% lin on Spr
linonS_PG_lin_K = (hybrid_lin_Spr_vafs(10:14)./within_lin_Spr_vafs(10:14))*100;
meanlinonS_PG_lin_K=mean(linonS_PG_lin_K);
stelinonS_PG_lin_K=std(linonS_PG_lin_K)/sqrt(length(linonS_PG_lin_K));


% Jango plot 2: percent generalizability
subplot(2,2,3); hold on
ylim([0 100]); xlim([0.3 3.5]); ylabel('%Gen')
errorbar(1,meanRNNonI_PG_rnn_J, steRNNonI_PG_rnn_J,steRNNonI_PG_rnn_J,'.m','LineWidth',LW,'MarkerSize',10);
errorbar(2,meanRNNonW_PG_rnn_J, steRNNonW_PG_rnn_J,steRNNonW_PG_rnn_J,'.g','LineWidth',LW,'MarkerSize',10);
errorbar(3,meanRNNonS_PG_rnn_J, steRNNonS_PG_rnn_J,steRNNonS_PG_rnn_J,'.b','LineWidth',LW,'MarkerSize',10);
set(gca,'YTick', 0:20:100);set(gca,'XTick',1:3);set(gca,'XTickLabel',{'Iso','Movement','Spring'})
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 15,'Fontname','Arial')
set(findall(gcf,'type','text'),'fontSize',20,'fontWeight','bold','Fontname','Arial')

% Kevin plot 2: percent generalizability
subplot(2,2,4); hold on
ylim([0 100]); xlim([0.3 3.5]);
errorbar(1,meanRNNonI_PG_rnn_K, steRNNonI_PG_rnn_K,steRNNonI_PG_rnn_K,'.m','LineWidth',LW,'MarkerSize',10);
errorbar(2,meanRNNonW_PG_rnn_K, steRNNonW_PG_rnn_K,steRNNonW_PG_rnn_K,'.g','LineWidth',LW,'MarkerSize',10);
errorbar(3,meanRNNonS_PG_rnn_K, steRNNonS_PG_rnn_K,steRNNonS_PG_rnn_K,'.b','LineWidth',LW,'MarkerSize',10);
set(gca,'YTick', 0:20:100);set(gca,'XTick',1:3);set(gca,'XTickLabel',{'Iso','Movement','Spring'})
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 15,'Fontname','Arial')
set(findall(gcf,'type','text'),'fontSize',20,'fontWeight','bold','Fontname','Arial')