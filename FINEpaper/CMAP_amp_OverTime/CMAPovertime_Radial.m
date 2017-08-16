%  CMAP over time

% Pick parameter
%PAM, 3000 amplitude

% Stim param of interest: 3000
%StimParam=StimVals(2);
% Time frame for the second stim parameter is from 2400:4800
%Timeframe=(2401:4800);

BaseFolder='C:\Stephanie\Data\FINEdata\CMAPoverTime\Radial\';
SubFolder={'
    




% Muscle of interest: FCR
%EMGind=12; %FCRind=12 | we know this from handles.emgnames
%EMGind=13; %PL=13
EMGind=20; %Ulnar ADM=20;

for a=1:length(SubFolder)
 load(strcat(BaseFolder,SubFolder{a}))

% Split into four twitch arrays for each individual EMG snippedts
% each emg snippet is 600 points. 600*(1/sf) gives you time
for c=0:3
Twitch(:,c+1) = rawtwitch(2400+600*c:2401+600*c+600, EMGind);
end
Twitch=Twitch(2:601,:);

figure; hold on
for d=1:4
    plot(Twitch(:,d))
end

for b=1:4
    minT=min(Twitch(:,b));
    [maxT maxTime(b)]=max(Twitch(:,b));
    peak2peak(b)=maxT-minT;
end
mean_peak2peak(a)=mean(peak2peak);
%mean_time2peakraw=mean(maxTime);
%mean_time2peak(a)=mean_time2peakraw*(1/3051.76);
    
clearvars -except BaseFolder SubFolder EMGind mean_peak2peak mean_time2peak...
    mean_peak2peak_FCR 


end


figure;
h(1)=plot(mean_peak2peak,'rv-','MarkerSize',10); hold on
set(h(1),'MarkerEdgeColor','r','MarkerFaceColor','r')
%plot(mean_peak2peak,'g-','MarkerSize',10)
ylim([0 0.02])
xlabel('Sessions')
title('Mean Peak 2 Peak')
MillerFigure
legend ADM
legend boxoff
