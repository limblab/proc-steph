% Plot raw EMG twitches

load('C:\Stephanie\Data\FINEdata\TwitchData\PAM-Ch2-Median-FF022602-Cnum16-Beg-Recruitment Curve-trial5.mat')
handles.EMGnames

EDCrind=1;
figure; plot(rawtwitch(:,EDCrind))
MillerFigure
title('EDCr')
ylim([-6*10.^(-5) 4.5*10.^(-5)])
%xlim([1.9*10.^4 1.9*10.^4+2300]) 
xlim([1.9*10.^4 1.9*10.^4+1150]) 

ECUind=7;
figure; plot(rawtwitch(:,ECUind))
MillerFigure
title('ECU')
ylim([-6*10.^(-4) 4.5*10.^(-4)])
xlim([9400 9400+1150])

FCRind=12;
figure; plot(rawtwitch(:,FCRind))
MillerFigure
title('FCR')
ylim([-6*10.^(-4) 4.5*10.^(-4)])
xlim([9400 9400+1150])

FDSind=8;
figure; plot(rawtwitch(:,FDSind))
MillerFigure
title('FDS')
ylim([-6*10.^(-4) 4.5*10.^(-4)])
xlim([1.435*10.^4 1.4*10.^4+1150])
