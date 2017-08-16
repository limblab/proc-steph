% KO_Plot_VAF_comparison_barplots_Kevin
% Barplot will show VAF ratios (across/within) for all 4 muscles (FCR, FCU,
% ECR, ECU) for isometric and movement tasks side by side

% Load AcrossDayData
%load('C:\Stephanie\Data\KOfollowup\Jango\AcrossDayData.mat')

% Check that EMG names are the same across days
%for a=1:length(AcrossDays.EMGnames(:,1))

% Define EMGs of interest
% WristNames = {'FCU','FCR','ECU','ECRb','ECRl'};
% % -------------------------------------------------------------------------
% 
% [IMonIM_mean, IMonIMste]=FindMeanAndSTE(AcrossDays.IMonIM_EMGvafsPerFold);
% [IMonIP_mean, IMonIPste]=FindMeanAndSTE(AcrossDays.IMonIP_EMGvafsPerFold);
% [MMonMM_mean, MMonMMste]=FindMeanAndSTE(AcrossDays.MMonMM_EMGvafsPerFold);
% [MMonMP_mean, MMonMPste]=FindMeanAndSTE(AcrossDays.MMonMP_EMGvafsPerFold);


WristNames = {'FCU','FCR','ECU','ECR'};
[IMonIM_mean, IMonIMste]=FindMeanAndSTE(SingleDayStruct.IMonIM_EMGvafsPerFold);
[IMonIP_mean, IMonIPste]=FindMeanAndSTE(SingleDayStruct.IMonIP_EMGvafsPerFold);
[MMonMM_mean, MMonMMste]=FindMeanAndSTE(SingleDayStruct.MMonMM_EMGvafsPerFold);
[MMonMP_mean, MMonMPste]=FindMeanAndSTE(SingleDayStruct.MMonMP_EMGvafsPerFold);

% Make bar plots
figure
subplot(2,1,1)
hold on
errorbar([.85:3.85],IMonIM_mean, IMonIMste, -IMonIMste,'k.','LineWidth',1.2) 
errorbar([1.15:4.15],IMonIP_mean, IMonIPste, -IMonIPste,'k.','LineWidth',1.2)
bar([IMonIM_mean;IMonIP_mean]'),colormap(winter)
set(gca,'XTick',[1:5])
set(gca,'XTickLabel',WristNames)
ylim([-.5 1])
ylabel('Isometric')
MillerFigure
%---------------
subplot(2,1,2)
hold on;
errorbar([.85:3.85],MMonMM_mean, MMonMMste, -MMonMMste,'k.','LineWidth',1.2) 
errorbar([1.15:4.15],MMonMP_mean, MMonMPste, -MMonMPste,'k.','LineWidth',1.2)
bar([MMonMM_mean;MMonMP_mean]'),colormap(winter)
ylim([-.5 1])
ylabel('Movement')
MillerFigure

