function [TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories_UsingPredictions(binnedData,cursorpreds,EpochLength)

% Isolate trialtable into its own variable
tt=binnedData.trialtable;
badTrials = find(tt(:,7)==-1); tt(badTrials,:)=[];

% Add junk to first 13 vals of cursorpreds
%cursorpreds=cat(1,nan(13,2),cursorpreds);

% Set the length of the initial trajectory epoch
%EpochLength = .8; %X00ms
EpochNumBins = int8(EpochLength/0.05); % Number of values/epoch

% Initialize initalTrajectories varaibles
TrajectoriesX = nan(length(tt),EpochNumBins);
TrajectoriesY = nan(length(tt),EpochNumBins);
for a=1:length(tt)
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
    TrajectoriesX(a,1:EpochNumBins)=cursorpreds(trajIndices,1);
    TrajectoriesY(a,1:EpochNumBins)=cursorpreds(trajIndices,2);
 end

   
    % Save target number
    TargetNumber = tt(:,10);
    
end


