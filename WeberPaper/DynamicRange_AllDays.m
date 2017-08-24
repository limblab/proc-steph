function DynamicRange_AllDays(monkeyname)

if strcmp(monkeyname, 'Jango')
    HybridEMGlist=Jango_HybridData_EMGQualityInfo();
    BaseFolder = 'C:\Users\LimbLabSteph\Dropbox\HybridData\';
    FileName = {'JangoGDdata4_072414','JangoGDdata4_072514', 'JangoGDdata4_081914', 'JangoGDdata4_082014',...
       'JangoGDdata4_082114', 'JangoGDdata4_092314','JangoGDdata4_101014','JangoGDdata4_101114','JangoGDdata4_101214'};
end


if strcmp(monkeyname, 'Kevin')
    HybridEMGlist=Kevin_HybridData_EMGQualityInfo();
    BaseFolder = 'C:\Users\LimbLabSteph\Dropbox\HybridData\';
    FileName = {'KevinGDdata4_051915','KevinGDdata4_052115', 'KevinGDdata4_052515', 'KevinGDdata4_052615',...
        'KevinGDdata4_060415'};
end


for z = 1:length(FileName)
    cd([BaseFolder])
    load(strcat(BaseFolder, FileName{z}(1:end)))

%DynamicRangeWrapper
binnedData=SprBinned;
DynamicRanges_FR

EMG_Extension(z,:) = [Target1Means Target2Means Target3Means CenterMean(ECRind)];
EMG_Flexion(z,:) = [CenterMean(FlexorInd) Target4Means Target5Means Target6Means CenterMean(ECRind)];

Neuron_Extension(z,:) = [Target1CortexMeans Target2CortexMeans Target3CortexMeans CenterCortexMean_Ext];
Neuron_Flexion(z,:) = [CenterCortexMean_Flex Target4CortexMeans Target5CortexMeans Target6CortexMeans];

All_ExtRangeEMG0(z,1) = ExtRangeEMG0;
All_ExtRangeEMG1(z,1) = ExtRangeEMG1;
All_ExtRangeEMG2(z,1) = ExtRangeEMG2;

All_ExtRangeCortex0(z,1) = ExtRangeCortex0;
All_ExtRangeCortex1(z,1) = ExtRangeCortex1;
All_ExtRangeCortex2(z,1) = ExtRangeCortex2;

All_FlexRangeEMG0(z,1) = FlexRangeEMG0;
All_FlexRangeEMG1(z,1) = FlexRangeEMG1;
All_FlexRangeEMG2(z,1) = FlexRangeEMG2;

All_FlexRangeCortex0(z,1) = FlexRangeCortex0;
All_FlexRangeCortex1(z,1) = FlexRangeCortex1;
All_FlexRangeCortex2(z,1) = FlexRangeCortex2;



clearvars -except monkeyname BaseFolder FileName EMG_Extension EMG_Flexion Neuron_Extension Neuron_Flexion ...
    All_ExtRangeEMG1 All_ExtRangeEMG2 All_ExtRangeCortex1 All_ExtRangeCortex2 All_FlexRangeEMG1 All_FlexRangeEMG2 ...
    All_FlexRangeCortex1 All_FlexRangeCortex2 All_FlexRangeCortex0 All_FlexRangeEMG0 All_ExtRangeCortex0 All_ExtRangeEMG0...

end

EMG_Extension_overallmean = mean(EMG_Extension);
EMG_Flexion_overallmean = mean(EMG_Flexion);
EMG_Extension_std = std(EMG_Extension);
EMG_Flexion_std = std(EMG_Flexion);

Neuron_Extension_overallmean = mean(Neuron_Extension);
Neuron_Flexion_overallmean = mean(Neuron_Flexion);
Neuron_Extension_std = std(Neuron_Extension);
Neuron_Flexion_std = std(Neuron_Flexion);


figure;
subplot(1,2,1)
hold on
plot(1:3, EMG_Extension_overallmean(1:3),'.m','MarkerSize', 20)
plot(1:3, Neuron_Extension_overallmean(1:3),'xm','MarkerSize', 10, 'LineWidth', 1.5)
plot(4, EMG_Extension_overallmean(4),'.k','MarkerSize',20)
plot(4, Neuron_Extension_overallmean(4),'xk','MarkerSize', 10, 'LineWidth', 1.5)
MillerFigure
xlim([-.5 4.5])
ylim([0 3])

subplot(1,2,2)
hold on
plot([2:4], EMG_Flexion_overallmean(2:4),'.b','MarkerSize', 20)
plot([2:4], Neuron_Flexion_overallmean(2:4),'xb','MarkerSize', 10, 'LineWidth', 1.5)
plot(1, EMG_Flexion_overallmean(1),'.k','MarkerSize',20)
plot(1, Neuron_Flexion_overallmean(1),'xk','MarkerSize', 10, 'LineWidth', 1.5)
MillerFigure
xlim([-.5 4.5])
ylim([0 3])
suptitle('Summary')

meanExtRangeEMG0=mean(All_ExtRangeEMG0);
meanExtRangeEMG1=mean(All_ExtRangeEMG1);
meanExtRangeEMG2 = mean(All_ExtRangeEMG2);

meanExtRangeCortex0 = mean(All_ExtRangeCortex0);
meanExtRangeCortex1 = mean(All_ExtRangeCortex1);
meanExtRangeCortex2 = mean(All_ExtRangeCortex2);

meanFlexRangeEMG0 = mean(All_FlexRangeEMG0);
meanFlexRangeEMG1 = mean(All_FlexRangeEMG1);
meanFlexRangeEMG2 = mean(All_FlexRangeEMG2);

meanFlexRangeCortex0 = mean(All_FlexRangeCortex0);
meanFlexRangeCortex1 = mean(All_FlexRangeCortex1);
meanFlexRangeCortex2 = mean(All_FlexRangeCortex2);

figure
subplot(1,2,1); hold on
plot(1,meanExtRangeCortex1+1,'xm','LineWidth', 2,'MarkerSize',8)
plot(2,1,'xm','LineWidth', 2,'MarkerSize',8)
plot(3,meanExtRangeCortex2+1,'xm','LineWidth', 2,'MarkerSize',8)
plot(4,meanExtRangeCortex0+1,'xk','LineWidth', 2,'MarkerSize',8)

plot(1,meanExtRangeEMG1+1,'.m','MarkerSize',20)
plot(2,1,'.m','MarkerSize',20)
plot(3,meanExtRangeEMG2+1,'.m','MarkerSize',20)
plot(4,meanExtRangeEMG0+1,'.k','MarkerSize',20)
MillerFigure
xlim([.5 4.5]); ylim([0 2]); set(gca,'Xticklabel',[])
xlabel('Extension')

subplot(1,2,2); hold on
plot(2,meanFlexRangeCortex1+1,'xb','LineWidth', 2,'MarkerSize',8)
plot(3,1,'xb','LineWidth', 2,'MarkerSize',8)
plot(4,meanFlexRangeCortex2+1,'xb','LineWidth', 2,'MarkerSize',8)
plot(1,meanFlexRangeCortex0+1,'xk','LineWidth', 2,'MarkerSize',8)

plot(2,meanFlexRangeEMG1+1,'.b','MarkerSize',20)
plot(3,1,'.b','MarkerSize',20)
plot(4,meanFlexRangeEMG2+1,'.b','MarkerSize',20)
plot(1,meanFlexRangeEMG0+1,'.k','MarkerSize',20)
MillerFigure
xlim([.5 4.5]); ylim([0 2]); set(gca,'Xticklabel',[])
xlabel('Flexion')
suptitle('Percent change Summary')






