% Weber figure showing raster, EMG, Force, Targets for Spring task
% Use Jango data 8-20

load('C:\Users\LimbLabSteph\Dropbox\HybridData\JangoGDdata4_082014.mat')

%load('C:\Users\LimbLabSteph\Dropbox\HybridData\JangoGDdata4_081914.mat')

% Neuron normalization (per neuron)
% maxes = mean(IsoBinned.spikeratedata);
% %maxes=quantile(binnedData.spikeratedata,.98);
% repMaxes=repmat(maxes,length(IsoBinned.spikeratedata(:,1)),1);
% IsoBinned.spikeratedata = IsoBinned.spikeratedata./repMaxes;

monkeyname = 'Jango';
binnedData=SprBinned;
DynamicRanges_FR

% Sorted neurons
for a=1:length(sortedIndsT1)
sortedExtNeurons(:,a) = SprBinned.spikeratedata(:,sortedIndsT1(a));
sortedFlexNeurons(:,a) = SprBinned.spikeratedata(:,sortedIndsT6(a));
end
SprBinned.spikeratedata=sortedExtNeurons;
%SprBinned.spikeratedata=sortedFlexNeurons;

figure
LW=1.5;
start = 4920;
stop = 5240;

%start = 3000
%stop = 3500
%start = 5705; stop = 6005; another option for time
% Plot raster
subplot(3,1,1)
neuronsubset=SprBinned.spikeratedata(start:stop,:);
maxPerNeuron=max(neuronsubset);
neuronsubset2 = (neuronsubset./repmat(maxPerNeuron,length(neuronsubset),1))';
imagesc(neuronsubset2);
set(gca, 'YtickLabel', [],'Ytick',[])
%xlim([1 320]) %not sure about this
MillerFigure
% Plot EMGs
subplot(3,1,2); hold on
colors = ['b','c','r','m'];
for a=1:4
plot(SprBinned.timeframe(start:stop),SprBinned.emgdatabin(start:stop,a),'Color',colors(a),'LineWidth',LW)
end
ylim([0 1]); xlim([start*.05 stop*.05])
legend('FCU','FCR','ECU','ECR')
legend boxoff; MillerFigure
% Plot cursor position
subplot(3,1,3); hold on
plot(SprBinned.timeframe(start:stop),SprBinned.cursorposbin(start:stop,1),'k','LineWidth',LW)
MillerFigure
xlim([start*.05 stop*.05]);set(gca, 'YtickLabel', [],'Ytick',[])
% Add target locations
for j = 1:length(SprBinned.trialtable(:,1))
    w = .5;
    h = abs(SprBinned.trialtable(j,2) - SprBinned.trialtable(j,4));
    y = SprBinned.trialtable(j,4)-h;
    rectangle('Position',[SprBinned.trialtable(j,8)-.5,y,w,h],'EdgeColor',[1 .1 .1],'FaceColor',[1 .5 .5])
end
xlabel('Time (seconds)', 'FontName', 'Arial')