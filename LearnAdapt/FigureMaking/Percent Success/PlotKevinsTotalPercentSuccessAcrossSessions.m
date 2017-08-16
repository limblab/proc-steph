function PlotKevinsTotalPercentSuccessAcrossSessions

[PercentSuccessNorm_ref, PercentSuccessRef]=PlotTotalPercentSuccess_Ref('Kevin');
[PercentSuccessNorm_rot, PercentSuccessRot]=PlotTotalPercentSuccess_Rot('Kevin');

xvals_Ref=[1 3 6 9 10 12 14 16];
xvals_Rot=[2 4 5 7 8 11 13 15];

colors=LearnAdaptColors;

figure; hold on; MS=15;
MillerFigure
% Plot Reflected days
plot(xvals_Ref, PercentSuccessNorm_ref,'.k','MarkerSize',MS)
plot(xvals_Ref, PercentSuccessRef,'.','Color',colors(2,:),'MarkerSize',MS)
% Plot Rotated days
plot(xvals_Rot, PercentSuccessRot,'.','Color',colors(1,:),'MarkerSize',MS)
plot(xvals_Rot, PercentSuccessNorm_rot,'.k','MarkerSize',MS)
xlim([0.5 17.5])
for a=0:16
     plot([.5+a .5+a],[0 1.1],'k:')
end
title('Kevin Percent Success Across Days')
set(gca,'xtick',1:17)
set(gca,'xticklabels',({'4/2','4/3','4/6','4/7','4/10','4/15','4/16',...
    '4/17','4/20','4/23','5/1','5/2','5/3','5/4','6/13','6/14','6/25'}))
legend Normal Reflected Rotated


figure;hold on;MillerFigure;MS=20;
plot(xvals_Rot,PercentSuccessRot./PercentSuccessNorm_rot,'.','Color',colors(1,:),'MarkerSize',MS)
plot(xvals_Ref,PercentSuccessRef./PercentSuccessNorm_ref,'.','Color',colors(2,:),'MarkerSize',MS)
ylim([0 1.1])
xlim([0.5 16.5])
for a=0:15
     plot([.5+a .5+a],[0 1.1],'k:')
end
 plot([0 16.5],[1 1],'k:')
set(gca,'xtick',1:16)
set(gca,'xticklabels',({'4/2','4/3','4/6','4/7','4/10','4/15','4/16',...
    '4/17','4/20','4/23','5/1','5/2','5/3','5/4','6/13','6/14','6/25'}))
title('Kevin Percent Success Ratios Across Days')
legend Rotated Reflected


