

[PercentSuccess]=PlotHypotheticalSuccessWithPerturbation('Jango','rot');
[PercentSuccess]=PlotHypotheticalSuccessWithPerturbation('Kevin','rot');

[PercentSuccess]=PlotHypotheticalSuccessWithPerturbation('Jango','ref');
[PercentSuccess]=PlotHypotheticalSuccessWithPerturbation('Kevin','ref');

meanPercentSuccess = mean(PercentSuccess);
stePercentSuccess=std(PercentSuccess)/sqrt(8);
meanPercentSuccess=100*meanPercentSuccess;
stePercentSuccess=100*stePercentSuccess;

theta=deg2rad([0:45:360]);
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
figure
for Tgt=1:8
    angle=theta(Tgt); avg=meanPercentSuccess(Tgt);error=stePercentSuccess(Tgt);
    n_data = length(angle);
    
polarplot(angle,avg,'-o','Color',colors(Tgt,:),'LineWidth',1.2);
hold on

for ni = 1 : n_data
    if (avg(ni)-error(ni)) < 0
        polarplot(angle(ni)*ones(1,3),[0, avg(ni), avg(ni)+error(ni)],'-','Color',colors(Tgt,:),'LineWidth',1.2); 
    else
        polarplot(angle(ni)*ones(1,3),[avg(ni)-error(ni), avg(ni), avg(ni)+error(ni)],'-','Color',colors(Tgt,:),'LineWidth',1.2); 
    end
end
end
polarplot(theta(1),100,'s')
thetaticks(0:45:360)
thetaticklabels({'1','2','3','4','5','6','7','8'})






