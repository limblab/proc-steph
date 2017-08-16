%NeuralNetVersusWeiner
%Jango centerout isometric

timeLong = 0:.05:358*.05-0.05;
LineWidth=1.2;

% FCR11 FCU9 FDS10OR12 FDP3

actualEMGs=[];
for a=1:length(test_index)
    actualEMG_mini = bdata.emgdatabin(test_index(a,1):test_index(a,2),3);
    actualEMGs=cat(1,actualEMGs,actualEMG_mini);
    actualEMG_mini=[];
end
FDP2actual=actualEMGs;

linearEMGs=[];
for a=1:length(test_index)
    linearEMG_mini = OLPredData.preddatabin(test_indexDecreased(a,1):test_indexDecreased(a,2),3);
    linearEMGs=cat(1,linearEMGs,linearEMG_mini);
    linearEMG_mini=[];
end
FDPlinear=linearEMGs;




% Plot the raster
figure
neuronsubset=bdata.spikeratedata(start:stop,:)';
neuronsubset = neuronsubset./(max(max(neuronsubset)));
imagesc(neuronsubset);

%Bottleneck layer figure
figure
subplot(2,1,1)
plot(timeLong,bn(3,:),'b','LineWidth',LineWidth)
%xlim([106 116])
MillerFigure
subplot(2,1,2)
plot(timeLong,bn(10,:),'b','LineWidth',LineWidth)
%xlim([106 116])
MillerFigure



% EMG prediction figure
% Plotting EMG 3: FCU and EMG 
% figure
% subplot(2,1,1)
% plot(timeLong,actualEMGs(:,3),'k','LineWidth',LineWidth);
% hold on
% plot(timeLong, rec_emg(:,3),'r','LineWidth',LineWidth);
% ylim([0 1])
% ylabel('FCU')
% MillerFigure
% 
% subplot(2,1,2)
% plot(timeLong,actualEMGs(:,10),'k','LineWidth',LineWidth);
% hold on
% plot(timeLong, rec_emg(:,10),'r','LineWidth',LineWidth);
% ylim([0 1])
% ylabel('APB')
% xlabel('Time (in seconds)')
% MillerFigure

% actual and predicted values
LineWidth=1.2;time=0:.05:17.9-0.05;
figure
subplot(4,1,1)
plot(time,FCUactual,'k','LineWidth',LineWidth)
hold on
plot(time,rec_emg(9,:),'b','LineWidth',LineWidth)
plot(time,FCUlinear,'g','LineWidth',LineWidth)
MillerFigure
ylim([0 1])

subplot(4,1,2)
plot(time,FCRactual,'k','LineWidth',LineWidth)
hold on
plot(time,rec_emg(11,:),'b','LineWidth',LineWidth)
plot(time,FCRlinear,'g','LineWidth',LineWidth)
MillerFigure
ylim([0 1])

subplot(4,1,3)
plot(time,FDS2actual,'k','LineWidth',LineWidth)
hold on
plot(time,rec_emg(12,:),'b','LineWidth',LineWidth)
plot(time,FDS2linear,'g','LineWidth',LineWidth)
MillerFigure
ylim([0 1])

subplot(4,1,4)
plot(time,FDPactual,'k','LineWidth',LineWidth)
hold on
plot(time,rec_emg(3,:),'b','LineWidth',LineWidth)
plot(time,FDPlinear,'g','LineWidth',LineWidth)
MillerFigure
ylim([0 1])






