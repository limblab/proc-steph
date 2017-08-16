function [T2Tfirst_ByTarget, T2Tfirst, TargetNumber]=T2Tfirst(binnedData)

% This is Time to first target acquisition. Obviously for the successful
% targets only

trialtable=binnedData.trialtable;
badTrials = find(trialtable(:,7)==-1); trialtable(badTrials,:)=[];
successfulTrials=find(trialtable(:,9)==82);
trialtable=trialtable(successfulTrials,:);
tt=trialtable;
moreBadTrials=find(trialtable(:,3)>0 & trialtable(:,3)<0.0001);
tt(moreBadTrials,:)=[];
TargetNumber=tt(:,10);


for a = 1:length(tt(:,1)) % Loop through all trials
    
    GoCue=[]; TrialEnd = [];
    TrajX=[]; TrajY=[];
    LLx=[];LLy=[];
    % Find go cue for each trial
    GoCue = tt(a,7);
    TrialEnd = tt(a,8);
    
    % Get target side size
    sideX = tt(a,4)-tt(a,2);
    sideY = tt(a,3)-tt(a,5);
    % Get lower left target coordinates
    LLx = tt(a,2); LLy = tt(a,5);
    % Look through the time stamps for a single trial
    trajIndices=[];
    trajIndices = find(binnedData.timeframe>=GoCue & binnedData.timeframe<=TrialEnd);
    TrajX=binnedData.cursorposbin(trajIndices,1);
    TrajY=binnedData.cursorposbin(trajIndices,2);
    
    
    % Find when cursor is in the target
    TargetContact = TrajX <= (LLx+sideX) & TrajX >= LLx & TrajY <= (LLy+sideY) & TrajY >= LLy;
    %if isempty(TimeIndexForTargetEntry)
    %    FirstTargetEntry(a) = nan; LastTargetEntry(a) = nan; DialInTime(ia) = nan;
    %    T2Tfirst(a) = nan; T2Tlast(a) = nan;
    %else
    FirstTargetEntryBin = find(TargetContact==1,1);
    T2Tfirst(a,1)=0.05*FirstTargetEntryBin;
    
end

T2Tfirst_ByTarget=SeparateOutByTarget(T2Tfirst,TargetNumber);

end

