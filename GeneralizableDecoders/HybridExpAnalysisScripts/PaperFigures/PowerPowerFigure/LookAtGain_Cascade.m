
% Look at gain


% Zero mean white noise 

%Step 1a: Initialize folders
% monkeyname = 'Kevin';
% HybridEMGlist=Kevin_HybridData_EMGQualityInfo();
% BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Kevin\';
% SubFolder={'05-19-15s','05-21-15s','05-25-15s','05-26-15s','06-04-15s'};


monkeyname = 'Jango';
HybridEMGlist=Jango_HybridData_EMGQualityInfo();
BaseFolder = 'Z:\limblab\User_folders\Stephanie\Data Analysis\Generalizability\Jango\';
SubFolder = {'07-24-14s','07-25-14s', '08-19-14s', '08-20-14s',...
  '08-21-14s','09-23-14s','10-10-14s','10-11-14s'...
  '10-12-14s'};

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

% neurons=[]; temp=[];
% for a=1:length(IsoBinned.spikeratedata(1,:))
%     temp = randn(6000, 1);
%     neurons=cat(2,neurons,temp);
% end

load('WhiteNoiseNeurons.mat');
neurons=neurons(:,1:length(IsoBinned.spikeratedata(1,:)));

IsoWhite = IsoTest;
IsoWhite.spikeratedata = neurons;
WmWhite = WmTest;
WmWhite.spikeratedata = neurons;
SprWhite = SprTest;
SprWhite.spikeratedata = neurons;

[Iso_PredEMGs] = predictSignals_predMIMO3(IsoModel, IsoWhite);
[Wm_PredEMGs] = predictSignals_predMIMO3(WmModel, WmWhite);
[Spr_PredEMGs] = predictSignals_predMIMO3(SprModel, SprWhite);


% EMG
Fs=2000;
PolyOrder = 3;PlotFlag=0;numlags=10;
IsoPSDs=[]; IsoEMG=[]; WmPSDs=[]; WmEMG=[]; SprPSDs=[]; SprEMG=[];
for emgInd=1:length(Iso_PredEMGs.preddatabin(1,:))

%Polynomial plotting
IsoAct = IsoWhite.emgdatabin(numlags:end,emgInd);
[IsoP] = WienerNonlinearity(Iso_PredEMGs.preddatabin(:,emgInd),IsoAct,PolyOrder,PlotFlag);
IsoCascade = polyval(IsoP,Iso_PredEMGs.preddatabin(:,emgInd));

WmAct = WmWhite.emgdatabin(numlags:end,emgInd);
[WmP] = WienerNonlinearity(Wm_PredEMGs.preddatabin(:,emgInd),WmAct,PolyOrder,PlotFlag);
WmCascade = polyval(WmP, Wm_PredEMGs.preddatabin(:,emgInd));

SprAct = SprWhite.emgdatabin(numlags:end,emgInd);
[SprP] = WienerNonlinearity(Spr_PredEMGs.preddatabin(:,emgInd),SprAct,PolyOrder,PlotFlag);
SprCascade = polyval(SprP,Spr_PredEMGs.preddatabin(:,emgInd));


IsoPSD=[]; WmPSD=[]; SprPSD=[];PolyOrder = 3;PlotFlag=0;numlags=10;
IsoPSD = pwelch(IsoCascade,100,0,Fs);
WmPSD = pwelch(WmCascade,100,0,Fs);
SprPSD = pwelch(SprCascade,100,0,Fs);


plotPSD=0;
if plotPSD==1
    figure
    loglog(IsoPSD,'b');
    hold on
    loglog(WmPSD,'g');
    loglog(SprPSD,'m');
title([monkeyname datalabel Iso_PredEMGs.outnames(emgInd)])
% x axis should be divided by 20
end

IsoPSDs(emgInd)=IsoPSD(40);
WmPSDs(emgInd)=WmPSD(40);
SprPSDs(emgInd)=SprPSD(40);
IsoEMG(emgInd)=quantile(IsoTest.emgdatabin(:,emgInd),.99);
WmEMG(emgInd)=quantile(WmTest.emgdatabin(:,emgInd),.99);
SprEMG(emgInd)=quantile(SprTest.emgdatabin(:,emgInd),.99);
       
end


plotScatter=1;
if plotScatter==1
   % figure;
    hold on
    title([monkeyname datalabel 'scatter'])
    plot(0,0,'*k');plot(0,0,'ok');plot(0,0,'.k','MarkerSize',20);plot(0,0,'vk');
    
    
    for ind = 1:length(Iso_PredEMGs.outnames)
        
        FCRflag=(strcmp(Iso_PredEMGs.outnames{ind}(1:3),'FCR'));
        if FCRflag
            plot(IsoEMG(ind),IsoPSDs(ind),'*b')
            plot(WmEMG(ind),WmPSDs(ind),'*g')
            plot(SprEMG(ind),SprPSDs(ind),'*m')
        end
        
        FCUflag=(strcmp(Iso_PredEMGs.outnames{ind}(1:3),'FCU'));
        if FCUflag
            plot(IsoEMG(ind),IsoPSDs(ind),'ob')
            plot(WmEMG(ind),WmPSDs(ind),'og')
            plot(SprEMG(ind),SprPSDs(ind),'om')
        end
        
        ECRflag=(strcmp(Iso_PredEMGs.outnames{ind}(1:3),'ECR'));
        if ECRflag
            plot(IsoEMG(ind),IsoPSDs(ind),'.b','MarkerSize',20)
            plot(WmEMG(ind),WmPSDs(ind),'.g','MarkerSize',20)
            plot(SprEMG(ind),SprPSDs(ind),'.m','MarkerSize',20)
        end
        
        ECUflag=(strcmp(Iso_PredEMGs.outnames{ind}(1:3),'ECU'));
        if ECUflag
            plot(IsoEMG(ind),IsoPSDs(ind),'vb')
            plot(WmEMG(ind),WmPSDs(ind),'vg')
            plot(SprEMG(ind),SprPSDs(ind),'vm')
        end
        
    end


legend('FCU','FCR','ECR','ECU')
legend boxoff
MillerFigure
end

clearvars -except monkeyname datalabel SubFolder BaseFolder HybridEMGlist

end
