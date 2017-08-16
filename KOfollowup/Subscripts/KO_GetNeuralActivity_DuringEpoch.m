function [FRandTheta] = KO_GetNeuralActivity_DuringEpoch(out_struct, ms_after_gocue, boot)

%% Note: should account for transmission delay between neurons and muscles. 
transDelay = 0.1; %seconds

% Make trialtable from out_struct
trialtable = wf_trial_table(out_struct);
% Only use successful trials
trialtable=trialtable(trialtable(:,9)==82,:);

thetavals = -pi:pi/4:pi-pi/4;

if boot==1
    TrialNumbers = KO_bootstrap(trialtable);
else
    TrialNumbers = (1:length(trialtable))';
end

for NeuronNumber = 1:length(out_struct.units(1,:))
        for TrialInd = 1:length(trialtable)
            NewInd = TrialNumbers(TrialInd);
            GoCue = trialtable(NewInd,7);
            EpochStart = GoCue+(ms_after_gocue/1000);
            EpochEnd = EpochStart+0.3;
            
            % FR = firing rate
            FRandTheta(NewInd,1,NeuronNumber) = length(find(out_struct.units(NeuronNumber).ts>=EpochStart & out_struct.units(NeuronNumber).ts<=EpochEnd))/0.3;
            FRandTheta(NewInd,2,NeuronNumber) = thetavals(trialtable(NewInd,10));
        end
end