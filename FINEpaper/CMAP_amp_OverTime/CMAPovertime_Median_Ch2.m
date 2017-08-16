%CMAP over time Median Ch 2

clear;


dateV=[0.857142857142857,2.14285714285714,3.28571428571429,...
    3.85714285714286,5,5.57142857142857,6.57142857142857,...
    7.57142857142857,8.28571428571429,9.28571428571429,...
    11.2857142857143,13.2857142857143,14.2857142857143];

% Muscle of interest: FDP
EMGind=11;

BaseFolder='C:\Stephanie\Data\FINEdata\CMAPoverTime\Median\Ch2\';
SubFolder={'031113-PAM-Ch2-MedianR-FF022602-Cnum16-MedianRec-Recruitment Curve-trial15.mat',...
    '032013-PAM-Ch2-MedianRight-FF022602-Cnum16-RightArm-03-20-13-Recruitment Curve-trial44.mat',...
    '032813-PAM-Ch2-Median-FF022602-Cnum16-mono-Recruitment Curve-trial3.mat',...
    '040413-PAM-Ch2-Median-FF022602-Cnum16-NU-04-04-13-Recruitment Curve-trial66.mat',...
    '041213-PAM-Ch2-Median-F022602-Cnum16-getthresh-Recruitment Curve-trial15.mat',...
    '041613-PAM-Ch2-Median-FF022602-Cnum16-newStim-Recruitment Curve-trial98.mat',...
    '042313-PAM-Ch2-Median-FF022602-Cnum16-NU042313-Recruitment Curve-trial4.mat',...
    '043013-PAM-Ch2-Median-FF022602-Cnum16-NU043013-Recruitment Curve-trial23.mat',...
    '050713-PAM-Ch2-Median-FF022602-Cnum16-NU050713-Recruitment Curve-trial11.mat',...
    '051413-PAM-Ch2-Median-FF022602-Cnum16-NU05142013-Recruitment Curve-trial6.mat',...
    '052813-PAM-Ch2-Median-FF022602-Cnum16-RecCurves-Recruitment Curve-trial16.mat',...
    '061413-PAM-Ch2-Median-FF022602-Cnum16-RC-Recruitment Curve-trial15.mat',...
    '062113-PAM-Ch2-Median-FF022602-Cnum16-RC-Recruitment Curve-trial19.mat'};

for a=1:length(SubFolder)
 load(strcat(BaseFolder,SubFolder{a}))

% Split into four twitch arrays for each individual EMG snippedts
% each emg snippet is 600 points. 600*(1/sf) gives you time
for c=0:3
Twitch(:,c+1) = rawtwitch(2400+600*c:2401+600*c+600, EMGind);
end
Twitch=Twitch(2:601,:);

% figure; hold on
% for d=1:4
%     plot(Twitch(:,d))
% end

pw(a)=handles.StaticVal;

for b=1:4
    minT(b)=min(Twitch(:,b));
    [maxT(b) maxTime(b)]=max(Twitch(:,b));
    peak2peak(b)=maxT(b)-minT(b);
end
mean_peak2peak(a)=mean(peak2peak);
std_peak2peak(a)=std(peak2peak);
mean_time2peakraw=mean(maxTime);
mean_time2peak(a)=mean_time2peakraw*(1/3051.76);
std_time2peak(a)=std(maxTime)*(1/3051.76);
    
clearvars -except BaseFolder SubFolder EMGind mean_peak2peak mean_time2peak...
    mean_peak2peak dateV pw std_peak2peak std_time2peak


end




figure
h(1)=plot(dateV,mean_peak2peak,'m<-','MarkerSize',10); hold on
set(h(1),'MarkerEdgeColor','m','MarkerFaceColor','m')
for ind=1:length(dateV)
    errorbar(dateV(ind),mean_peak2peak(ind),std_peak2peak(ind),std_peak2peak(ind),'m'); hold on
end
set(gca,'XTick',1:2:15)
ylim([0 0.06])
xlabel('Weeks Post Implant')
title('Mean Peak 2 Peak')
MillerFigure
legend FDP
legend boxoff


mean_time2peak=mean_time2peak*1000; % put in milliseconds
std_time2peak=std_time2peak*1000;

figure;
h(2)=plot(dateV,mean_time2peak,'m<-','MarkerSize',10); hold on
set(h(2),'MarkerEdgeColor','m','MarkerFaceColor','m')
set(gca,'XTick',1:2:15)
set(gca,'YTick',1:2:15)
ylim([1 15])
xlabel('Weeks Post Implant'); ylabel('Time (ms)')
title('FDP | Mean Time 2 Peak')
MillerFigure
for ind=1:length(dateV)
    errorbar(dateV(ind),mean_time2peak(ind),std_time2peak(ind),std_time2peak(ind),'m'); hold on
end



