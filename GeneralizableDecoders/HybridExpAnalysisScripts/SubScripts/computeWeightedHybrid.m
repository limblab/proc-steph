function WeightedHybridH = computeWeightedHybrid(Hybrid3)


% Make the input (spikes matrix)
spikes=Hybrid3.spikeratedata;
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

for EMGind=1:length(Hybrid3.emgdatabin(1,:))   
    % Make output matrix M
    M=Hybrid3.emgdatabin(10:end,EMGind);

    % Make weighted matrix for the individual muscle
    W=sparse(35991,35991);
    for rows=1:35991
        for cols = 1:35991
            if rows==cols
                if rows< 11991 && cols< 11991
                    W(rows,cols)=1;
                else if rows>= 11991 && rows<23991 && cols>=11991 && cols<23991
                        W(rows,cols)=Hybrid3.Varscale(EMGind,1); %scaling factor for movement
                    else if rows>=23991 && cols >=23991
                            W(rows,cols)=Hybrid3.Varscale(EMGind,2); %scaling factor for spring
                        end
                    end
                end
            end
        end
    end
    % Will have to compute H separate for all muscles so I can incorporate the
    % inidivual weighting matrix
    WeightedHybridH (:,EMGind)=inv(transpose(N)*W*N)*transpose(N)*W*M;
    
 
end
  