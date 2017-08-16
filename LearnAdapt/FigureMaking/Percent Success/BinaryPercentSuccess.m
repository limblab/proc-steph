function [BinarySuccess, BinaryTargets] = BinaryPercentSuccess(binnedData)

% Isolate trialtable into its own variable
tt=binnedData.trialtable;
badTrials = find(tt(:,7)==-1); tt(badTrials,:)=[];

% Save target number
% Find the fails
Fails=find(tt(:,9)==70);
Successes=find(tt(:,9)==82);

% Initialize BinarySuccess
BinarySuccess = nan(length(tt(:,1)),1);
BinarySuccess(Fails,1)=0;
BinarySuccess(Successes,1)=1;
BinaryTargets=tt(:,10);




end
