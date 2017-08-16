
%ApplyNormalDecoderToDifferentPerturbationTrials



for trial=1:length(binnedRotatedBC)

    NormDecoder_PertBrain_Pos=[];
% Apply Normal decoder to data from each trial
 [~, NormDecoder_PertBrain_Pos] = ApplyCascadeDecoders(binnedPerturbation, N2E, E2F_normal);
 % Compare actual and predicted force using VAF

 
 
 
 
 
 
end