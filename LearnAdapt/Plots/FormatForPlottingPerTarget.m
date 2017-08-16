%FormatForPlottingPerTarget



example
% Plot percent success separately for each target across days
subplotLocations = [15 9 3 7 11 17 23 19];
figure
for T=1:8
   locale= subplotLocations(T);
subplot(5,5,locale); hold on
%plot(NormalBC_TargetSuccess(T,:),'k.','MarkerSize',15)
plot(PerturbedBC_TargetSuccess(T,:),'r.','MarkerSize',15)
title(strcat(['Target ', num2str(T)]))
ylim([0 1])
xlim([0 9])
end