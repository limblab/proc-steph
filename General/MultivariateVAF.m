function mVAF=MultivariateVAF(Pred, Act) 

% This is the old equation for mVAF
% for ind=1:length(Pred)
%         PredNorm(ind,1) = norm(Pred(ind,:));
%         ActNorm(ind,1) = norm(Act(ind,:));
% end
% mVAF  = 1 - sum( (PredNorm-ActNorm).^2 ) ./ sum( (ActNorm - repmat(mean(ActNorm),size(ActNorm,1),1)).^2 );


% New mVAF equation is : 1 - (SSEpred/SSEmean)  Added 1/23 at 2pm
%Act and Pred are variables with dimensions: TimeBins x NumOfMuscles
for a = 1:length(Act(1,:))
    SSEpermuscle(1,a) = sum((Pred(:,a)-Act(:,a)).^2);
    SSEMeanPerMuscle(1,a) = sum( (Act(:,a) - repmat(mean(Act(:,a)),size(Act(:,a),1),1)).^2 );
end
SSEacrossmuscles = sum(SSEpermuscle);
SSEMeanAcrossMuscles = sum(SSEMeanPerMuscle);
mVAF = 1-(SSEacrossmuscles/SSEMeanAcrossMuscles);

end