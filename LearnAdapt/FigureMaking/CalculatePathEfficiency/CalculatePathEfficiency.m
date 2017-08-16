function [AllPathLengths, TargetNumber, PathEfficiency] = CalculatePathEfficiency(binnedData)

% Initialize colors
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);

tt=binnedData.trialtable;
badTrials = find(tt(:,7)==-1); tt(badTrials,:)=[];
TargetCenters=FindTargetCenter(binnedData);

AllPathLengths=nan(length(tt(:,1)),1);TargetNumber=nan(length(tt(:,1)),1);
for a=1:length(tt(:,1))
     GoCue=[]; EpochEnd = [];
     TrajX=[]; TrajY=[];
     % Find go cue for each trial
     GoCue = tt(a,7);
     % Set epoch end to be X ms after go cue
      EpochEnd = tt(a,8);
      if EpochEnd-GoCue>8
          EpochEnd=GoCue+8;
      end   
      TargetNumber(a)=tt(a,10);
      CurrentTargetCenter=TargetCenters(TargetNumber(a),:);
     
     % Get the cursor data (X and Y) for the epoch of interest
    trajIndices=[];
    trajIndices = find(binnedData.timeframe>=GoCue & binnedData.timeframe<=EpochEnd);
    TrajX=binnedData.cursorposbin(trajIndices,1);
    TrajY=binnedData.cursorposbin(trajIndices,2);
    
    SegmentLength=[];PathLength1trial=0;
    for b=1:length(TrajX)-1
        SegmentLength = pdist([TrajX(b),TrajY(b);TrajX(b+1), TrajY(b+1)],'euclidean');
        PathLength1trial = PathLength1trial+SegmentLength;
    end
    
    % Ideal path length to the target
    % TargetCenter
    IdealLength1trial=pdist([TrajX(1), TrajY(1); CurrentTargetCenter(1), CurrentTargetCenter(2)],'euclidean');
    
    PathEfficiency(a,1)=PathLength1trial/IdealLength1trial; % This can be flipped!
    
    AllPathLengths(a,1)=PathLength1trial;

    
end


