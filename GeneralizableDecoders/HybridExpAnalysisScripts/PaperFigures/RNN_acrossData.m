

JangoIndices=1:9;
KevinIndices=10:14;

[meanIonI_rnn, steIonI_rnn] = FindMeanAndSTE(within_rnn_Iso_vafs(KevinIndices));
[meanSonI_rnn, steSonI_rnn] = FindMeanAndSTE(across_rnn_SonI_vafs(KevinIndices));
[meanWonI_rnn, steWonI_rnn] = FindMeanAndSTE(across_rnn_WonI_vafs(KevinIndices));

[meanWonW_rnn, steWonW_rnn] = FindMeanAndSTE(within_rnn_Wm_vafs(KevinIndices));
[meanSonW_rnn, steSonW_rnn] = FindMeanAndSTE(across_rnn_SonW_vafs(KevinIndices));
[meanIonW_rnn, steIonW_rnn] = FindMeanAndSTE(across_rnn_IonW_vafs(KevinIndices));

[meanSonS_rnn, steSonS_rnn] = FindMeanAndSTE(within_rnn_Spr_vafs(KevinIndices));
[meanWonS_rnn, steWonS_rnn] = FindMeanAndSTE(across_rnn_WonS_vafs(KevinIndices));
[meanIonS_rnn, steIonS_rnn] = FindMeanAndSTE(across_rnn_IonS_vafs(KevinIndices));


% plot
figure; hold on;ylim([0 1])
LW=2; MS=20;
errorbar(1,meanIonI_rnn,steIonI_rnn,steIonI_rnn,'m.','LineWidth',LW,'MarkerSize',MS);
errorbar(1,meanSonI_rnn,steSonI_rnn,steSonI_rnn,'b.','LineWidth',LW,'MarkerSize',MS);
errorbar(1,meanWonI_rnn,steWonI_rnn,steWonI_rnn,'g.','LineWidth',LW,'MarkerSize',MS);

errorbar(2,meanWonW_rnn,steWonW_rnn,steWonW_rnn,'g.','LineWidth',LW,'MarkerSize',MS);
errorbar(2,meanSonW_rnn,steSonW_rnn,steSonW_rnn,'b.','LineWidth',LW,'MarkerSize',MS);
errorbar(2,meanIonW_rnn,steIonW_rnn,steIonW_rnn,'m.','LineWidth',LW,'MarkerSize',MS);

errorbar(3,meanSonS_rnn,steSonS_rnn,steSonS_rnn,'b.','LineWidth',LW,'MarkerSize',MS);
errorbar(3,meanIonS_rnn,steIonS_rnn,steIonS_rnn,'m.','LineWidth',LW,'MarkerSize',MS);
errorbar(3,meanWonS_rnn,steWonS_rnn,steWonS_rnn,'g.','LineWidth',LW,'MarkerSize',MS);

