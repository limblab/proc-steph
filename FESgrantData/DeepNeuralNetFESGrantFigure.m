% DeepNeuralNetFESGrantFigure

timeLong = 0:.05:300;
LineWidth=1.2;

start=18001;
stop=24001;

% Plot the raster
figure
neuronsubset=binnedData.spikeratedata(start:stop,:)';
neuronsubset = neuronsubset./(max(max(neuronsubset)));
imagesc(neuronsubset);
xlim([2120 2320])



%Bottleneck layer figure
figure
subplot(2,1,1)
plot(timeLong,bn(3,:),'b','LineWidth',LineWidth)
xlim([106 116])
MillerFigure
subplot(2,1,2)
plot(timeLong,bn(10,:),'b','LineWidth',LineWidth)
xlim([106 116])
MillerFigure



% EMG prediction figure
% Plotting EMG 3: FCU and APB
figure
subplot(2,1,1)
plot(time,actualEMGs(:,3),'k','LineWidth',LineWidth);
hold on
plot(timeLong, rec_emg(:,3),'r','LineWidth',LineWidth);
xlim([106 116]);ylim([0 1])
ylabel('FCU')
MillerFigure

subplot(2,1,2)
plot(time,actualEMGs(:,10),'k','LineWidth',LineWidth);
hold on
plot(timeLong, rec_emg(:,10),'r','LineWidth',LineWidth);
xlim([106 116]);ylim([0 1])
ylabel('APB')
xlabel('Time (in seconds)')
MillerFigure


%106
%116




