function badSpikeInds=findLowFiringNeurons(binnedData)

% this function identifies the index of the neurons that have firing rates
% of <0.05 spike per second for the whole file

spikeCounts=binnedData.spikeratedata*.05;
aveFRs= sum(spikeCounts)/binnedData.timeframe(end);
badSpikeInds=find(aveFRs<0.05);
