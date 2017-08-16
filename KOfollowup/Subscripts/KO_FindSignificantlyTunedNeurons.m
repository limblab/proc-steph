function SignificantlyTunedNeuronIndices = KO_FindSignificantlyTunedNeurons(out_struct);

[meanFRandTheta] = KO_GetNeuralActivity_DuringHold_MeanAcrossTrials(out_struct);
[~,~,Pvalue]=PDcalculation(meanFRandTheta);
SignificantlyTunedNeuronIndices = find(Pvalue <= 0.02);

end