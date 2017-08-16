function PlotJangosTotalPercentSuccessAcrossSessions

[PercentSuccessNorm_ref, PercentSuccessRef]=PlotTotalPercentSuccess_Ref('Jango');
[PercentSuccessNorm_rot, PercentSuccessRot]=PlotTotalPercentSuccess_Rot('Jango');

xvals_Ref=[1 5 7 9 10 12];
xvals_Rot=[2 3 4 6 8 11 13];

colors=LearnAdaptColors;

figure; hold on; MS=15;
% Plot Reflected days
plot(xvals_Ref, PercentSuccessNorm_ref,'.k','MarkerSize',MS)
plot(xvals_Ref, PercentSuccessRef,'.','Color',colors(2,:),'MarkerSize',MS)
% Plot Rotated days
plot(xvals_Rot, PercentSuccessRot,'.','Color',colors(1,:),'MarkerSize',MS)
plot(xvals_Rot, PercentSuccessNorm_rot,'.k','MarkerSize',MS)
MillerFigure
title('Jango Percent Success Across Days')
for a=0:12
     plot([.5+a .5+a],[0 1.1],'k:')
end
set(gca,'xtick',1:13)
set(gca,'xticklabels',({'7/31','08/04','08/05','08/08','08/09','08/20','08/24','08/26','09/06',...
    '09/25','09/26','09/28','09/29'}))
legend Normal Reflected Rotated


figure;hold on;MillerFigure;MS=20;
plot(xvals_Rot,PercentSuccessRot./PercentSuccessNorm_rot,'.','Color',colors(1,:),'MarkerSize',MS)
plot(xvals_Ref,PercentSuccessRef./PercentSuccessNorm_ref,'.','Color',colors(2,:),'MarkerSize',MS)
ylim([0 1.1])
xlim([0.5 12.5])
for a=0:12
     plot([.5+a .5+a],[0 1.1],'k:')
end
 plot([0 16.5],[1 1],'k:')
set(gca,'xtick',1:13)
set(gca,'xticklabels',({'7/31','08/04','08/05','08/08','08/09','08/20','08/24','08/26','09/06',...
    '09/25','09/26','09/28','09/29'}))
title('Jango Percent Success Ratios Across Days')
legend Rotated Reflected

