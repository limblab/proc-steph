function [FRandTheta] = KO_GetNeuralActivity_DuringHold(out_struct,boot)

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
        HoldEnd = trialtable(NewInd,8)-transDelay;
        HoldStart = HoldEnd-0.1; % using 0.3 out of the assumed 0.5s length hold period
        
        % FR = firing rate
        FRandTheta(NewInd,1,NeuronNumber) = length(find(out_struct.units(NeuronNumber).ts>=HoldStart & out_struct.units(NeuronNumber).ts<=HoldEnd))/0.3;
        FRandTheta(NewInd,2,NeuronNumber) = thetavals(trialtable(NewInd,10));
    end
end