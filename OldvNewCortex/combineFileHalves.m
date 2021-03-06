% Combine two binnedData files

%% First Half
half = length(binnedData.timeframe)/2;
binnedDataI.timeframe = binnedData.timeframe(1:half);
binnedDataI.emgdatabin = binnedData.emgdatabin(1:half,:);
binnedDataI.forcedatabin = binnedData.forcedatabin(1:half,:);
binnedDataI.spikeratedata = binnedData.spikeratedata(1:half,:);
binnedDataI.cursorposbin = binnedData.cursorposbin(1:half,:);
binnedDataI.velocbin = binnedData.velocbin(1:half,:);

TrialStartT = binnedData.trialtable(:,1);
TrialtoCutT = find(binnedDataI.timeframe(end) < TrialStartT,1,'first');
binnedDataI.trialtable = binnedData.trialtable(1:TrialtoCutT-1,:);

TrialStartW = binnedData.words(:,1);
TrialtoCutW = find(binnedDataI.timeframe(end) < TrialStartW,1,'first');
binnedDataI.words = binnedData.words(1:TrialtoCutW-1,:);

SD = std(binnedDataI.emgdatabin);
for a=1:length(binnedDataI.emgdatabin(1,:))
    binnedDataI.emgdatabin(:,a) = binnedDataI.emgdatabin(:,a)/SD(a);
end

%% Second half of the file
% 
% half = length(binnedData.timeframe)/2;
% binnedDataI2.timeframe = binnedData.timeframe(half:end);
% binnedDataI2.emgdatabin = binnedData.emgdatabin(half:end,:);
% binnedDataI2.forcedatabin = binnedData.forcedatabin(half:end,:);
% binnedDataI2.spikeratedata = binnedData.spikeratedata(half:end,:);
% binnedDataI2.cursorposbin = binnedData.cursorposbin(half:end,:);
% binnedDataI2.velocbin = binnedData.velocbin(half:end,:);
% 
% TrialStartT2 = binnedData.trialtable(:,1);
% TrialtoCutT2 = find(TrialStartT2 > binnedDataI2.timeframe(1),1,'first');
% binnedDataI2.trialtable = binnedData.trialtable(TrialtoCutT2:end,:);
% 
% TrialStartW2 = binnedData.words(:,1);
% TrialtoCutW2 = find(TrialStartW2 > binnedDataI2.timeframe(1),1,'first');
% binnedDataI2.words = binnedData.words(TrialtoCutW2:end,:);
% 
% SD = std(binnedDataI2.emgdatabin);
% for a=1:length(binnedDataI2.emgdatabin(1,:))
%     binnedDataI2.emgdatabin(:,a) = binnedDataI2.emgdatabin(:,a)/SD(a);
% end
% 
% binnedData.timeframe = (0:0.05:(length(binnedDataI2.timeframe)*0.05)-0.05)';
% binnedData.emgdatabin = binnedDataI2.emgdatabin;
% binnedData.forcedatabin = binnedDataI2.forcedatabin;
% binnedData.spikeratedata = binnedDataI2.spikeratedata;
% binnedData.cursorposbin = binnedDataI2.cursorposbin;
% binnedData.velocbin = binnedDataI2.velocbin;
% binnedData.trialtable = binnedDataI2.trialtable;
% binnedData.words = binnedDataI2.words;
% binnedData.meta.filename = 'Second half of Jaco_WM_UEAandEMGs_04-08-13_002 ';
% binnedData.meta.duration = binnedData.timeframe(end);
% 


%% First half of WM data 

half = length(binnedData.timeframe)/2;
binnedDataW.timeframe = binnedData.timeframe(1:half,:);
binnedDataW.emgdatabin = binnedData.emgdatabin(1:half,:);
binnedDataW.forcedatabin = binnedData.forcedatabin(1:half,:);
binnedDataW.spikeratedata = binnedData.spikeratedata(1:half,:);
binnedDataW.cursorposbin = binnedData.cursorposbin(1:half,:);
binnedDataW.velocbin = binnedData.velocbin(1:half,:);


TrialStartT = binnedData.trialtable(:,1);
TrialtoCutT = find(binnedDataW.timeframe(end) < TrialStartT,1,'first');
binnedDataW.trialtable = binnedData.trialtable(1:TrialtoCutT-1,:);

TrialStartW = binnedData.words(:,1);
TrialtoCutW = find(binnedDataW.timeframe(end) < TrialStartW,1,'first');
binnedDataW.words = binnedData.words(1:TrialtoCutW-1,:);


SD = std(binnedDataW.emgdatabin);
for a=1:length(binnedDataW.emgdatabin(1,:))
    binnedDataW.emgdatabin(:,a) = binnedDataW.emgdatabin(:,a)/SD(a);
end


%% Append

dt = 0.05;
binnedDataIW.timeframe = cat(1, binnedDataI.timeframe, (binnedDataW.timeframe + (binnedDataI.timeframe(end)+dt)));
binnedDataIW.emgdatabin = cat(1, binnedDataI.emgdatabin, binnedDataW.emgdatabin);
binnedDataIW.forcedatabin = cat(1, binnedDataI.forcedatabin, binnedDataW.forcedatabin);
binnedDataIW.spikeratedata = cat(1,binnedDataI.spikeratedata, binnedDataW.spikeratedata);
binnedDataIW.cursorposbin = cat(1, binnedDataI.cursorposbin, binnedDataW.cursorposbin);
binnedDataIW.velocbin  = cat(1, binnedDataI.velocbin, binnedDataW.velocbin);


binnedDataW.trailtable(:,1) = binnedDataW.trialtable(:,1) + binnedDataI.timeframe(end)+dt;
binnedDataIW.trialtable  = cat(1, binnedDataI.trialtable, binnedDataW.trialtable);

binnedDataW.words(:,1) = binnedDataW.words(:,1) + binnedDataI.timeframe(end)+dt;
binnedDataIW.words  = cat(1, binnedDataI.words, binnedDataW.words);


%% Finalize


 
 binnedData.timeframe = binnedDataIW.timeframe;
 binnedData.emgdatabin = binnedDataIW.emgdatabin;
 binnedData.forcedatabin = binnedDataIW.forcedatabin;
 binnedData.spikeratedata = binnedDataIW.spikeratedata;
 binnedData.cursorposbin = binnedDataIW.cursorposbin;
 binnedData.velocbin = binnedDataIW.velocbin;
 binnedData.trialtable = binnedDataIW.trialtable;
 binnedData.words = binnedDataIW.words;
 binnedData.meta.filename = 'Hybrid_IsoWM_Gry_05-12-13';
 binnedData.meta.duration = binnedDataIW.timeframe(end);
 
