function [EMGmean, EMGste] = KO_GetEMGMeanAndSTE_DuringHold(binnedData)

% Only use successful trials in trialtable
binnedData.trialtable=binnedData.trialtable(binnedData.trialtable(:,9)==82,:);
badTrials = find(binnedData.trialtable(:,7)==-1); binnedData.trialtable(badTrials,:)=[];
badTrials = find(binnedData.trialtable(:,10)==-1); binnedData.trialtable(badTrials,:)=[];


for numEMG = 1:length(binnedData.emgdatabin(1,:))
    for NumTargets = 1:length(unique(binnedData.trialtable(:,10)))
        TargetTrialIndices = find(binnedData.trialtable(:,10)==NumTargets);
        HoldPeriodEMGForTarget=[];
        for Index=1:length(TargetTrialIndices);
            % Get times for the hold period
            z=TargetTrialIndices(Index);
            holdEnd = binnedData.trialtable(z,8);
            holdStart = binnedData.trialtable(z,8)-0.5; %assumes 0.5sec hold period
            % Round to the nearest 0.05
            holdEnd = round(holdEnd/0.05)*0.05;
            holdStart = round(holdStart/0.05)*0.05;
            
            % Get rough indices for the hold period
            holdStartInd = find(binnedData.timeframe==holdStart);
            holdEndInd = find(binnedData.timeframe==holdEnd);
            
            % Get muscle activity during hold period
            HoldPeriodEMGForTarget = cat(1,HoldPeriodEMGForTarget,binnedData.emgdatabin(holdStartInd:holdEndInd,numEMG));
            
        end
        [EMGmean(numEMG,NumTargets), EMGste(numEMG,NumTargets)] = FindMeanAndSTE(HoldPeriodEMGForTarget);
        HoldPeriodEMGForTarget=[];
      
    end
       
end
   


 % Find mean and std of muscle activity during hold period
 EMGmean(:,NumTargets+1) = EMGmean(:,1);
 EMGste(:,NumTargets+1) = EMGste(:,1);
 
end


