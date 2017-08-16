function WeightedHybridH_round2 = computeWeightedHybrid(binnedData)


% Make the input (spikes matrix)
spikes=binnedData.spikeratedata;
N=[];
%For one neuron
for neuronInd=1:length(spikes(1,:))
    oneN=[];
    for rows=1:length(spikes)-10
        for col=1:10
            oneN(rows,col)=spikes(rows+10-col,neuronInd);
        end
    end
    N=cat(2,N,oneN);
end

for EMGind=1:length(binnedData.emgdatabin(1,:))   
    % Make output matrix M
    M=binnedData.emgdatabin(11:end,EMGind);

    WeightedHybridH (:,EMGind)=inv(transpose(N)*N)*transpose(N)*M;
    
 
end