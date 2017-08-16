function KO_PolarEMGTuningCurves(NumOfFiles, EMGmean, EMGste, binnedData,EMGmean2, EMGste2, binnedData2)


EMGste_plus = EMGmean+EMGste;
EMGste_minus = EMGmean-EMGste;
if NumOfFiles==2;
    EMGste2_plus = EMGmean2+EMGste2;
    EMGste2_minus = EMGmean2-EMGste2;
end


% Make polar plots
theta = degtorad([0:45:360]);
figure; hold on;
for b=1:4%length(EMGmean(:,1))
    subplot(2,2,b)
    polarplot(theta,EMGmean(b,:),'k','LineWidth',1.5)
    hold on;
    polarplot(theta,EMGste_plus(b,:),'k--','LineWidth',1)
    polarplot(theta,EMGste_minus(b,:),'k--','LineWidth',1)
    title(binnedData.emgguide(1,b));
    if NumOfFiles==2
        polarplot(theta,EMGmean2(b,:),'r','LineWidth',1.5)
        polarplot(theta,EMGste2_plus(b,:),'r--','LineWidth',1)
        polarplot(theta,EMGste2_minus(b,:),'r--','LineWidth',1)
        title(binnedData2.emgguide(1,b));
    end
end

