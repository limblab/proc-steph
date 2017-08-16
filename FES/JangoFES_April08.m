%JangoFES_April008


figure;
LineWidth=1.5;
%no wrist on this day (fcr)
start = 2800;
stop=4200;
start=1000;
stop=21000;
xvals = 0:0.05:(stop-start)*.05;
subplot(3,1,1);hold on;
title('Jango Spoon FES April 8, 2016')
ylabel('EMG predictions')
for a=2:6
plot(xvals,cell2mat(JangoWFMUblock20160408142656emgpreds(start:stop,a)),'LineWidth',LineWidth);
end
xlim([0 (stop-start)*.05])
legend(bmi_fes_stim_params.muscles(1:5));
legend boxoff; MillerFigure

subplot(3,1,2);hold on;
ylabel('Stimulation PW (us)')
for b=3:6
plot(xvals,cell2mat(JangoWFMUblock20160408142656stimout(start:stop,b)),'LineWidth',LineWidth);
end
xlim([0 (stop-start)*.05])
legend(bmi_fes_stim_params.muscles(2:5));
legend boxoff; MillerFigure