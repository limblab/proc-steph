function Targetp=PlotInitialTrajectoryOffset_IdealBaseVector(binnedOfInterest,SecAfterGo,plotFlag,SubPlotTitle)


% How far off is initial trajectory from a ideal trajectory
figure
% Get his initial trajectory for the file of interest
[TrajX, TrajY, TargetNumberPerTrial] = TrajectoriesStarting200AfterGo(binnedOfInterest,SecAfterGo); %200ms is good

colors = distinguishable_colors(9); colors(8,:)=colors(9,:);

TargetCenters=FindTargetCenter(binnedOfInterest);

% figure
% PlotTargetsFromBinned(binnedData); hold on

ErrorAngles_Target1=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,1,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target2=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,2,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target3=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,3,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target4=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,4,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target5=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,5,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target6=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,6,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target7=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,7,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target8=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,8,TargetNumberPerTrial,TargetCenters);

% Stats signrank
numSamples=10;
Tp(1)=signrank(ErrorAngles_Target1(1:numSamples),ErrorAngles_Target1(end-numSamples+1:end));
Tp(2)=signrank(ErrorAngles_Target2(1:numSamples),ErrorAngles_Target2(end-numSamples+1:end));
Tp(3)=signrank(ErrorAngles_Target3(1:numSamples),ErrorAngles_Target3(end-numSamples+1:end));
Tp(4)=signrank(ErrorAngles_Target4(1:numSamples),ErrorAngles_Target4(end-numSamples+1:end));
Tp(5)=signrank(ErrorAngles_Target5(1:numSamples),ErrorAngles_Target5(end-numSamples+1:end));
Tp(6)=signrank(ErrorAngles_Target6(1:numSamples),ErrorAngles_Target6(end-numSamples+1:end));
Tp(7)=signrank(ErrorAngles_Target7(1:numSamples),ErrorAngles_Target7(end-numSamples+1:end));
Tp(8)=signrank(ErrorAngles_Target8(1:numSamples),ErrorAngles_Target8(end-numSamples+1:end));
Tp=Tp';
Targetp=Tp./2;

% Mean angle difference: first 10 trials- last 10 trials
DeltaAngle(1)=mean(ErrorAngles_Target1(1:numSamples))-mean(ErrorAngles_Target1(end-numSamples+1:end));
DeltaAngle(2)=mean(ErrorAngles_Target2(1:numSamples))-mean(ErrorAngles_Target2(end-numSamples+1:end));
DeltaAngle(3)=mean(ErrorAngles_Target3(1:numSamples))-mean(ErrorAngles_Target3(end-numSamples+1:end));
DeltaAngle(4)=mean(ErrorAngles_Target4(1:numSamples))-mean(ErrorAngles_Target4(end-numSamples+1:end));
DeltaAngle(5)=mean(ErrorAngles_Target5(1:numSamples))-mean(ErrorAngles_Target5(end-numSamples+1:end));
DeltaAngle(6)=mean(ErrorAngles_Target6(1:numSamples))-mean(ErrorAngles_Target6(end-numSamples+1:end));
DeltaAngle(7)=mean(ErrorAngles_Target7(1:numSamples))-mean(ErrorAngles_Target7(end-numSamples+1:end));
DeltaAngle(8)=mean(ErrorAngles_Target8(1:numSamples))-mean(ErrorAngles_Target8(end-numSamples+1:end));
DeltaAngle=DeltaAngle';

 
%Moving average filter
NumberOfSamples=5;
ErrorAngles_Target1=movmean(ErrorAngles_Target1,NumberOfSamples);
ErrorAngles_Target2=movmean(ErrorAngles_Target2,NumberOfSamples);
ErrorAngles_Target3=movmean(ErrorAngles_Target3,NumberOfSamples);
ErrorAngles_Target4=movmean(ErrorAngles_Target4,NumberOfSamples);
ErrorAngles_Target5=movmean(ErrorAngles_Target5,NumberOfSamples);
ErrorAngles_Target6=movmean(ErrorAngles_Target6,NumberOfSamples);
ErrorAngles_Target7=movmean(ErrorAngles_Target7,NumberOfSamples);
ErrorAngles_Target8=movmean(ErrorAngles_Target8,NumberOfSamples);

if plotFlag==1
    colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
    MS=10;
    subplot(5,5,15)
    plot(ErrorAngles_Target1,'.','Color',colors(1,:))
    title('1');ylim([0 180])
    if Targetp(1)<0.05
        xlabel('significant')
    end
    MillerFigure
    
    subplot(5,5,9)
    plot(ErrorAngles_Target2,'.','Color',colors(2,:))
    title('2');ylim([0 180])
    if Targetp(2)<0.05
        xlabel('significant')
    end
    MillerFigure
    
    subplot(5,5,3)
    plot(ErrorAngles_Target3,'.','Color',colors(3,:))
    title('3');ylim([0 180])
    if Targetp(3)<0.05
        xlabel('significant')
    end
    MillerFigure
    title(SubPlotTitle,'Interpreter','none')
    
    subplot(5,5,7)
    plot(ErrorAngles_Target4,'.','Color',colors(4,:))
    title('4');ylim([0 180])
    if Targetp(4)<0.05
        xlabel('significant')
    end
    MillerFigure
    
    subplot(5,5,11)
    plot(ErrorAngles_Target5,'.','Color',colors(5,:))
    title('5');ylim([0 180])
    if Targetp(5)<0.05
        xlabel('significant')
    end
    MillerFigure
    
    subplot(5,5,17)
    plot(ErrorAngles_Target6,'.','Color',colors(6,:))
    title('6');ylim([0 180])
    if Targetp(6)<0.05
        xlabel('significant')
    end
    MillerFigure
    
    subplot(5,5,23)
    plot(ErrorAngles_Target7,'.','Color',colors(7,:))
    title('7');ylim([0 180])
    if Targetp(7)<0.05
        xlabel('significant')
    end
    MillerFigure
    
    subplot(5,5,19)
    plot(ErrorAngles_Target8,'.','Color',colors(8,:))
    title('8');ylim([0 180])
    if Targetp(8)<0.05
        xlabel('significant')
    end
    MillerFigure
end

% Plot all the error angles (commented for now but it works)
% ErrorAngles=CalculateErrorAngle_IdealBase_AllTrials(TrajX,TrajY,TargetNumberPerTrial,TargetCenters);
% ErrorAngles=movmean(ErrorAngles,30);
% figure;plot(ErrorAngles,'*-')
% MillerFigure


% Polar plot (commented for now but it works)
% anglemeans = [mean(ErrorAngles_Target1) mean(ErrorAngles_Target2) mean(ErrorAngles_Target3) mean(ErrorAngles_Target4)...
%     mean(ErrorAngles_Target5) mean(ErrorAngles_Target6) mean(ErrorAngles_Target7) mean(ErrorAngles_Target8) mean(ErrorAngles_Target1)];
% anglestd = [std(ErrorAngles_Target1) std(ErrorAngles_Target2) std(ErrorAngles_Target3) std(ErrorAngles_Target4)...
%     std(ErrorAngles_Target5) std(ErrorAngles_Target6) std(ErrorAngles_Target7) std(ErrorAngles_Target8) std(ErrorAngles_Target1)];
% 
% 
% % Polar plot of mean Error Angle across targets
% theta = degtorad(0:45:360);
% figure; 
% polarplot(theta,anglemeans,'k-*','MarkerSize',5,'LineWidth',1.2)
% hold on
% polarplot(theta,anglemeans+anglestd,'k--','Color',[.1 .1 .1],'MarkerSize',5,'LineWidth',1.2)
% polarplot(theta,anglemeans-anglestd,'k--','Color',[.1 .1 .1],'MarkerSize',5,'LineWidth',1.2)
% thetaticks(0:45:360)
% thetaticklabels({'1','2','3','4','5','6','7','8'})
% rlim([0 180])
% rticks(0:30:180)




