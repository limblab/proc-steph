function [FRandTheta] = KO_GetEMGActivity_DuringEpoch(out_struct, ms_after_gocue)

%% Note: should account for transmission delay between neurons and muscles. 
transDelay = 0.1; %seconds

% Make trialtable from out_struct
trialtable = wf_trial_table(out_struct);
% Only use successful trials
trialtable=trialtable(trialtable(:,9)==82,:);

thetavals = -pi:pi/4:pi-pi/4;
TrialNumbers = (1:length(trialtable))';

FRandTheta = nan(length(TrialNumbers),2,length(out_struct.emg.data(1,:)-1));
for EMGNumber = 1:length(out_struct.emg.data(1,:)-1);
    for TrialInd = 1:length(trialtable)
        NewInd = TrialNumbers(TrialInd);
        GoCue = trialtable(NewInd,7);
        EpochStart = GoCue+(ms_after_gocue/1000)+0.05; %add 50ms for offset between neurons and muscles
        EpochEnd = EpochStart+0.3;
        
        % FR = firing rate
        timeframe=[];
        timeframe= out_struct.emg.data(:,1)>=EpochStart & out_struct.emg.data(:,1)<=EpochEnd;
        FRandTheta(TrialInd,1,EMGNumber)= mean(out_struct.emg.data(timeframe,EMGNumber));
        FRandTheta(TrialInd,2,EMGNumber) = thetavals(trialtable(NewInd,10));
        
    end
end