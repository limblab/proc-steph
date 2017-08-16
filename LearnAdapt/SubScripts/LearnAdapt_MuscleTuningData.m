function [EMGmean, EMGste] = LearnAdapt_MuscleTuningData(binnedData,epochLength)

% Only use successful trials in trialtable
badTrials = find(binnedData.trialtable(:,7)==-1); binnedData.trialtable(badTrials,:)=[];
badTrials = find(binnedData.trialtable(:,10)==-1); binnedData.trialtable(badTrials,:)=[];


for numEMG = 1:length(binnedData.emgdatabin(1,:))
    for NumTargets = 1:length(unique(binnedData.trialtable(:,10)))
        TargetTrialIndices = find(binnedData.trialtable(:,10)==NumTargets);
        HoldPeriodEMGForTarget=[];
        for Index=1:length(TargetTrialIndices);
            % Get times for the initial trajectory
            z=TargetTrialIndices(Index);
            GoCue=[]; EpochEnd=[]; indices=[];
            GoCue = binnedData.trialtable(z,7);
            
            % Set epoch end to be X ms after go cue
            EpochEnd = GoCue+epochLength;
          % Get rough indices for trajectory period
           indices = find(binnedData.timeframe>=GoCue & binnedData.timeframe<=EpochEnd);
            
            % Get muscle activity during hold period
            TrajEMGForTarget = cat(1,HoldPeriodEMGForTarget,binnedData.emgdatabin(indices,numEMG));
            
        end
        [EMGmean(numEMG,NumTargets), EMGste(numEMG,NumTargets)] = FindMeanAndSTE(TrajEMGForTarget);
        TrajEMGForTarget=[];
        
    end
    
    % Find mean and std of muscle activity during hold period
    EMGmean(:,NumTargets+1) = EMGmean(:,1);
    EMGste(:,NumTargets+1) = EMGste(:,1);
end 


EMGste_plus = EMGmean+EMGste;
EMGste_minus = EMGmean-EMGste;


% Make polar plots
theta = degtorad([0:45:360]);
figure; hold on;
for b=1:4%length(EMGmean(:,1))
    subplot(2,2,b)
    polarplot(theta,EMGmean(b,:),'k*-','LineWidth',1.5)
    rlim([0 1])
    hold on;
    polarplot(theta,EMGste_plus(b,:),'k--','LineWidth',1)
    polarplot(theta,EMGste_minus(b,:),'k--','LineWidth',1)
    title(binnedData.emgguide(1,b));
end

end


