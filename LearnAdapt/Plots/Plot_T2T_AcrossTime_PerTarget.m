function [T2TfirstStruct] = Plot_T2T_AcrossTime_PerTarget(bdf,plotTitle)

[T2TfirstStruct T2TlastStruct DialInTimeStruct TargetEntriesStruct TrialsStruct] = ComputeTaskTimeMetrics(bdf);

figure;
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
MS=10;
subplot(5,5,15)
Plot_T2Tfirst_equation(T2TfirstStruct.Target1)
plot(T2TfirstStruct.Target1(:,1),'b*')
title('1');ylim([0 5])
MillerFigure


subplot(5,5,9)
Plot_T2Tfirst_equation(T2TfirstStruct.Target2)
plot(T2TfirstStruct.Target2(:,1),'b*')
title('2');ylim([0 5])
MillerFigure

subplot(5,5,3)
Plot_T2Tfirst_equation(T2TfirstStruct.Target3)
plot(T2TfirstStruct.Target3(:,1),'b*')
title(plotTitle);ylim([0 5])
MillerFigure

subplot(5,5,7)
Plot_T2Tfirst_equation(T2TfirstStruct.Target4)
plot(T2TfirstStruct.Target4(:,1),'b*')
title('4');ylim([0 5])
MillerFigure


subplot(5,5,11)
Plot_T2Tfirst_equation(T2TfirstStruct.Target5)
plot(T2TfirstStruct.Target5(:,1),'b*')
title('5');ylim([0 5])
MillerFigure


subplot(5,5,17)
Plot_T2Tfirst_equation(T2TfirstStruct.Target6)
plot(T2TfirstStruct.Target6(:,1),'b*')
title('6');ylim([0 5])
MillerFigure


subplot(5,5,23)
Plot_T2Tfirst_equation(T2TfirstStruct.Target7)
plot(T2TfirstStruct.Target7(:,1),'b*')
title('7');ylim([0 5])
MillerFigure


subplot(5,5,19)
Plot_T2Tfirst_equation(T2TfirstStruct.Target8)
plot(T2TfirstStruct.Target8(:,1),'b*')
title('8');ylim([0 5])
MillerFigure

end