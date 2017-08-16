function PlotInitialTrajectoryOffset(binnedBaseline, binnedOfInterest)
%binnedBaseline will usually be binnedNormalBC

% How far off is initial trajectory from a baseline trajectory (probably
% computed from normal BC

% Get his initial trajectory for the file of interest
[TrajX, TrajY, TargetNumberPerTrial] = InitialTrajectories(binnedOfInterest,0.3);

% Set up the baseline trajectory, which is the trajectory during normal BC
[BaselineTrajX, BaselineTrajY, BaselineTargetNumber] = InitialTrajectories(binnedBaseline,0.3);

% Find mean start position from baseline (the average of all the starts for all targets)
StartPointA=[mean(BaselineTrajX(:,1)) mean(BaselineTrajY(:,1))];

colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
%figure; PlotTargetsFromBinned(binnedBaseline); hold on
for a=1:8 % number of targets
    BaseTargetInds=[];BaseTargetTrajX=[];BaseTargetTrajY=[];
    BaseTargetInds = find(BaselineTargetNumber==a);
    BaseTargetTrajX = BaselineTrajX(BaseTargetInds,:);
    BaseTargetTrajY = BaselineTrajY(BaseTargetInds,:);
    meanBaseTrajX(a,:) = mean(BaseTargetTrajX,1);meanBaseTrajY(a,:) = mean(BaseTargetTrajY,1);
   %plot(meanBaseTrajX(a,:),meanBaseTrajY(a,:),'Color',colors(a,:))

    % Make baseline vector (The vector that goes from A to B is B-A)
    %meanBasePointA=[meanBaseTrajX(a,1) meanBaseTrajY(a,1)];
    meanBasePointB=[meanBaseTrajX(a,end) meanBaseTrajY(a,end)];
    BaselineVector(a,1:2)=meanBasePointB-StartPointA;
end



ErrorAngles_Target1=CalculateErrorAngle(TrajX,TrajY,1,TargetNumberPerTrial,BaselineVector,StartPointA);
ErrorAngles_Target2=CalculateErrorAngle(TrajX,TrajY,2,TargetNumberPerTrial,BaselineVector,StartPointA);
ErrorAngles_Target3=CalculateErrorAngle(TrajX,TrajY,3,TargetNumberPerTrial,BaselineVector,StartPointA);
ErrorAngles_Target4=CalculateErrorAngle(TrajX,TrajY,4,TargetNumberPerTrial,BaselineVector,StartPointA);
ErrorAngles_Target5=CalculateErrorAngle(TrajX,TrajY,5,TargetNumberPerTrial,BaselineVector,StartPointA);
ErrorAngles_Target6=CalculateErrorAngle(TrajX,TrajY,6,TargetNumberPerTrial,BaselineVector,StartPointA);
ErrorAngles_Target7=CalculateErrorAngle(TrajX,TrajY,7,TargetNumberPerTrial,BaselineVector,StartPointA);
ErrorAngles_Target8=CalculateErrorAngle(TrajX,TrajY,8,TargetNumberPerTrial,BaselineVector,StartPointA);

colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
MS=10;
subplot(5,5,15)
plot(ErrorAngles_Target1,'*','Color',colors(1,:))
title('1');ylim([0 180])
MillerFigure

subplot(5,5,9)
plot(ErrorAngles_Target2,'*','Color',colors(2,:))
title('2');ylim([0 180])
MillerFigure

subplot(5,5,3)
plot(ErrorAngles_Target3,'*','Color',colors(3,:))
title('3');ylim([0 180])
MillerFigure

subplot(5,5,7)
plot(ErrorAngles_Target4,'*','Color',colors(4,:))
title('4');ylim([0 180])
MillerFigure

subplot(5,5,11)
plot(ErrorAngles_Target5,'*','Color',colors(5,:))
title('5');ylim([0 180])
MillerFigure

subplot(5,5,17)
plot(ErrorAngles_Target6,'*','Color',colors(6,:))
title('6');ylim([0 180])
MillerFigure

subplot(5,5,23)
plot(ErrorAngles_Target7,'*','Color',colors(7,:))
title('7');ylim([0 180])
MillerFigure

subplot(5,5,19)
plot(ErrorAngles_Target8,'*','Color',colors(8,:))
title('8');ylim([0 180])
MillerFigure



% Polar plots (commented for now but good code)
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
% 
% 
% 
% 
