function [TargetSuccess] = PercentSuccessPerTarget(binnedData,plotFlag,plotTitle,color)

% Isolate trialtable into its own variable
tt=binnedData.trialtable;
badTrials = find(tt(:,7)==-1); tt(badTrials,:)=[];

for b=1:8
    TargetIndices=[];TargetTrials=[];
    TargetIndices=find(tt(:,10)==b);
    TargetTrials = tt(TargetIndices,:);
    NumSuccess = length(find(TargetTrials(:,9)==82));
    TargetSuccess(b) = NumSuccess/length(TargetTrials);
end
TargetSuccess(9)=TargetSuccess(1);

if plotFlag==1
    theta = degtorad(0:45:360);
    % figure;
    polarplot(theta,TargetSuccess,'-*','Color',color,'MarkerSize',5,'LineWidth',1.2)
    rlim([0 1])
    title(plotTitle)
   % thetaticks(0:45:360)
   % thetaticklabels({'1','2','3','4','5','6','7','8'})
end

TargetSuccess=TargetSuccess(1:8);


end



