function [H2 IsoTrain IsoTest WmTrain WmTest] = AppendIsoSpr20minTotal(File1, File2)
% File1 = IsoBinned. File2 = WmBinned.
% Makes a hybrid file out of the Isometric and Movement Tasks (20 minute
% long file)


%Cut files into ten minute chunks
IsoTest = cutBinnedDataFile(File1, 1, 12000); % last 5 minutes (cut away first 10 min)

WmTest = cutBinnedDataFile(File2, 1, 12000); % last 5 minutes (cut away first 10 min)

IsoTrain = cutBinnedDataFile(File1, 12001, length(File1.timeframe)); % first ten minutes (cut away last 5)
WmTrain = cutBinnedDataFile(File2, 12001, length(File2.timeframe)); % first ten minutes (cut away last 5)

if length(IsoTest.timeframe)>6000
    IsoTest = cutBinnedDataFile(IsoTest, 6001, length(IsoTest.timeframe));
end% cut anything beyond 5 minutes
if length(WmTest.timeframe)>6000
    WmTest = cutBinnedDataFile(WmTest, 6001, length(WmTest.timeframe));
end% cut anything beyond 5 minutes

H2.meta.filename = 'Hybrid2Tasks';
H2 = File1;
H2.meta = H2.meta;
H2.emgdatabin = cat(1, IsoTrain.emgdatabin, WmTrain.emgdatabin);
H2.forcedatabin = cat(1, IsoTrain.forcedatabin, WmTrain.forcedatabin);
H2.spikeratedata = cat(1,IsoTrain.spikeratedata, WmTrain.spikeratedata);
IsoSection.cursorposbin = zeros(length(IsoTrain.cursorposbin),2);
H2.cursorposbin = cat(1, IsoTrain.cursorposbin, WmTrain.cursorposbin);
H2.velocbin  = cat(1, IsoTrain.velocbin, WmTrain.velocbin);
H2.timeframe = (0:0.05:length(H2.forcedatabin)*.05-.05)';


for a=1:length(H2.emgdatabin(1,:))
   H2.scale(a,1) = (std(IsoTrain.emgdatabin(:,a)))/(std(WmTrain.emgdatabin(:,a)));
   H2.Varscale(a,1) = (var(IsoTrain.emgdatabin(:,a)))/(var(WmTrain.emgdatabin(:,a)));
end

H2.taskflag = ones(12000,1);
tempZ = zeros(12000,1);
H2.taskflag = cat(1,H2.taskflag, tempZ);
