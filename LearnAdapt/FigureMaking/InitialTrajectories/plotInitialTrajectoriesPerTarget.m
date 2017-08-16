function plotInitialTrajectoriesPerTarget(binnedData,TrajectoriesX,TrajectoriesY, TargetNumber)

colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
figure
PlotTargetsFromBinned(binnedData); hold on

% Separate out trajectories by target (in a 3d variable. XbyYbyTarget)
for a=1:8 % number of targets
    TargetInds=[];TargetTrajX=[];TargetTrajY=[];
    TargetInds = find(TargetNumber==a);
    TargetTrajX = TrajectoriesX(TargetInds,:);
    TargetTrajY = TrajectoriesY(TargetInds,:);
    meanTrajX = mean(TargetTrajX,1);meanTrajY = mean(TargetTrajY,1);
    stdTrajX = std(TargetTrajX,1);stdTrajY = std(TargetTrajY,1);
%       for b=1:length(TargetTrajX(:,1)) %
%         plot(TargetTrajX(b,:),TargetTrajY(b,:),'-','Color',colors(a,:)); %
%       end %
plot(meanTrajX,meanTrajY,'LineWidth',1.5,'Color',colors(a,:))
%axis off
end