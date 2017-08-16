function [HybridFinal IsoTrain IsoTest WmTrain WmTest SprTrain SprTest] = AppendIsoWmSpr30minTotal(File1, File2, File3)
% File1 = IsoBinned. File2 = WmBinned. File3 = SprBinned;


%Cut files into ten minute chunks
IsoTest = cutBinnedDataFile(File1, 1, 12000); % last 5 minutes (cut away first 10 min)
WmTest = cutBinnedDataFile(File2, 1, 12000); % last 5 minutes (cut away first 10 min)
SprTest = cutBinnedDataFile(File3, 1, 12000); % last 5 minutes (cut away first 10 min)

%SprTest = cutBinnedDataFile(SprTest, 6001, length(SprTest.timeframe)); % cut anything beyond 5 minutes
if length(IsoTest.timeframe)>6000
    IsoTest = cutBinnedDataFile(IsoTest, 6001, length(IsoTest.timeframe));
end% cut anything beyond 5 minutes
if length(WmTest.timeframe)>6000
    WmTest = cutBinnedDataFile(WmTest, 6001, length(WmTest.timeframe));
end% cut anything beyond 5 minutes
if length(SprTest.timeframe)>6000
    SprTest = cutBinnedDataFile(SprTest, 6001, length(SprTest.timeframe));
end% cut anything beyond 5 minutes



IsoTrain = cutBinnedDataFile(File1, 12001, length(File1.timeframe)); % first ten minutes (cut away last 5)
WmTrain = cutBinnedDataFile(File2, 12001, length(File2.timeframe)); % first ten minutes (cut away last 5)
SprTrain = cutBinnedDataFile(File3, 12001, length(File3.timeframe)); % first ten minutes (cut away last 5)

HybridFinal.meta.filename = 'Hybrid';
HybridFinal = File1;
HybridFinal.meta = HybridFinal.meta;
HybridFinal.emgdatabin = cat(1, IsoTrain.emgdatabin, WmTrain.emgdatabin,SprTrain.emgdatabin);
HybridFinal.forcedatabin = cat(1, IsoTrain.forcedatabin, WmTrain.forcedatabin, SprTrain.forcedatabin);
HybridFinal.spikeratedata = cat(1,IsoTrain.spikeratedata, WmTrain.spikeratedata, SprTrain.spikeratedata);
IsoSection.cursorposbin = zeros(length(IsoTrain.cursorposbin),2);
HybridFinal.cursorposbin = cat(1, IsoTrain.cursorposbin, WmTrain.cursorposbin, SprTrain.cursorposbin);
HybridFinal.velocbin  = cat(1, IsoTrain.velocbin, WmTrain.velocbin, SprTrain.velocbin);
HybridFinal.timeframe = (0:0.05:length(HybridFinal.forcedatabin)*.05-.05)';

for a=1:length(HybridFinal.emgdatabin(1,:))
    % HybridFinal.scale(a,1) = mean((IsoTrain.emgdatabin(:,a).^2))/(mean((WmTrain.emgdatabin(:,a).)^2));
   
   % HybridFinal.scale(a,1) = sumsqr(detrend(IsoTrain.emgdatabin(:,a),'constant'))/sumsqr(detrend(WmTrain.emgdatabin(:,a),'constant'));
    %HybridFinal.scale(a,2) = sumsqr(detrend(IsoTrain.emgdatabin(:,a),'constant'))/sumsqr(detrend(SprTrain.emgdatabin(:,a),'constant'));
    
   HybridFinal.scale(a,1) = (std(IsoTrain.emgdatabin(:,a)))/(std(WmTrain.emgdatabin(:,a)));
    HybridFinal.scale(a,2) = (std(IsoTrain.emgdatabin(:,a)))/(std(SprTrain.emgdatabin(:,a)));
    
    HybridFinal.Varscale(a,1) = (var(IsoTrain.emgdatabin(:,a)))/(var(WmTrain.emgdatabin(:,a)));
    HybridFinal.Varscale(a,2) = (var(IsoTrain.emgdatabin(:,a)))/(var(SprTrain.emgdatabin(:,a)));
    
end
HybridFinal.taskflag = ones(12000,1);
tempZ = zeros(12000,1); tempO = zeros(12000,1);
HybridFinal.taskflag = cat(1,HybridFinal.taskflag, tempZ);
HybridFinal.taskflag = cat(1,HybridFinal.taskflag, tempO);

