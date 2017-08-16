%Weber_PETH
% Raster from target onset to end of trial

% Get successful trials
tt=binnedData.trialtable;
failedtrials=find(tt(:,9)~=82);
tt(failedtrials,:)=[];
% isolate only the trials for the farther extensiontarget
FarExtension=find(tt(:,2)==-12);
tt=tt(FarExtension,:);

% Loop through successful trials
for neuronInd=1%:length(binnedData.spikeratedata(1,:)
    spikes=[];force=[];
for ind=1:length(tt)
   % TrialEnd=tt(ind,8);
    TargetOn = tt(ind,6);
    EpochEnd=TargetOn+1.5;
    
    epochTimes= find(binnedData.timeframe(:,neuronInd)>=TargetOn & binnedData.timeframe(:,neuronInd)<=EpochEnd);
    spikeTemp=binnedData.spikeratedata(epochTimes)';
    spikes=cat(1,spikes,spikeTemp);
    
    forceTemp=binnedData.cursorposbin(epochTimes,1)';
    force=cat(1,force,forceTemp);
    
end
end

        
        figure;
        subplot(3,1,1)
        neuronsubset=spikes;
        normSpikes = spikes./(max(max(spikes)));
        imagesc(normSpikes);
        
        ylabel('Spikes')
        subplot(3,1,2)
        plot(mean(force))
        
        ylabel('Force')
        
        subplot(3,1,3)
        
        ylabel('EMG')
        
    
    