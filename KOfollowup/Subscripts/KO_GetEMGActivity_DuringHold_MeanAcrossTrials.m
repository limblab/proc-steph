function [meanFRandTheta, EMGmean, EMGste] = KO_GetEMGActivity_DuringHold_MeanAcrossTrials(out_struct)

%% Note: should account for transmission delay between neurons and muscles. 
transDelay = 0.1; %seconds

% Make trialtable from out_struct
trialtable = wf_trial_table(out_struct);
% Only use successful trials
trialtable=trialtable(trialtable(:,9)==82,:);

for NeuronNumber = 1:length(out_struct.emg.data(1,:))-1
    for NumTargets = 1:length(unique(trialtable(:,10)))
        NeuralActivityDuringHoldPerTarget=[];
        TargetTrialIndices = find(trialtable(:,10)==NumTargets);
        for Index=1:length(TargetTrialIndices);
            % Get times for the hold period
            z=TargetTrialIndices(Index);
            holdEnd = trialtable(z,8)-transDelay;
            holdStart = trialtable(z,8)-transDelay-0.5; %assumes 0.5sec hold period
            
            % Get neural firing rate during hold period
            NeuronActivityDuringHoldPerTarget_OneTrial = length(find(out_struct.units(NeuronNumber).ts>=holdStart & out_struct.units(NeuronNumber).ts<=holdEnd))/0.5;
            NeuralActivityDuringHoldPerTarget = cat(1,NeuralActivityDuringHoldPerTarget,NeuronActivityDuringHoldPerTarget_OneTrial);
            NeuronActivityDuringHoldPerTarget_AllTrials(Index,NumTargets,NeuronNumber)=NeuronActivityDuringHoldPerTarget_OneTrial;
            NeuronActivityDuringHoldPerTarget_OneTrial=[];
        end
        [Neuronmean(NeuronNumber,NumTargets), Neuronste(NeuronNumber,NumTargets)] = FindMeanAndSTE(NeuralActivityDuringHoldPerTarget);
        
    end
end


 % Find mean and std of neural activity during hold period
 Neuronmean(:,NumTargets+1) = Neuronmean(:,1);
 Neuronste(:,NumTargets+1) = Neuronste(:,1);
 
 theta= -pi:pi/4:pi-pi/4;
 NeuronmeanTransposed=Neuronmean';
 meanFRandTheta=nan(8,2,length(NeuronmeanTransposed(1,:)));
 for ind=1:length(NeuronmeanTransposed(1,:))
     meanFRandTheta(1:8,1,ind)=NeuronmeanTransposed(1:8,ind);
     meanFRandTheta(1:8,2,ind)=theta;
 end

