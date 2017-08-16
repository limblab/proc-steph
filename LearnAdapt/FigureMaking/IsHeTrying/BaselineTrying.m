function [MeanPerTarget, StdPerTarget]=BaselineTrying(binnedData)


% Isolate trialtable into its own variable
tt=binnedData.trialtable;
badTrials = find(tt(:,7)==-1); tt(badTrials,:)=[];

% Loop through trials
for a=1:length(tt)
    % Find go cue for each trial
    EpochStart = tt(a,7)-0.2; % go cue minus 200 ms (the shortest hold)
    % Set epoch end to be X ms after go cue
    EpochEnd = tt(a,7); % the go cue
    % Find index
    EpochIndex = find(binnedData.timeframe>=EpochStart & binnedData.timeframe<=EpochEnd);
    % Calculate mean FR across neurons for the epoch
    binnedRates = binnedData.spikeratedata(EpochIndex,:);
    spikesPerBin=binnedRates*.05;
    FiringRatesForEpoch = sum(spikesPerBin,1)/(length(spikesPerBin(:,1))*.05);
    MeanFiringRates(a,1)=mean(FiringRatesForEpoch);
    MeanFiringRates(a,2)=tt(a,10);
    
end

for b=1:8 %num of targets
    TargetIndex = find(MeanFiringRates(:,2)==b);
    MeanPerTarget(b,1) = mean(MeanFiringRates(TargetIndex,1));
    StdPerTarget(b,1) = std(MeanFiringRates(TargetIndex,1));
end
