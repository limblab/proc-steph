function RNN_across(monkeyname)

load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\Updates\vaf_results_across_rnn.mat')
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\Updates\vaf_results_rnn.mat')

%load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\vaf_results_across_rnn.mat')
%load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\vaf_results_rnn.mat')

if strcmp(monkeyname,'Jango')
    Indices=1:9;
    plotNumber=1;
end
if strcmp(monkeyname,'Kevin')
    Indices=10:14;
    plotNumber=2;
end

[meanHonI, steHonI] = FindMeanAndSTE(hybrid_rnn_Iso_vafs(Indices));
[meanHonW, steHonW] = FindMeanAndSTE(hybrid_rnn_Wm_vafs(Indices));
[meanHonS, steHonS] = FindMeanAndSTE(hybrid_rnn_Spr_vafs(Indices));

[meanWonI, steWonI] = FindMeanAndSTE(across_rnn_WonI_vafs(Indices));
[meanSonI, steSonI] = FindMeanAndSTE(across_rnn_SonI_vafs(Indices));
[meanIonI, steIonI] = FindMeanAndSTE(within_rnn_Iso_vafs(Indices));

[meanWonW, steWonW] = FindMeanAndSTE(within_rnn_Wm_vafs(Indices));
[meanSonW, steSonW] = FindMeanAndSTE(across_rnn_SonW_vafs(Indices));
[meanIonW, steIonW] = FindMeanAndSTE(across_rnn_IonW_vafs(Indices));

[meanWonS, steWonS] = FindMeanAndSTE(across_rnn_WonS_vafs(Indices));
[meanSonS, steSonS] = FindMeanAndSTE(within_rnn_Spr_vafs(Indices));
[meanIonS, steIonS] = FindMeanAndSTE(across_rnn_IonS_vafs(Indices));


figure;
subplot(1,2,plotNumber); hold on
ylim([0 1]); xlim([0.5 3.5]); LW=1;MS=20;
%h1 = errorbar(1,meanHonI, steHonI,steHonI,'.c','LineWidth',LW,'MarkerSize',MS);
h2 = errorbar(1.01,meanIonI, steIonI,steIonI,'.m','LineWidth',LW,'MarkerSize',MS);
h3 = errorbar(1.02,meanWonI, steWonI,steWonI,'.g','LineWidth',LW,'MarkerSize',MS);
h4 = errorbar(1.03,meanSonI, steSonI,steSonI,'.b','LineWidth',LW,'MarkerSize',MS);

%h9 = errorbar(2,meanHonW, steHonW,steHonW,'.c','LineWidth',LW,'MarkerSize',MS);
h10 = errorbar(2.01,meanIonW, steIonW,steIonW,'.m','LineWidth',LW,'MarkerSize',MS);
h11 = errorbar(2.02,meanWonW, steWonW,steWonW,'.g','LineWidth',LW,'MarkerSize',MS);
h12 = errorbar(2.03,meanSonW, steSonW,steSonW,'.b','LineWidth',LW,'MarkerSize',MS);

%h13 = errorbar(3,meanHonS, steHonS,steHonS,'.c','LineWidth',LW,'MarkerSize',MS);
h14 = errorbar(3.01,meanIonS, steIonS,steIonS,'.m','LineWidth',LW,'MarkerSize',MS);
h15 = errorbar(3.02,meanWonS, steWonS,steWonS,'.g','LineWidth',LW,'MarkerSize',MS);
h16 = errorbar(3.03,meanSonS, steSonS,steSonS,'.b','LineWidth',LW,'MarkerSize',MS);

legend('Hybrid','Isometric','Movement','Spring')
legend boxoff

set(gca,'XTick',1:3);set(gca,'XTickLabel',{'Iso','Movement','Spring'})
MillerFigure
