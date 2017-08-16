% F0B: First paper figure showing raster, EMG, Force, Targets
% Use Jango data 8-20

monkeyname = 'Jango';
HybridEMGlist=Jango_HybridData_EMGQualityInfo();
BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Jango\';
SubFolder = {'08-20-14s'};

% Step 1b:  Load data into workspace | Open folder directory for saving figs 
 cd([BaseFolder SubFolder{1} '\']);
 foldername = [BaseFolder SubFolder{1} '\'];
 hyphens = find(SubFolder{1}=='-'); SubFolder{1}(hyphens)=[];
    load([foldername 'HybridData_' monkeyname '_' SubFolder{1}(1,1:6)]);
    datalabel = SubFolder{1}(1:6);
SpringFile = 1;


% Find the right EMGlist
% Only keep EMG data for the 4 wrist muscles
EMGlistIndex = find(strcmp(HybridEMGlist,datalabel));
binnedData = IsoBinned;
IsoBinned.emgguide = cellstr(IsoBinned.emgguide); WmBinned.emgguide = cellstr(WmBinned.emgguide);
for j=1:length(HybridEMGlist{EMGlistIndex,2})
    EMGindtemp = strmatch(HybridEMGlist{EMGlistIndex,2}(j,:),(binnedData.emgguide)); emg_vector(j) = EMGindtemp(1);
end
IsoBinned.emgguide = IsoBinned.emgguide(emg_vector); IsoBinned.emgdatabin = IsoBinned.emgdatabin(:,emg_vector);
WmBinned.emgguide = WmBinned.emgguide(emg_vector); WmBinned.emgdatabin = WmBinned.emgdatabin(:,emg_vector);
if SpringFile == 1
    SprBinned.emgguide = cellstr(SprBinned.emgguide);
    SprBinned.emgguide = SprBinned.emgguide(emg_vector); SprBinned.emgdatabin = SprBinned.emgdatabin(:,emg_vector);
end

% Normalize EMGs according to the biggest EMG across all 3 tasks
%Or across both tasks, if there isn't a spring session for that day
if SpringFile == 1
    [IsoEMGsNormed WmEMGsNormed SprEMGsNormed] = NormalizeGeneralizableEMGs(IsoBinned.emgdatabin,WmBinned.emgdatabin,SprBinned.emgdatabin, SpringFile);
    IsoBinned.emgdatabin = IsoEMGsNormed; WmBinned.emgdatabin = WmEMGsNormed; SprBinned.emgdatabin = SprEMGsNormed;
else
    [IsoEMGsNormed WmEMGsNormed] = NormalizeGeneralizableEMGs(IsoBinned.emgdatabin,WmBinned.emgdatabin,1, SpringFile);
    IsoBinned.emgdatabin = IsoEMGsNormed; WmBinned.emgdatabin = WmEMGsNormed;
end

figure
LW=1.5;
start = 4920;
stop = 5240;
%start = 5705; stop = 6005; another option for time
% Plot raster
subplot(3,1,1)
neuronsubset=SprBinned.spikeratedata(start:stop,:);
maxPerNeuron=max(neuronsubset);
neuronsubset2 = neuronsubset./repmat(maxPerNeuron,length(neuronsubset),1);
imagesc(neuronsubset2);
set(gca, 'YtickLabel', [],'Ytick',[])
xlim([1 320]) %not sure about this
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
