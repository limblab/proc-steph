function [HybridFinal IsoTrain IsoTest WmTrain WmTest] = AppendIsoWmHalves(File1, File2)
% File1 = IsoBinned. File2 = WmBinned. File3 = SprBinned;

%Cut files into ten minute chunks
 IsoTest = cutBinnedDataFile(File1, 1, 12000);
 WmTest = cutBinnedDataFile(File2, 1, 12000);
 %SprTest = cutBinnedDataFile(File3, 1, 12000);
IsoSection = cutBinnedDataFile(File1, 6001, length(File1.timeframe));
WmSection = cutBinnedDataFile(File2, 12001, length(File2.timeframe));  WmSection = cutBinnedDataFile(WmSection, 1, 6000);
IsoTrain = cutBinnedDataFile(File1, 12001, length(File1.timeframe));
WmTrain = cutBinnedDataFile(File2, 12001, length(File2.timeframe));
% File3 = cutBinnedDataFile(File3, 12001, length(File3.timeframe));

binnedDataIW.meta.filename = 'Hybrid';
binnedDataIW = File1;
binnedDataIW.meta = binnedDataIW.meta;
binnedDataIW.emgdatabin = cat(1, IsoSection.emgdatabin, WmSection.emgdatabin);
binnedDataIW.forcedatabin = cat(1, IsoSection.forcedatabin, WmSection.forcedatabin);
binnedDataIW.spikeratedata = cat(1,IsoSection.spikeratedata, WmSection.spikeratedata);
binnedDataIW.cursorposbin = cat(1, IsoSection.cursorposbin, WmSection.cursorposbin);
binnedDataIW.velocbin  = cat(1, IsoSection.velocbin, WmSection.velocbin);
binnedDataIW.timeframe = 0:0.05:length(binnedDataIW.forcedatabin)*.05-.05;
HybridFinal=binnedDataIW;

for i=1:length(HybridFinal.emgdatabin(1,:))
   % hybridData.scale(i,1) = std(File1.emgdatabin(:,i))/(std(File2.emgdatabin(:,i)));
     HybridFinal.scale(i,1) = 1;
end
HybridFinal.taskflag = ones(length(HybridFinal.emgdatabin(:,1)),1);


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
