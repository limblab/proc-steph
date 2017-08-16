
% Truncate to 10 minutes
%binnedData.forcedatabin=binnedData.cursorposbin;
%binnedData = cutBinnedDataFile(binnedData, 12002,length(binnedData.timeframe));

% Normalize EMGs
percentile=quantile(binnedData.emgdatabin,.99);
normEMG=binnedData.emgdatabin./repmat(percentile,length(binnedData.emgdatabin),1);
binnedData.emgdatabin=normEMG;

load('PICWhiteNoiseNeurons.mat')
neurons=neurons(1:length(binnedData.timeframe),1:length(binnedData.spikeratedata(1,:)));

WhiteData=binnedData;
WhiteData.spikeratedata=neurons;

options=[]; options.PredEMGs = 1;
Model = BuildModel_predMIMO3(binnedData, options);


[PredEMGs] = predictSignals_predMIMO3(Model, WhiteData);

Fs=2000;counter=1;
for a=[1,3,5,6,7,10,11]
    PSD=[];
    PSD = pwelch(PredEMGs.preddatabin(:,a),100,0,Fs);
    PSDs(counter)=PSD(40);
    EMGs(counter)=quantile(binnedData.emgdatabin(:,a),.98);
    counter=counter+1;
end

%figure;
hold on
plot(EMGs, PSDs,'k*')
xlim([0 1])
