function [HybridFinal IsoTrain IsoTest WmTrain WmTest SprTrain SprTest] = AppendIsoWmSprThirds(File1, File2, File3)
% File1 = IsoBinned. File2 = WmBinned. File3 = SprBinned;


%Make iso cursor position data zero
File1.cursorposbin = zeros(length(File1.cursorposbin),2);
File1.velocbin = zeros(length(File1.velocbin),3);

%Cut files into ten minute chunks
IsoTest = cutBinnedDataFile(File1, 1, 12000);
IsoTest = cutBinnedDataFile(IsoTest, 6000, length(IsoTest.timeframe)); % last 5 minutes (cut away first 10 min)
WmTest = cutBinnedDataFile(File2, 1, 12000);
WmTest = cutBinnedDataFile(WmTest, 6000, length(WmTest.timeframe)); % last 5 minutes (cut away first 10 min)
SprTest = cutBinnedDataFile(File3, 1, 12000);
SprTest = cutBinnedDataFile(SprTest, 6000, length(SprTest.timeframe));% last 5 minutes (cut away first 10 min)
IsoSection = cutBinnedDataFile(File1, 4001, length(File1.timeframe)); % 4000 is samples in 3.33min (take first 3.33min)
WmSection = cutBinnedDataFile(File2, 4001, length(File2.timeframe));
SprSection = cutBinnedDataFile(File3, 4001, length(File3.timeframe));
IsoTrain = cutBinnedDataFile(File1, 12001, length(File1.timeframe));
WmTrain = cutBinnedDataFile(File2, 12001, length(File2.timeframe));
SprTrain = cutBinnedDataFile(File3, 12001, length(File3.timeframe));


binnedDataIW.meta.filename = 'Hybrid';
binnedDataIW = File1;
binnedDataIW.meta = binnedDataIW.meta;
binnedDataIW.emgdatabin = cat(1, IsoSection.emgdatabin, WmSection.emgdatabin,SprSection.emgdatabin);
binnedDataIW.forcedatabin = cat(1, IsoSection.forcedatabin, WmSection.forcedatabin, SprSection.forcedatabin);
binnedDataIW.spikeratedata = cat(1,IsoSection.spikeratedata, WmSection.spikeratedata, SprSection.spikeratedata);
IsoSection.cursorposbin = zeros(length(IsoSection.cursorposbin),2);
binnedDataIW.cursorposbin = cat(1, IsoSection.cursorposbin, WmSection.cursorposbin, SprSection.cursorposbin);
binnedDataIW.velocbin  = cat(1, IsoSection.velocbin, WmSection.velocbin, SprSection.velocbin);
binnedDataIW.timeframe = (0:0.05:length(binnedDataIW.forcedatabin)*.05-.05)';
HybridFinal=binnedDataIW;

for i=1:length(HybridFinal.emgdatabin(1,:))
  % HybridFinal.scale(i,1) = mean((IsoTrain.emgdatabin(:,i).^2))/(mean((WmTrain.emgdatabin(:,i).)^2));
  %HybridFinal.scale(i,1) = 1;
  HybridFinal.scale(i,1) = sumsqr(IsoTrain.emgdatabin(:,i))/sumsqr(WmTrain.emgdatabin(:,i));
end
HybridFinal.taskflag = ones(4000,1);
tempZ = zeros(4000,1); tempO = ones(4000,1);
HybridFinal.taskflag = cat(1,HybridFinal.taskflag, tempZ);
HybridFinal.taskflag = cat(1,HybridFinal.taskflag, tempO);

% bigTrialtable = find(binnedData.trialtable(:,1) >= numberOfSeconds);
%  binnedData1.trialtable = binnedData.trialtable;
% if isempty(bigTrialtable)
%     binnedData1.trialtable(bigTrialtable) =[];
% end
% 
%  bigWords = find(binnedData.words(:,1) >= numberOfSeconds);
%  binnedData1.words = binnedData.words;
% if isempty(bigWords)
%     binnedData1.words(bigWords) =[];
% end

end
