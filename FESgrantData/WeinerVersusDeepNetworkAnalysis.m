
ali=[.73 .71 .66 .78 .68 .76 .73 .7 .56 .52 .75 .68];

ali=[ 0.7307    0.7170    0.6583    0.7758    0.6624    0.7665    0.7239    0.6948    0.5666    0.5201    0.7523    0.6851];
z=0:.1:1;

VAF=VAF/100;
[meanValueNN steValueNN] =FindMeanAndSTE(VAF);


[meanValue steValue] =FindMeanAndSTE(mfxval_vaf);
figure
steph = meanValue;
figure;plot(ali,steph,'.','MarkerSize',20)
hold on
plot(z,z,'k-')
ylabel('Weiner filter')
xlabel('Pseudo dynamic deep network')
title('VAF of muscle predictions')

ylabel('Weiner filter with 2nd order static nonlinearity')

figure
errorbar([1:12],meanValueNN, steValueNN, -steValueNN,'k.','LineWidth',2)
hold on
bar(meanValueNN)
xlim([0 13])
ylim([0 1])
MillerFigure

