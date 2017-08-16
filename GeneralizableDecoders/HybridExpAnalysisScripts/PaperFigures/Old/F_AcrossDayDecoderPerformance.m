%F_AcrossDayDecoderPerformance
% Run this after running the main script

[meanAllDaysIonI steAllDaysIonI] = FindMeanAndSTE(AllDaysIonI);
[meanAllDaysWonW steAllDaysWonW] = FindMeanAndSTE(AllDaysWonW);
[meanAllDaysWonI steAllDaysWonI] = FindMeanAndSTE(AllDaysWonI);
[meanAllDaysIonW steAllDaysIonW] = FindMeanAndSTE(AllDaysIonW);
[meanAllDaysHonI steAllDaysHonI] = FindMeanAndSTE(AllDaysHonI);
[meanAllDaysHonW steAllDaysHonW] = FindMeanAndSTE(AllDaysHonW);


[meanAllDaysHonS steAllDaysHonS] = FindMeanAndSTE(AllDaysHonS);
[meanAllDaysH3onI steAllDaysH3onI] = FindMeanAndSTE(AllDaysH3onI);
[meanAllDaysH3onW steAllDaysH3onW] = FindMeanAndSTE(AllDaysH3onW);
[meanAllDaysH3onS steAllDaysH3onS] = FindMeanAndSTE(AllDaysH3onS);
[meanAllDaysSonS steAllDaysSonS] = FindMeanAndSTE(AllDaysSonS);
[meanAllDaysWonS steAllDaysWonS] = FindMeanAndSTE(AllDaysWonS);
[meanAllDaysIonS steAllDaysIonS] = FindMeanAndSTE(AllDaysIonS);

[meanAllDaysSonI steAllDaysSonI] = FindMeanAndSTE(AllDaysSonI);
[meanAllDaysSonW steAllDaysSonW] = FindMeanAndSTE(AllDaysSonW);

[meanAllIsoFits steAllIsoFits] = FindMeanAndSTE(AllIsoFits);
[meanAllWmFits steAllWmFits] = FindMeanAndSTE(AllWmFits);
[meanAllSprFits steAllSprFits] = FindMeanAndSTE(AllSprFits);

figure; hold on;
h1 = errorbar(1,meanAllDaysIonI, steAllDaysIonI,steAllDaysIonI,'.b');
%h2 = errorbar(1,meanAllDaysHonI, steAllDaysHonI,steAllDaysHonI,'.g');
h3 = errorbar(1,meanAllDaysH3onI, steAllDaysH3onI,steAllDaysH3onI,'.c');
h4 = errorbar(1,meanAllDaysWonI, steAllDaysWonI,steAllDaysWonI,'.g');
h2 = errorbar(1,meanAllIsoFits, steAllIsoFits,steAllIsoFits, '.k');
h0 = errorbar(1, meanAllDaysSonI, steAllDaysSonI, steAllDaysSonI,'.','Color',[0.5 0 1]);

h5 = errorbar(2,meanAllDaysWonW, steAllDaysWonW,steAllDaysWonW,'.g');
%h6 = errorbar(2,meanAllDaysHonW, steAllDaysHonW,steAllDaysHonW,'.g');
h14 = errorbar(2,meanAllDaysSonW, steAllDaysSonW, steAllDaysSonW,'.','Color',[0.5 0 1]);
h7 = errorbar(2,meanAllDaysH3onW, steAllDaysH3onW,steAllDaysH3onW,'.c');
h8 = errorbar(2,meanAllDaysIonW, steAllDaysIonW,steAllDaysIonW,'.b');
h6 = errorbar(2,meanAllWmFits, steAllWmFits,steAllWmFits, '.k');


h9 = errorbar(3,meanAllDaysSonS, steAllDaysSonS,steAllDaysSonS,'.','Color',[0.5 0 1]);
%h10 = errorbar(3,meanAllDaysHonS, steAllDaysHonS,steAllDaysHonS,'.g');
h11 = errorbar(3,meanAllDaysH3onS, steAllDaysH3onS,steAllDaysH3onS,'.c');
h12 = errorbar(3,meanAllDaysIonS, steAllDaysIonS,steAllDaysIonS,'.b');
h13 = errorbar(3,meanAllDaysWonS, steAllDaysWonS,steAllDaysWonS,'.g');
h10 = errorbar(3,meanAllSprFits, steAllSprFits,steAllSprFits, '.k');
ylim([-1 1]); xlim([.5 3.5])
set([h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14],'MarkerSize',20);
set([h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14],'LineWidth',1.5)
MillerFigure
legend('Iso', 'H3','Move','Fit','Spring')

ax=gca;
ax.XTickLabel = {'','Iso','','Movement','','Spring',''};






