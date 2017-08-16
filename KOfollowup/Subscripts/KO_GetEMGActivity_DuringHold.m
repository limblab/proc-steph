function [FRandTheta] = KO_GetEMGActivity_DuringHold(binnedData)

% Note: should account for transmission delay between neurons and muscles. 
transDelay = 0.1; %seconds

% Only use successful trials
trialtable=binnedData.trialtable(binnedData.trialtable(:,9)==82,:);

binnedData.timeframe=round(binnedData.timeframe/.05)*.05;

thetavals = -pi:pi/4:pi-pi/4;
TrialNumbers = (1:length(trialtable))';

FRandTheta = nan(length(TrialNumbers),2,length(binnedData.emgdatabin(1,:)));
for EMGNumber = 1:length(binnedData.emgdatabin(1,:))
    for TrialInd = 1:length(trialtable)
        NewInd = TrialNumbers(TrialInd);
        holdEnd = trialtable(NewInd,8)-transDelay;
        holdStart = trialtable(NewInd,8)-transDelay-0.3; %only looking at 300ms
        % Round to the nearest 0.05
        holdStart = round(holdStart/0.05)*0.05;
        holdEnd = round(holdEnd/0.05)*0.05;
        
        % Get rough indices for the hold period
        holdStartInd = find(binnedData.timeframe==holdStart);
        holdEndInd = find(binnedData.timeframe==holdEnd);
        
        
        % FR = firing rate
        FRandTheta(TrialInd,1,EMGNumber)= mean(binnedData.emgdatabin(holdStartInd:holdEndInd,EMGNumber));
        FRandTheta(TrialInd,2,EMGNumber) = thetavals(trialtable(NewInd,10));
        
    end
end

end