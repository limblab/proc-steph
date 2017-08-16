function PathLength_PerTargetP = PlotPathLengthPerTarget(AllPathLengths,TargetNumber,SubplotTitle)

Target1PathLength = SeparatePathLengthByTarget(TargetNumber,AllPathLengths,1);
Target2PathLength = SeparatePathLengthByTarget(TargetNumber,AllPathLengths,2);
Target3PathLength = SeparatePathLengthByTarget(TargetNumber,AllPathLengths,3);
Target4PathLength = SeparatePathLengthByTarget(TargetNumber,AllPathLengths,4);
Target5PathLength = SeparatePathLengthByTarget(TargetNumber,AllPathLengths,5);
Target6PathLength = SeparatePathLengthByTarget(TargetNumber,AllPathLengths,6);
Target7PathLength = SeparatePathLengthByTarget(TargetNumber,AllPathLengths,7);
Target8PathLength = SeparatePathLengthByTarget(TargetNumber,AllPathLengths,8);

% Stats signrank
numSamples=10;
Tp(1)=signrank(Target1PathLength(1:numSamples),Target1PathLength(end-numSamples+1:end));
Tp(2)=signrank(Target2PathLength(1:numSamples),Target2PathLength(end-numSamples+1:end));
Tp(3)=signrank(Target3PathLength(1:numSamples),Target3PathLength(end-numSamples+1:end));
Tp(4)=signrank(Target4PathLength(1:numSamples),Target4PathLength(end-numSamples+1:end));
Tp(5)=signrank(Target5PathLength(1:numSamples),Target5PathLength(end-numSamples+1:end));
Tp(6)=signrank(Target6PathLength(1:numSamples),Target6PathLength(end-numSamples+1:end));
Tp(7)=signrank(Target7PathLength(1:numSamples),Target7PathLength(end-numSamples+1:end));
Tp(8)=signrank(Target8PathLength(1:numSamples),Target8PathLength(end-numSamples+1:end));
Tp=Tp';
Targetp=Tp./2;

%Initialize Variables
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
MS=8;
yUpper=70;

figure
% Target 1
subplot(5,5,15);
plot(Target1PathLength,'.','Color',colors(1,:),'MarkerSize',MS)
MillerFigure;  title('1'); ylim([0 yUpper])
if Targetp(1)<0.05
    xlabel('significant')
end

% Target 2
subplot(5,5,9);
plot(Target2PathLength,'.','Color',colors(2,:),'MarkerSize',MS)
MillerFigure;  title('2'); ylim([0 yUpper])
if Targetp(2)<0.05
    xlabel('significant')
end

% Target 3
subplot(5,5,3);
plot(Target3PathLength,'.','Color',colors(3,:),'MarkerSize',MS)
MillerFigure;  title('3'); ylim([0 yUpper])
if Targetp(3)<0.05
    xlabel('significant')
end
title(SubplotTitle,'Interpreter','none')

% Target 4
subplot(5,5,7);
plot(Target4PathLength,'.','Color',colors(4,:),'MarkerSize',MS)
MillerFigure;  title('4'); ylim([0 yUpper])
if Targetp(4)<0.05
    xlabel('significant')
end

% Target 5
subplot(5,5,11);
plot(Target5PathLength,'.','Color',colors(5,:),'MarkerSize',MS)
MillerFigure;  title('5'); ylim([0 yUpper])
if Targetp(5)<0.05
    xlabel('significant')
end

% Target 6
subplot(5,5,17);
plot(Target6PathLength,'.','Color',colors(6,:),'MarkerSize',MS)
MillerFigure;  title('6'); ylim([0 yUpper])
if Targetp(6)<0.05
    xlabel('significant')
end

% Target 7
subplot(5,5,23);
plot(Target7PathLength,'.','Color',colors(7,:),'MarkerSize',MS)
MillerFigure;  title('7'); ylim([0 yUpper])
if Targetp(7)<0.05
    xlabel('significant')
end

% Target 8
subplot(5,5,19);
plot(Target8PathLength,'.','Color',colors(8,:),'MarkerSize',MS)
MillerFigure;  title('8'); ylim([0 yUpper])
if Targetp(8)<0.05
    xlabel('significant')
end

PathLength_PerTargetP = Targetp;

end