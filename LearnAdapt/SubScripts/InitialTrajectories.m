function [TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedData,EpochLength)

% Isolate trialtable into its own variable
tt=binnedData.trialtable;
badTrials = find(tt(:,7)==-1); tt(badTrials,:)=[];

% Set the length of the initial trajectory epoch
% Epoch length is in seconds
EpochNumBins = int8(EpochLength/0.05); % Number of values/epoch

% Initialize initalTrajectories varaibles
TrajectoriesX = nan(length(tt),EpochNumBins);
TrajectoriesY = nan(length(tt),EpochNumBins);
for a=1:length(tt(:,1))
    GoCue=[]; EpochEnd = [];
    % Find go cue for each trial
    GoCue = tt(a,7);
    % Set epoch end to be X ms after go cue
    EpochEnd = GoCue+EpochLength;
    
    % Get the cursor data (X and Y) for the epoch of interest
    trajIndices=[];
    trajIndices = find(binnedData.timeframe>=GoCue & binnedData.timeframe<=EpochEnd);
    if isempty(trajIndices)
        break
    end
    trajIndices=trajIndices(1:EpochNumBins);
    TrajectoriesX(a,1:EpochNumBins)=binnedData.cursorposbin(trajIndices,1);
    TrajectoriesY(a,1:EpochNumBins)=binnedData.cursorposbin(trajIndices,2);
    
    % Save target number
    TargetNumber = tt(:,10);

end
