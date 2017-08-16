%Fish_CageFES_July112016

time = 0:0.0005:length(out_struct.emg.data(:,1))*.0005-.0005;

figure; hold on
for a=1:10
subplot(10,1,a)
plot(time,out_struct.emg.data(:,a+1))
ylabel(out_struct.emg.emgnames(a),'interpreter','none')
%xlim([0 4000])
MillerFigure
linkaxes([ax1,ax2,ax3],'xy')
end
xlabel('Time (in seconds)')


figure; hold on
h1=subplot(10,1,2);
plot(time,out_struct.emg.data(:,2))
h2=subplot(10,1,3);
plot(time,out_struct.emg.data(:,3))
h3=subplot(10,1,4);
plot(time,out_struct.emg.data(:,4))
h4=subplot(10,1,5);
plot(time,out_struct.emg.data(:,5))
h5=subplot(10,1,6);
plot(time,out_struct.emg.data(:,6))
h6=subplot(10,1,7);
plot(time,out_struct.emg.data(:,7))
h7=subplot(10,1,8);
plot(time,out_struct.emg.data(:,8))
h8=subplot(10,1,9);
plot(time,out_struct.emg.data(:,9))
h9=subplot(10,1,10);
plot(time,out_struct.emg.data(:,10))
MillerFigure
linkaxes([h1 h2 h3 h4 h5 h6 h7 h8 h9],'x')

plot(time,out_struct.emg.data(:,a+1))
ylabel(out_struct.emg.emgnames(a),'interpreter','none')
%xlim([0 4000])
MillerFigure
linkaxes([ax1,ax2,ax3],'xy')
end
xlabel('Time (in seconds)')








figure; hold on
for a=1:3
subplot(3,1,a)
plot(time(8000:32000),out_struct.emg.data(8000:32000,a+1))
%plot(time,out_struct.emg.data(:,a+1))
ylabel(out_struct.emg.emgnames(a),'interpreter','none')
%xlim([0 4000])
MillerFigure
end
xlabel('Time (in seconds)')

figure; hold on
for a=1:5
subplot(5,1,a)
plot(time(8000:12000),out_struct.emg.data(8000:12000,a+6))
ylabel(out_struct.emg.emgnames(a),'interpreter','none')
%xlim([0 4000])
MillerFigure
end
xlabel('Time (in seconds)')


totalEMG = binnedData.emgdatabin(:,2);
for c=3:10
    totalEMG = totalEMG+binnedData.emgdatabin(:,c);
end
figure;
plot(binnedData.timeframe,totalEMG)


