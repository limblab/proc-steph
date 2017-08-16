% Look at gain

%Step 1a: Initialize folders
monkeyname = 'Kevin';
HybridEMGlist=Kevin_HybridData_EMGQualityInfo();
BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Kevin\';
SubFolder={'05-19-15s','05-21-15s','05-25-15s','05-26-15s','06-04-15s'};


% monkeyname = 'Jango';
% HybridEMGlist=Jango_HybridData_EMGQualityInfo();
% BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Jango\';
% SubFolder = {'07-24-14s','07-25-14s', '08-19-14s', '08-20-14s',...
%   '08-21-14s','09-23-14s','10-10-14s','10-11-14s'...
%   '10-12-14s'};

figure
for z = 1:length(SubFolder)
    % Step 1b:  Load data into workspace | Open folder directory for saving figs 
    cd([BaseFolder SubFolder{z} '\']);
    foldername = [BaseFolder SubFolder{z} '\'];
    hyphens = find(SubFolder{z}=='-'); SubFolder{z}(hyphens)=[];
    load([foldername 'HybridData_' monkeyname '_' SubFolder{z}(1,1:6)]);
    datalabel = SubFolder{z}(1:6);

    % Find the right EMGlist
    % Only keep EMG data for the 4 wrist muscles
    EMGlistIndex = find(strcmp(HybridEMGlist,datalabel));
    binnedData = IsoBinned;
    IsoBinned.emgguide = cellstr(IsoBinned.emgguide); WmBinned.emgguide = cellstr(WmBinned.emgguide);SprBinned.emgguide = cellstr(SprBinned.emgguide);
    for j=1:length(HybridEMGlist{EMGlistIndex,2})
        EMGindtemp = strmatch(HybridEMGlist{EMGlistIndex,2}(j,:),(binnedData.emgguide)); emg_vector(j) = EMGindtemp(1);
    end
    IsoBinned.emgguide = IsoBinned.emgguide(emg_vector); IsoBinned.emgdatabin = IsoBinned.emgdatabin(:,emg_vector);
    WmBinned.emgguide = WmBinned.emgguide(emg_vector); WmBinned.emgdatabin = WmBinned.emgdatabin(:,emg_vector);
    SprBinned.emgguide = SprBinned.emgguide(emg_vector); SprBinned.emgdatabin = SprBinned.emgdatabin(:,emg_vector);
    
    % Normalize EMGs according to the biggest EMG across all 3 tasks
    [IsoEMGsNormed WmEMGsNormed SprEMGsNormed] = NormalizeGeneralizableEMGs(IsoBinned.emgdatabin,WmBinned.emgdatabin,SprBinned.emgdatabin, 1);
    IsoBinned.emgdatabin=IsoEMGsNormed; WmBinned.emgdatabin=WmEMGsNormed; SprBinned.emgdatabin=SprEMGsNormed;
    %Get rid of neurons that fire <0.05 spike per second in any fiel
    badSpikeInds_Iso=findLowFiringNeurons(IsoBinned);
    badSpikeInds_Wm=findLowFiringNeurons(WmBinned);
    badSpikeInds_Spr=findLowFiringNeurons(SprBinned);
    allBadSpikeInds=unique(cat(2,badSpikeInds_Iso,badSpikeInds_Wm,badSpikeInds_Spr));
    IsoBinned.spikeratedata(:,allBadSpikeInds)=[];IsoBinned.neuronIDs(allBadSpikeInds,:)=[];
    WmBinned.spikeratedata(:,allBadSpikeInds)=[];WmBinned.neuronIDs(allBadSpikeInds,:)=[];
    SprBinned.spikeratedata(:,allBadSpikeInds)=[];SprBinned.neuronIDs(allBadSpikeInds,:)=[];
    % remove outliers
    [IsoBinned.emgdatabin, WmBinned.emgdatabin, SprBinned.emgdatabin] = GDremoveEMGoutliers(IsoBinned.emgdatabin, WmBinned.emgdatabin, SprBinned.emgdatabin);
    % Make the baseline the same by subtracting by 1 percentile (quantile, 0.01)
    [IsoBinned, WmBinned, SprBinned] = FixBaseline_HybridData(IsoBinned,WmBinned,SprBinned);

    % Step 1| Make sure you are using the same neurons for both files
    [IsoBinned, WmBinned] = SameNeuronsAcrossBinnedDataFiles(IsoBinned,WmBinned);
    [SprBinned, WmBinned] = SameNeuronsAcrossBinnedDataFiles(SprBinned,WmBinned);
    [SprBinned, IsoBinned] =  SameNeuronsAcrossBinnedDataFiles(SprBinned,IsoBinned);
    [WmBinned, IsoBinned] =  SameNeuronsAcrossBinnedDataFiles(WmBinned,IsoBinned);

    [Hybrid3 IsoTrain IsoTest WmTrain WmTest SprTrain SprTest] = AppendIsoWmSpr30minTotal(IsoBinned,WmBinned,SprBinned);
    options=[]; options.PredEMGs = 1;
    %BuildNormalModels -------------------------------------------------------
    IsoModel = BuildModel_predMIMO3(IsoTrain, options);
    WmModel = BuildModel_predMIMO3(WmTrain, options);
    SprModel = BuildModel_predMIMO3(SprTrain, options);

load('WhiteNoiseNeurons.mat');
neurons=neurons(:,1:length(IsoBinned.spikeratedata(1,:)));

IsoWhite = IsoTest; IsoWhite.spikeratedata = neurons;
WmWhite = WmTest; WmWhite.spikeratedata = neurons;
SprWhite = SprTest; SprWhite.spikeratedata = neurons;

[Iso_PredEMGs] = predictSignals_predMIMO3(IsoModel, IsoWhite);
[Wm_PredEMGs] = predictSignals_predMIMO3(WmModel, WmWhite);
[Spr_PredEMGs] = predictSignals_predMIMO3(SprModel, SprWhite);

% EMG
Fs=20;
IsoPSDs=[]; IsoEMG=[]; WmPSDs=[]; WmEMG=[]; SprPSDs=[]; SprEMG=[];
for a=1:length(Iso_PredEMGs.preddatabin(1,:))
    
    IsoPSD=[]; WmPSD=[]; SprPSD=[];
    
    
    [IsoPSD, Iso_f] = pwelch(Iso_PredEMGs.preddatabin(:,a),256,0,512,Fs);
    [WmPSD,Wm_f]= pwelch(Wm_PredEMGs.preddatabin(:,a),256,0,512,Fs);
    [SprPSD,Spr_f] = pwelch(Spr_PredEMGs.preddatabin(:,a),256,0,512,Fs);
    
    %     Example:
    %     [pxx,f]=pwelch(signal,256,0,512,20);
    %     figure;loglog(f,pxx)
    %     MillerFigure


   IsoEMGPSDsall=[]; WmEMGPSDsall=[]; SprEMGPSDsall=[];
   [IsoEMGPSDsall, IsoEMG_f] = pwelch(IsoTest.emgdatabin(:,a),256,0,512,Fs);
    [WmEMGPSDsall, WmEMG_f] = pwelch(WmTest.emgdatabin(:,a),256,0,512,Fs);
    [SprEMGPSDsall, SprEMG_f] = pwelch(SprTest.emgdatabin(:,a),256,0,512,Fs);
    
    
    % USE THE SAME EMG DATA THAT WERE USED TO TRAIN THE DECODER. UNCOMMENT
    % ME
%       IsoEMGPSDsall=[]; WmEMGPSDsall=[]; SprEMGPSDsall=[];
%     [IsoEMGPSDsall, IsoEMG_f] = pwelch(IsoTrain.emgdatabin(:,a),256,0,512,Fs);
%     [WmEMGPSDsall, WmEMG_f] = pwelch(WmTrain.emgdatabin(:,a),256,0,512,Fs);
%     [SprEMGPSDsall, SprEMG_f] = pwelch(SprTrain.emgdatabin(:,a),256,0,512,Fs);

plotPSD=0;
if plotPSD==1
        subplot(2,1,1); hold on
        loglog(Iso_f,IsoPSD,'m');
        hold on
        loglog(Wm_f,WmPSD,'g');
        loglog(Spr_f,SprPSD,'b');
        title([monkeyname datalabel Iso_PredEMGs.outnames(a)])
        MillerFigure
        xlim([0 10])
        
        subplot(2,1,2); hold on
        loglog(IsoEMG_f,IsoEMGPSDsall,'m');
        hold on
        loglog(WmEMG_f,WmEMGPSDsall,'g');
        loglog(SprEMG_f,SprEMGPSDsall,'b');
         xlim([0 12])
        
    
end


IsoPSDs(a)=mean(IsoPSD(1:27));
WmPSDs(a)=mean(WmPSD(1:27));
SprPSDs(a)=mean(SprPSD(1:27));

IsoEMGPSDs(a)=mean(IsoEMGPSDsall(1:27));
WmEMGPSDs(a)=mean(WmEMGPSDsall(1:27));
SprEMGPSDs(a)=mean(SprEMGPSDsall(1:27));

end


plotScatter=1;
if plotScatter==1
   % figure;
    hold on
    title([monkeyname datalabel 'scatter'])
%   Plot legend pts:  plot(0,0,'*k');plot(0,0,'ok');plot(0,0,'.k','MarkerSize',20);plot(0,0,'vk');
    
    
    for ind = 1:length(Iso_PredEMGs.outnames)
        
        FCRflag=(strcmp(Iso_PredEMGs.outnames{ind}(1:3),'FCR'));
        if FCRflag
            plot(IsoEMGPSDs(ind),IsoPSDs(ind),'*m')
            plot(WmEMGPSDs(ind),WmPSDs(ind),'*g')
            plot(SprEMGPSDs(ind),SprPSDs(ind),'*b')
        end
        
        FCUflag=(strcmp(Iso_PredEMGs.outnames{ind}(1:3),'FCU'));
        if FCUflag
            plot(IsoEMGPSDs(ind),IsoPSDs(ind),'om')
            plot(WmEMGPSDs(ind),WmPSDs(ind),'og')
            plot(SprEMGPSDs(ind),SprPSDs(ind),'ob')
        end
        
        ECRflag=(strcmp(Iso_PredEMGs.outnames{ind}(1:3),'ECR'));
        if ECRflag
            plot(IsoEMGPSDs(ind),IsoPSDs(ind),'.m','MarkerSize',20)
            plot(WmEMGPSDs(ind),WmPSDs(ind),'.g','MarkerSize',20)
            plot(SprEMGPSDs(ind),SprPSDs(ind),'.b','MarkerSize',20)
        end
        
        ECUflag=(strcmp(Iso_PredEMGs.outnames{ind}(1:3),'ECU'));
        if ECUflag
            plot(IsoEMGPSDs(ind),IsoPSDs(ind),'vm')
            plot(WmEMGPSDs(ind),WmPSDs(ind),'vg')
            plot(SprEMGPSDs(ind),SprPSDs(ind),'vb')
        end
        
    end


legend('FCU','FCR','ECR','ECU')
legend boxoff
MillerFigure
xlabel('EMG Power')
ylabel('Power')
end

clearvars -except monkeyname datalabel SubFolder BaseFolder HybridEMGlist

end
