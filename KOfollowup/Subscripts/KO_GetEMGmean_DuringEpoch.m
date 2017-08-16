function [FRandTheta] = KO_GetEMGmean_DuringEpoch(binnedData,ms_after_gocue)

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
        GoCue = trialtable(NewInd,7);
        EpochStart = GoCue+(ms_after_gocue/1000)+0.05; %add 50ms for offset between neurons and muscles
        EpochEnd = EpochStart+0.3;
        % Round to the nearest 0.05
        EpochStart = round(EpochStart/0.05)*0.05;
        EpochEnd = round(EpochEnd/0.05)*0.05;
        
        % Get rough indices for the hold period
        EpochStartInd = find(binnedData.timeframe==EpochStart);
        EpochEndInd = find(binnedData.timeframe==EpochEnd);
        
        
        % FR = firing rate
        FRandTheta(TrialInd,1,EMGNumber)= mean(binnedData.emgdatabin(EpochStartInd:EpochEndInd,EMGNumber));
        FRandTheta(TrialInd,2,EMGNumber) = thetavals(trialtable(NewInd,10));
        
        
    end
end

end