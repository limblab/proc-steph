function [Tp,MeanFiringRates]=PlotIsHeTrying_PerTarget_PerTrial(binnedData,plotStyle)

% Isolate trialtable into its own variable
tt=binnedData.trialtable;
badTrials = find(tt(:,7)==-1); tt(badTrials,:)=[];

EpochLength = 1;


% Loop through trials
for a=1:length(tt)
    % Find go cue for each trial
    GoCue = tt(a,7);
    % Set epoch end to be X ms after go cue
    EpochEnd = GoCue+EpochLength;
    % Find index
    EpochIndex = find(binnedData.timeframe>=GoCue & binnedData.timeframe<=EpochEnd);
    % Calculate mean FR across neurons for the epoch
    binnedRates = binnedData.spikeratedata(EpochIndex,:);
    spikesPerBin=binnedRates*.05;
    FiringRatesForEpoch = sum(spikesPerBin,1)/(length(spikesPerBin(:,1))*.05);
    MeanFiringRates(a,1)=mean(FiringRatesForEpoch);
    MeanFiringRates(a,2)=tt(a,10);
    
end

IsHeTryingPerTarget=SeparateOutByTarget(MeanFiringRates(:,1),MeanFiringRates(:,2));

%Stats
numSamples=10;
for TgtInd=1:8
Tp(TgtInd)=signrank(IsHeTryingPerTarget{1,TgtInd}(1:numSamples),IsHeTryingPerTarget{1,TgtInd}(end-numSamples+1:end));
end
Tp=Tp./2;

% Plot per target
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
%figure
for Tgt=1:8
    location= subplotLocations(Tgt);
    subplot(5,5,location); hold on
        plot(IsHeTryingPerTarget{1,Tgt},plotStyle,'Color',colors(Tgt,:),'MarkerSize',4)
    title(strcat(['Target ', num2str(Tgt)]))
    MillerFigure; hold on;
    ylim([0 30]);xlim([0 30])
    set(gca,'Ytick',0:5:30)
end
MillerFigure



end

