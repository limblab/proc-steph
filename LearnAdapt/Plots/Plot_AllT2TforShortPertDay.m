function Plot_AllT2TforShortPertDay(bdf1,bdf2,bdf3)

[Struct1] = Plot_T2T_AcrossTime_PerTarget(bdf1,'');close
[Struct2] = Plot_T2T_AcrossTime_PerTarget(bdf2,'');close
[Struct3] = Plot_T2T_AcrossTime_PerTarget(bdf3,'');close

AllT2Ts.Target1=cat(1,Struct1.Target1(:,1),Struct2.Target1(:,1),Struct3.Target1(:,1));
AllT2Ts.Target2=cat(1,Struct1.Target2(:,1),Struct2.Target2(:,1),Struct3.Target2(:,1));
AllT2Ts.Target3=cat(1,Struct1.Target3(:,1),Struct2.Target3(:,1),Struct3.Target3(:,1));
AllT2Ts.Target4=cat(1,Struct1.Target4(:,1),Struct2.Target4(:,1),Struct3.Target4(:,1));
AllT2Ts.Target5=cat(1,Struct1.Target5(:,1),Struct2.Target5(:,1),Struct3.Target5(:,1));
AllT2Ts.Target6=cat(1,Struct1.Target6(:,1),Struct2.Target6(:,1),Struct3.Target6(:,1));
AllT2Ts.Target7=cat(1,Struct1.Target7(:,1),Struct2.Target7(:,1),Struct3.Target7(:,1));
AllT2Ts.Target8=cat(1,Struct1.Target8(:,1),Struct2.Target8(:,1),Struct3.Target8(:,1));

% MAKE FIGURE--------------------------------------------------------------
figure;
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
MS=10;yMax=5

% START SUBPLOTS-----------------------------------------------------------
subplot(5,5,15)
plot(AllT2Ts.Target1(:,1),'b*'); hold on
plot([length(Struct1.Target1)+0.5 length(Struct1.Target1)+0.5], [0 yMax],'k-')
plot([length(Struct1.Target1)+length(Struct2.Target1)+0.5 length(Struct1.Target1)+length(Struct2.Target1)+0.5], [0 yMax],'k-')
title('1');ylim([0 yMax])
MillerFigure

subplot(5,5,9)
plot(AllT2Ts.Target2(:,1),'b*'); hold on
plot([length(Struct1.Target2)+0.5 length(Struct1.Target2)+0.5], [0 yMax],'k-')
plot([length(Struct1.Target2)+length(Struct2.Target2)+0.5 length(Struct1.Target2)+length(Struct2.Target2)+0.5], [0 yMax],'k-')
title('2');ylim([0 yMax])
MillerFigure

subplot(5,5,3)
plot(AllT2Ts.Target3(:,1),'b*'); hold on
plot([length(Struct1.Target3)+0.5 length(Struct1.Target3)+0.5], [0 yMax],'k-')
plot([length(Struct1.Target3)+length(Struct2.Target3)+0.5 length(Struct1.Target3)+length(Struct2.Target3)+0.5], [0 yMax],'k-')
title('3');ylim([0 yMax])
MillerFigure

subplot(5,5,7)
plot(AllT2Ts.Target4(:,1),'b*'); hold on
plot([length(Struct1.Target4)+0.5 length(Struct1.Target4)+0.5], [0 yMax],'k-')
plot([length(Struct1.Target4)+length(Struct2.Target4)+0.5 length(Struct1.Target4)+length(Struct2.Target4)+0.5], [0 yMax],'k-')
title('4');ylim([0 yMax])
MillerFigure

subplot(5,5,11)
plot(AllT2Ts.Target5(:,1),'b*'); hold on
plot([length(Struct1.Target5)+0.5 length(Struct1.Target5)+0.5], [0 yMax],'k-')
plot([length(Struct1.Target5)+length(Struct2.Target5)+0.5 length(Struct1.Target5)+length(Struct2.Target5)+0.5], [0 yMax],'k-')
title('5');ylim([0 yMax])
MillerFigure

subplot(5,5,17)
plot(AllT2Ts.Target6(:,1),'b*'); hold on
plot([length(Struct1.Target6)+0.5 length(Struct1.Target6)+0.5], [0 yMax],'k-')
plot([length(Struct1.Target6)+length(Struct2.Target6)+0.5 length(Struct1.Target6)+length(Struct2.Target6)+0.5], [0 yMax],'k-')
title('6');ylim([0 yMax])
MillerFigure

subplot(5,5,23)
plot(AllT2Ts.Target7(:,1),'b*'); hold on
plot([length(Struct1.Target7)+0.5 length(Struct1.Target7)+0.5], [0 yMax],'k-')
plot([length(Struct1.Target7)+length(Struct2.Target7)+0.5 length(Struct1.Target7)+length(Struct2.Target7)+0.5], [0 yMax],'k-')
title('7');ylim([0 yMax])
MillerFigure

subplot(5,5,19)
plot(AllT2Ts.Target8(:,1),'b*'); hold on
plot([length(Struct1.Target8)+0.5 length(Struct1.Target8)+0.5], [0 yMax],'k-')
plot([length(Struct1.Target8)+length(Struct2.Target8)+0.5 length(Struct1.Target8)+length(Struct2.Target8)+0.5], [0 yMax],'k-')
title('8');ylim([0 yMax])
MillerFigure




end