

% mVAF equation is : 1 - (SSEpred/SSEmean)

% Act and Pred are variables with dimensions: TimeBins x NumOfMuscles
for a = 1:length(Act(1,:))
    SSEpermuscle(1,a) = sum((Pred(:,a)-Act(:,a)).^2);
    SSEMeanPerMuscle(1,a) = sum( (Act(:,a) - repmat(mean(Act(:,a)),size(Act(:,a),1),1)).^2 );
end
SSEacrossmuscles = sum(SSEpermuscle);
SSEMeanAcrossMuscles = sum(SSEMeanPerMuscle);
mVAF = 1-(SSEacrossmuscles/SSEMeanAcrossMuscles);

for b=1:length(Act(1,:))
    individualVAFs(1,b)=calculateVAF(Pred(:,b),Act(:,b));
end
aveVAF=mean(individualVAFs);


R=corrcoef(Pred(:,c),Act(:,c));
R2 = R(1,2).^2;


% jango 7/24 linear within and act first muscle (FCU?)
index=1:5990
Pred = pred_within_lin_Wm(index,1);
Act = actual_Wm(index,1);
figure
plot(index,Pred,'r');hold on; plot(index,Act,'k');
legend('Pred','Act')
legend boxoff; MillerFigure
R=corrcoef(Pred,Act); R2 = R(1,2).^2
VAF=calculateVAF(Pred,Act)
title(strcat(['R2= ', num2str(R2), '   VAF= ', num2str(VAF)]))
ylim([0 0.015])


  