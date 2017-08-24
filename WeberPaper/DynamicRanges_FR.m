% DynamicRanges_FR
% Look at mean EMG during center and target hold

tt=binnedData.trialtable;
failedtrials=find(tt(:,9)~=82);
tt(failedtrials,:)=[];
neg1indices = find(tt(:,6)==-1);
tt(neg1indices,:)=[];

% Fix trial table numbers
for i=1:length(tt)
    switch tt(i,2)
        case -12
            tt(i,10)=1;
        case -10
            tt(i,10)=2;
        case -8
            tt(i,10)=3;
        case 6
            tt(i,10)=4;
        case 8
            tt(i,10)=5;
        case 10
            tt(i,10)=6;
    end
end

% Neuron normalization (per neuron)
maxes = mean(binnedData.spikeratedata);
%maxes=quantile(binnedData.spikeratedata,.98);
repMaxes=repmat(maxes,length(binnedData.spikeratedata(:,1)),1);
binnedData.spikeratedata = binnedData.spikeratedata./repMaxes;
    

% Find the top neurons for large flexion and large extension---------------

% First loop through and get the firing rates for all neurons for all
% trials
for ind=1:length(tt)
    TrialEnd=tt(ind,8);
    TargetAcquire=TrialEnd-0.5; % Go back and confirm what the target hold time was
    TargetNumber(ind)=tt(ind,10);
    CenterStart=tt(ind,6)-0.5;
    CenterEnd=tt(ind,6); 
    
    CenterHoldTime=find(binnedData.timeframe>=CenterStart & binnedData.timeframe<=CenterEnd);
    TargetHoldTime=find(binnedData.timeframe>=TargetAcquire & binnedData.timeframe<=TrialEnd);

    neuronTargetFRperbin = binnedData.spikeratedata(TargetHoldTime,:);
    neuronTargetUnravel = neuronTargetFRperbin*0.05; 
    neuronTargetTotalFR(ind,:) = sum(neuronTargetUnravel)/((length(neuronTargetUnravel(:,1))*.05));
    meanTargetNeuralFR(ind) = mean(neuronTargetTotalFR(ind,:));
       
end

% Large extension
Target1Ind=find(TargetNumber==1);
Target1FRperneuron=neuronTargetTotalFR(Target1Ind,:);
Target1MeanFRperneuronAcrossTrials=mean(Target1FRperneuron);
[sortedT1 sortedIndsT1] = sort(Target1MeanFRperneuronAcrossTrials,'descend');
%ExtensionMaxNeurons_Inds=[1:length(binnedData.spikeratedata(1,:))]; all
%the neurons
ExtensionMaxNeurons_Inds=sortedIndsT1(1:10);

% Large flexion
Target6Ind=find(TargetNumber==6);
Target6FRperneuron=neuronTargetTotalFR(Target6Ind,:);
Target6MeanFRperneuronAcrossTrials=mean(Target6FRperneuron);
[sortedT6 sortedIndsT6] = sort(Target6MeanFRperneuronAcrossTrials,'descend');
%FlexionMaxNeurons_Inds=[1:length(binnedData.spikeratedata(1,:))] all the neurons
FlexionMaxNeurons_Inds=sortedIndsT6(1:10);

% Clear a few variables as a precaution
neuronTargetFRperbin=[]; neuronTargetUnravel=[];
neuronTargetTotalFR=[]; meanTargetNeuralFR=[];

% -------------------------------------------------------------------------

% Loop through successful trials
meanCenterHold=nan(length(tt), length(binnedData.emgdatabin(1,:)));
meanTargetHold=nan(length(tt), length(binnedData.emgdatabin(1,:)));
meanCenterNeuralFR = nan(length(tt),1);
for ind=1:length(tt)
    TrialEnd=tt(ind,8);
    TargetAcquire=TrialEnd-0.5; % Go back and confirm what the target hold time was
    TargetNumber(ind)=tt(ind,10);
    CenterStart=tt(ind,6)-0.5;
    CenterEnd=tt(ind,6); 
    
    CenterHoldTime=find(binnedData.timeframe>=CenterStart & binnedData.timeframe<=CenterEnd);
    TargetHoldTime=find(binnedData.timeframe>=TargetAcquire & binnedData.timeframe<=TrialEnd);
    
    for emgInd=1:length(binnedData.emgdatabin(1,:))
        emgCenterHoldData=binnedData.emgdatabin(CenterHoldTime,emgInd);
        emgTargetHoldData=binnedData.emgdatabin(TargetHoldTime,emgInd);
        meanCenterHold(ind,emgInd)=mean(emgCenterHoldData);
        meanTargetHold(ind,emgInd)=mean(emgTargetHoldData);
    end
    
    % Neuron FR for extension neurons
    neuronCenterFRperbin_Ext = binnedData.spikeratedata(CenterHoldTime,ExtensionMaxNeurons_Inds);
    neuronCenterUnravel_Ext = neuronCenterFRperbin_Ext*0.05;
    neuronCenterTotalFR_Ext= sum(neuronCenterUnravel_Ext)/((length(neuronCenterUnravel_Ext(:,1))*.05));
    meanCenterNeuralFR_Ext(ind) = mean(neuronCenterTotalFR_Ext);
    
    neuronTargetFRperbin_Ext = binnedData.spikeratedata(TargetHoldTime,ExtensionMaxNeurons_Inds);
    neuronTargetUnravel_Ext = neuronTargetFRperbin_Ext*0.05;
    neuronTargetTotalFR_Ext = sum(neuronTargetUnravel_Ext)/((length(neuronTargetUnravel_Ext(:,1))*.05));
    meanTargetNeuralFR_Ext(ind) = mean(neuronTargetTotalFR_Ext);
    
     % Neuron FR for flexion neurons
    neuronCenterFRperbin_Flex = binnedData.spikeratedata(CenterHoldTime,FlexionMaxNeurons_Inds);
    neuronCenterUnravel_Flex = neuronCenterFRperbin_Flex*0.05;
    neuronCenterTotalFR_Flex= sum(neuronCenterUnravel_Flex)/((length(neuronCenterUnravel_Flex(:,1))*.05));
    meanCenterNeuralFR_Flex(ind) = mean(neuronCenterTotalFR_Flex);
    
    neuronTargetFRperbin_Flex = binnedData.spikeratedata(TargetHoldTime,FlexionMaxNeurons_Inds);
    neuronTargetUnravel_Flex = neuronTargetFRperbin_Flex*0.05;
    neuronTargetTotalFR_Flex = sum(neuronTargetUnravel_Flex)/((length(neuronTargetUnravel_Flex(:,1))*.05));
    meanTargetNeuralFR_Flex(ind) = mean(neuronTargetTotalFR_Flex);
    
end


% Extension targets for ECR
for  emgInd2=1:length(binnedData.emgdatabin(1,:))
    if strcmp(binnedData.emgguide{emgInd2}(1:3),'ECR')
        ECRind=emgInd2;
    end
     if strcmp(monkeyname,'Jango') & strcmp(binnedData.emgguide{emgInd2}(1:3),'FCU')
        FCUind=emgInd2;
     end
     if strcmp(monkeyname,'Kevin') & strcmp(binnedData.emgguide{emgInd2}(1:3),'FCR')
        FCRind=emgInd2;
    end
end
Target1Ind=find(TargetNumber==1);
Target1Means=mean(meanTargetHold(Target1Ind,ECRind));
Target1CortexMeans=mean(meanTargetNeuralFR_Ext(Target1Ind));
Target2Ind=find(TargetNumber==2);
Target2Means=mean(meanTargetHold(Target2Ind,ECRind));
Target2CortexMeans=mean(meanTargetNeuralFR_Ext(Target2Ind));
Target3Ind=find(TargetNumber==3);
Target3Means=mean(meanTargetHold(Target3Ind,ECRind));
Target3CortexMeans=mean(meanTargetNeuralFR_Ext(Target3Ind));



% Flexion targets for FCU
if monkeyname=='Jango'
    FlexorInd = FCUind;
else if monkeyname=='Kevin'
        FlexorInd=FCRind;
    end
end

Target4Ind=find(TargetNumber==4);
Target4Means=mean(meanTargetHold(Target4Ind,FlexorInd));
Target4CortexMeans=mean(meanTargetNeuralFR_Flex(Target4Ind));
Target5Ind=find(TargetNumber==5);
Target5Means=mean(meanTargetHold(Target5Ind,FlexorInd));
Target5CortexMeans=mean(meanTargetNeuralFR_Flex(Target5Ind));
Target6Ind=find(TargetNumber==6);
Target6Means=mean(meanTargetHold(Target6Ind,FlexorInd));
Target6CortexMeans=mean(meanTargetNeuralFR_Flex(Target6Ind));

CenterMean = mean(meanCenterHold);
CenterCortexMean_Ext = mean(meanCenterNeuralFR_Ext);
CenterCortexMean_Flex = mean(meanCenterNeuralFR_Flex);

%---------------------------
figure; hold on
subplot(1,2,1); hold on
plot(1,Target1Means,'.m','MarkerSize',20)
plot(1,Target1CortexMeans,'+m','MarkerSize',10,'LineWidth',1.5)
plot(2,Target2Means,'.m','MarkerSize',20)
plot(2,Target2CortexMeans,'+m','MarkerSize',10,'LineWidth',1.5)
plot(3,Target3Means,'.m','MarkerSize',20)
plot(3,Target3CortexMeans,'+m','MarkerSize',10,'LineWidth',1.5)
plot(4, CenterMean(FlexorInd),'.k','MarkerSize',20)
plot(4,CenterCortexMean_Ext,'+k','MarkerSize',10,'LineWidth',1.5)
ylim([0 3])
xlim([-.5 4.5])
title('Extension')

subplot(1,2,2); hold on
plot(1,Target4Means,'.b','MarkerSize',20)
plot(1,Target4CortexMeans,'+b','MarkerSize',10,'LineWidth',1.5)
plot(2,Target5Means,'.b','MarkerSize',20)
plot(2,Target5CortexMeans,'+b','MarkerSize',10,'LineWidth',1.5)
plot(3,Target6Means,'.b','MarkerSize',20)
plot(3,Target6CortexMeans,'+b','MarkerSize',10,'LineWidth',1.5)
plot(0, CenterMean(ECRind),'.k','MarkerSize',20)
plot(0,CenterCortexMean_Flex,'+k','MarkerSize',10,'LineWidth',1.5)
ylim([0 3])
xlim([-.5 4.5])
title('Flexion')


%%
% Percent change
ExtRangeCortex0=((CenterCortexMean_Ext-Target2CortexMeans)/Target2CortexMeans);
ExtRangeCortex1=((Target1CortexMeans-Target2CortexMeans)/Target2CortexMeans);
ExtRangeCortex2=((Target3CortexMeans-Target2CortexMeans)/Target2CortexMeans);

FlexRangeCortex0=((CenterCortexMean_Flex-Target5CortexMeans)/Target5CortexMeans);
FlexRangeCortex1=((Target4CortexMeans-Target5CortexMeans)/Target5CortexMeans);
FlexRangeCortex2=((Target6CortexMeans-Target5CortexMeans)/Target5CortexMeans);

ExtRangeEMG0 = ((CenterMean(ECRind)-Target2Means)/Target2Means);
ExtRangeEMG1=((Target1Means-Target2Means)/Target2Means);
ExtRangeEMG2=((Target3Means-Target2Means)/Target2Means);

FlexRangeEMG0=((CenterMean(FlexorInd)-Target5Means)/Target5Means);
FlexRangeEMG1=((Target4Means-Target5Means)/Target5Means);
FlexRangeEMG2=((Target6Means-Target5Means)/Target5Means);

figure
subplot(1,2,1); hold on
plot(1,ExtRangeCortex1,'xm','LineWidth', 2,'MarkerSize',8)
plot(2,ExtRangeCortex2,'xm','LineWidth', 2,'MarkerSize',8)
plot(1,ExtRangeEMG1,'.m','MarkerSize',20)
plot(2,ExtRangeEMG2,'.m','MarkerSize',20)
MillerFigure
xlim([0 3]); ylim([0 1])

subplot(1,2,2); hold on
plot(1,FlexRangeCortex1,'xb','LineWidth', 2,'MarkerSize',8)
plot(2,FlexRangeCortex2,'xb','LineWidth', 2,'MarkerSize',8)
plot(1,FlexRangeEMG1,'.b','MarkerSize',20)
plot(2,FlexRangeEMG2,'.b','MarkerSize',20)
MillerFigure
xlim([0 3]); ylim([0 1])
suptitle('Percent change')
















