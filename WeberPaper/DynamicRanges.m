% DynamicRanges
% Look at mean EMG during center and target hold

monkeyname='Jango';

tt=binnedData.trialtable;
failedtrials=find(tt(:,9)~=82);
tt(failedtrials,:)=[];

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

% Loop through successful trials
meanCenterHold=nan(length(tt), length(binnedData.emgdatabin(1,:)));
meanTargetHold=nan(length(tt), length(binnedData.emgdatabin(1,:)));
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
Target2Ind=find(TargetNumber==2);
Target2Means=mean(meanTargetHold(Target2Ind,ECRind));
Target3Ind=find(TargetNumber==3);
Target3Means=mean(meanTargetHold(Target3Ind,ECRind));

% Flexion targets for FCU
if monkeyname=='Jango'
    FlexorInd = FCUind;
else if monkeyname=='Kevin'
        FlexorInd=FCRind;
    end
end

Target4Ind=find(TargetNumber==4);
Target4Means=mean(meanTargetHold(Target4Ind,FlexorInd));
Target5Ind=find(TargetNumber==5);
Target5Means=mean(meanTargetHold(Target5Ind,FlexorInd));
Target6Ind=find(TargetNumber==6);
Target6Means=mean(meanTargetHold(Target6Ind,FlexorInd));

CenterMean = mean(meanCenterHold);


%---------------------------
figure; hold on
subplot(1,2,1); hold on
plot(1,Target1Means,'.m','MarkerSize',20)
plot(2,Target2Means,'.m','MarkerSize',20)
plot(3,Target3Means,'.m','MarkerSize',20)
plot(4, CenterMean(FlexorInd),'.k','MarkerSize',20)
ylim([0 1])
xlim([-.1 4.5])
title('Extension')

subplot(1,2,2); hold on
plot(1,Target4Means,'.b','MarkerSize',20)
plot(2,Target5Means,'.b','MarkerSize',20)
plot(3,Target6Means,'.b','MarkerSize',20)
plot(0, CenterMean(ECRind),'.k','MarkerSize',20)
ylim([0 1])
xlim([-.5 4.5])
title('Flexion')


%--------------------------------------------------------------------------
subplot(1,2,1); hold on
plot(1,Target1Means,'+m','MarkerSize',10)
plot(2,Target2Means,'+m','MarkerSize',10)
plot(3,Target3Means,'+m','MarkerSize',10)
plot(4, CenterMean(FlexorInd),'+k','MarkerSize',10)
ylim([0 1])
ylim([0 1])
xlim([-.1 4.5])
title('Extension')

subplot(1,2,2); hold on
plot(1,Target4Means,'+b','MarkerSize',10)
plot(2,Target5Means,'+b','MarkerSize',10)
plot(3,Target6Means,'+b','MarkerSize',10)
plot(0, CenterMean(ECRind),'+k','MarkerSize',10)
ylim([0 1])
xlim([-.5 4.5])
title('Flexion')
MillerFigure





