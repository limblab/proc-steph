function [SSEratio]=calculateSSEratio(Pred1,Pred2,Act)
% Data1 and Data2 format should be something like AonB_PredEMGs.preddatabin

for a=1:length(Pred1(1,:))
    indivSSE1(a)= sum( (Pred1(:,a)-Act(:,a)).^2 ) ;
end
Data1_sse = sum(indivSSE1);

for a=1:length(Pred2(2,:))
    indivSSE2(a)= sum( (Pred2(:,a)-Act(:,a)).^2 ) ;
end
Data2_sse = sum(indivSSE2);

SSEratio = Data2_sse/Data1_sse;

end