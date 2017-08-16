function WeightedHybridH2 = computeWeightedH2(H2)


% Make the input (spikes matrix)
spikes=H2.spikeratedata;
N=[];
%For one neuron
for neuronInd=1:length(spikes(1,:))
    oneN=[];
    for rows=1:length(spikes)-9
        for col=1:10
            oneN(rows,col)=spikes(rows+10-col,neuronInd);
        end
    end
    N=cat(2,N,oneN);
end

for EMGind=1:length(H2.emgdatabin(1,:))   
    % Make output matrix M
    M=H2.emgdatabin(10:end,EMGind);
    
    % Make weighted matrix for the individual muscle
    W=sparse(23991,23991);
    for rows=1:23991
        for cols = 1:23991
            if rows==cols
                if rows< 11991 && cols< 11991
                    W(rows,cols)=1;
                else if rows>= 11991 && cols>=11991
                        W(rows,cols)=H2.Varscale(EMGind,1); %scaling factor for movement
                    end
                end
            end
        end
    end

    % Will have to compute H separate for all muscles so I can incorporate the
    % inidivual weighting matrix
    WeightedHybridH2(:,EMGind)=inv(transpose(N)*W*N)*transpose(N)*W*M;
    
 
end
  