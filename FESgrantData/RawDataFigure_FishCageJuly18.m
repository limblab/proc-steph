%load('Z:\data\Fish_12H2\BinnedData\InCage\07-18-2016\Fish_WirelessM1andEMGincage_07182016_001.mat')
% This code makes the pretty figure with the raster and corresponding EMGs
% Wireless in the cage while the monkey did the power grasp

LineWidth=1.5;
figure
start=10590;stop=11075;
subplot(6,1,1); MillerFigure;set(gca, 'YTick', []);xlim([0 486])
plot(binnedData.emgdatabin(start:stop,2),'LineWidth',LineWidth);
ylabel(binnedData.emgguide(1,2));set(gca, 'XTickLabel', []);
ylim([0 300]); MillerFigure;set(gca, 'YTick', []);xlim([0 486])
subplot(6,1,2)
plot(binnedData.emgdatabin(start:stop,14),'LineWidth',LineWidth);
ylabel(binnedData.emgguide(1,14));set(gca, 'XTickLabel', []);
ylim([0 300]); MillerFigure;set(gca, 'YTick', []);xlim([0 486])
subplot(6,1,3)
plot(binnedData.emgdatabin(start:stop,1),'LineWidth',LineWidth);
ylabel(binnedData.emgguide(1,1));set(gca, 'XTickLabel', []);
ylim([0 300]); MillerFigure;set(gca, 'YTick', []);xlim([0 486])
subplot(6,1,4)
plot(binnedData.emgdatabin(start:stop,3),'LineWidth',LineWidth);
ylabel(binnedData.emgguide(1,3));set(gca, 'XTickLabel', []);
ylim([0 300]); MillerFigure;set(gca, 'YTick', []);xlim([0 486])
subplot(6,1,5)
plot(binnedData.emgdatabin(start:stop,4),'LineWidth',LineWidth);
ylabel(binnedData.emgguide(1,4));set(gca, 'XTickLabel', []);
ylim([0 300]); MillerFigure;set(gca, 'YTick', []);xlim([0 486])
subplot(6,1,6)
plot(binnedData.emgdatabin(start:stop,6),'LineWidth',LineWidth);
ylabel(binnedData.emgguide(1,6))
ylim([0 300]); MillerFigure;set(gca, 'YTick', []);xlim([0 486])






figure
neuronsubset=binnedData.spikeratedata(start:stop,:)';
 neuronsubset = neuronsubset./260;
imagesc(neuronsubset);
xlim([0 486])



% LineWidth=1.5;
% figure
% start=10000;stop=13075;
% subplot(6,1,1); MillerFigure;set(gca, 'YTick', []);
% plot(out_struct.emg.data(start:stop,3),'LineWidth',LineWidth);
% ylabel(out_struct.emg.emgnames(1,2));set(gca, 'XTickLabel', []);
% MillerFigure;set(gca, 'YTick', []);
% subplot(6,1,2)
% plot(out_struct.emg.data(start:stop,15),'LineWidth',LineWidth);
% ylabel(out_struct.emg.emgnames(1,14));set(gca, 'XTickLabel', []);
% MillerFigure;set(gca, 'YTick', []);
% subplot(6,1,3)
% plot(out_struct.emg.data(start:stop,2),'LineWidth',LineWidth);
% ylabel( out_struct.emg.emgnames(1,1));set(gca, 'XTickLabel', []);
% MillerFigure;set(gca, 'YTick', []);
% subplot(6,1,4)
% plot(out_struct.emg.data(start:stop,4),'LineWidth',LineWidth);
% ylabel(out_struct.emg.emgnames(1,3));set(gca, 'XTickLabel', []);
% MillerFigure;set(gca, 'YTick', []);
% subplot(6,1,5)
% plot(out_struct.emg.data(start:stop,5),'LineWidth',LineWidth);
% ylabel(out_struct.emg.emgnames(1,4));set(gca, 'XTickLabel', []);
% MillerFigure;set(gca, 'YTick', []);
% subplot(6,1,6)
% plot(out_struct.emg.data(start:stop,7),'LineWidth',LineWidth);
% ylabel(out_struct.emg.emgnames(1,6))
% MillerFigure;set(gca, 'YTick', []);



% Show raw data. Load the bdf
% ECU(14) FDR(1) FDP(4)
StartTime = binnedData.timeframe(start); %529.45
StopTime = binnedData.timeframe(stop); % 553.7
bdfStart = 1058902;
bdfStop =  1107401;
figure;
subplot(3,1,1)
plot(out_struct.emg.data(bdfStart:bdfStop,14+1));
ylabel('ECU'); MillerFigure
subplot(3,1,2)
plot(out_struct.emg.data(bdfStart:bdfStop,1+1));
ylabel('FDR'); MillerFigure
subplot(3,1,3)
plot(out_struct.emg.data(bdfStart:bdfStop,4+1));
ylabel('FDP'); MillerFigure

figure;
subplot(3,1,1)
plot(binnedData.emgdatabin(start:stop,14),'LineWidth',LineWidth);
ylabel('ECU');ylim([0 300]);
MillerFigure;set(gca, 'YTick', []);
subplot(3,1,2)
plot(binnedData.emgdatabin(start:stop,1),'LineWidth',LineWidth);
ylabel('FDR');ylim([0 300]);
MillerFigure;set(gca, 'YTick', []);
subplot(3,1,3)
plot(binnedData.emgdatabin(start:stop,4),'LineWidth',LineWidth);
ylabel('FDP');ylim([0 300]);
MillerFigure;set(gca, 'YTick', []);

% PSDs
figure
emgPSD = pwelch(out_struct.emg.data(bdfStart:bdfStop,14+1),10000,0,Fs);
loglog(emgPSD); MillerFigure
title('ECU')
figure
emgPSD = pwelch(out_struct.emg.data(bdfStart:bdfStop,1+1),10000,0,Fs);
loglog(emgPSD); MillerFigure
title('FCR')
figure
emgPSD = pwelch(out_struct.emg.data(bdfStart:bdfStop,4+1),10000,0,Fs);
loglog(emgPSD); MillerFigure
title('FDP')



