function ranovatbl=RepeatedMeasuresAcrossSessions(MetricCell)
% first run something like
% [ErrorAnglesPerTargetCell_rot, StrategyAnglesPerTargetCell_rot, PathLengthsPerTargetCell_rot, BinarySuccessPerTargetCell_rot]= AcrossDaysStatsAnalysis('Jango','rot')


%MetricCell=PathLengthsPerTargetCell_rot;

% Put first 5/10 trials for each target in a matrix
% NumOfTrials=10;
% AllData=[];Labels=[];
% for Day=1:length(MetricCell)
%     for Tgt=1:8
%         Data(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
%         Lili(Day,Tgt)=lillietest(Data(:,Tgt));  
%     end
%     currentstring = repmat({strcat('Day',num2str(Day))}, [NumOfTrials 1]);
%     Labels=cat(1,Labels,currentstring);
%     currentstring=[];
%     AllData=cat(1,AllData,Data);
% end

% Put first X trials per target into day 1 and day 2 and last day and
% second to last day
NumOfTrials=10;
AllData=[];Labels=[];
for Day=[1 2 length(MetricCell)-1 length(MetricCell)]
    for Tgt=1:8
        Data(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
        Lili(Day,Tgt)=lillietest(Data(:,Tgt));
    end
    if Day==1 || Day==2
        currentstring = repmat({'First2Days'}, [NumOfTrials 1]);
        Labels=cat(1,Labels,currentstring);
        currentstring=[];
        AllData=cat(1,AllData,Data);
    end
    if Day==length(MetricCell)-1 || Day==length(MetricCell)
        currentstring = repmat({'Last2Days'}, [NumOfTrials 1]);
        Labels=cat(1,Labels,currentstring);
        currentstring=[];
        AllData=cat(1,AllData,Data);
    end
end


% Make a table
t = table(Labels,AllData(:,1),AllData(:,2),AllData(:,3),AllData(:,4),...
    AllData(:,5),AllData(:,6),AllData(:,7),AllData(:,8),...
'VariableNames',{'Day','target1','target2','target3','target4',...
'target5','target6','target7','target8'});
Meas = dataset([1 2 3 4 5 6 7 8]','VarNames',{'Measurements'});  


% Fit a repeated measures model, where the measurements are the responses
% and the Day is the predictor variable. 
rm = fitrm(t,'target1-target8~Day','WithinDesign',Meas); 


% Perform repeated measures analysis of variance. 
ranovatbl = ranova(rm);
postHoc = multcompare(rm,'Day','By','Measurements')

% Plot means
FirstTwoDaysTargetMeans=mean(AllData(1:length(AllData)/2,:));
FirstTwoDaysTargetSte=std((AllData(1:length(AllData)/2,:))/(sqrt(length(AllData)/2)));
LastTwoDaysTargetMeans=mean(AllData((length(AllData)/2)+1:end,:));
LastTwoDaysTargetSte=std((AllData((length(AllData)/2)+1:end,:))/(sqrt(length(AllData)/2)));


% Only plot first and second day
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure; hold on
for Tgt=1:8
    % location= subplotLocations(Tgt);
    %subplot(5,5,location); hold on
    errorbar(1,FirstTwoDaysTargetMeans(Tgt),FirstTwoDaysTargetSte(Tgt),FirstTwoDaysTargetSte(Tgt),'.','Color',colors(Tgt,:),'MarkerSize',2)
    errorbar(2,LastTwoDaysTargetMeans(Tgt),LastTwoDaysTargetSte(Tgt),LastTwoDaysTargetSte(Tgt),'.','Color',colors(Tgt,:),'MarkerSize',2)
    plot([1 2],[FirstTwoDaysTargetMeans(Tgt) LastTwoDaysTargetMeans(Tgt)],'Color',colors(Tgt,:),'MarkerSize',2,'LineWidth',2)
    ylim([0 140])
    set(gca,'Ytick',0:20:140)
    set(gca,'Xtick',1:2)
    set(gca,'Xticklabel',{'First 2 Days','Last 2 Days'})
end
MillerFigure


MS=12;
FirstTwoDaysTargetMeans(9)=FirstTwoDaysTargetMeans(1);
FirstTwoDaysTargetSte(9)=FirstTwoDaysTargetSte(1);
LastTwoDaysTargetMeans(9)=LastTwoDaysTargetMeans(1);
LastTwoDaysTargetSte(9)=LastTwoDaysTargetSte(1);

figure
theta=deg2rad(0:45:360);
h=polar([0:45:360-90],20*ones(1,7)); hold on % make it so the radius is 10, or
%whatever number you want

%h=polar([0:45:360-90],160*ones(1,7)); hold on %make it so the radius is 10, or
%whatever number you want
%h=polar([0:45:360-90],200*ones(1,7));hold on
h=polar(theta,FirstTwoDaysTargetMeans+FirstTwoDaysTargetSte);

hold on
h2=polar(theta,FirstTwoDaysTargetMeans-FirstTwoDaysTargetSte);
h2=polar(theta,FirstTwoDaysTargetMeans+FirstTwoDaysTargetSte);
[x1, y1] = pol2cart(theta, FirstTwoDaysTargetMeans+FirstTwoDaysTargetSte);                            
[x2, y2] = pol2cart(theta, FirstTwoDaysTargetMeans-FirstTwoDaysTargetSte);
patch([x1 fliplr(x2)], [y1 fliplr(y2)],'b-','FaceColor',[0 0.8 1.0],'EdgeColor',[0 0.8 1.0],'LineWidth',1.2) 
alpha(0.1)    

hold on
h3=polar(theta,LastTwoDaysTargetMeans+LastTwoDaysTargetSte);
h4=polar(theta,LastTwoDaysTargetMeans-LastTwoDaysTargetSte);
[x1, y1] = pol2cart(theta, LastTwoDaysTargetMeans+LastTwoDaysTargetSte);                            
[x2, y2] = pol2cart(theta, LastTwoDaysTargetMeans-LastTwoDaysTargetSte);
patch([x1 fliplr(x2)], [y1 fliplr(y2)],'b-','FaceColor',[.6 0.2 1],'EdgeColor',[.6 0.2 1],'LineWidth',1.2) 
alpha(0.1)  




% swap order for stupid illustrator


[x,y] = pol2cart(theta,FirstTwoDaysTargetMeans);
plot(x,y,'.-','Color',[0 0.8 1.0],'MarkerSize',MS,'LineWidth',2)

[x,y] = pol2cart(theta,LastTwoDaysTargetMeans);
plot(x,y,'.-','Color',[.6 0.2 1],'MarkerSize',MS,'LineWidth',2)


[x,y] = pol2cart(theta,FirstTwoDaysTargetMeans);
plot(x,y,'.-','Color',[0 0.8 1.0],'MarkerSize',MS,'LineWidth',2)

ph=findall(gca,'type','text');
ps=get(ph,'string');
ps(1:12)={''};ps([1])={'1'};
ps([2])={'5'};
set(ph,{'string'},ps);
ps([7])={'7'};
set(ph,{'string'},ps);
ps([8])={'3'};
set(ph,{'string'},ps);




% Make the lines
LL=200;
[x,y]=pol2cart([3.927 .7854 ],[0 LL])
plot(x,y,'-','Color',[.8 .8 .8])
[x,y]=pol2cart([.7854 3.927],[0 LL])
plot(x,y,'-','Color',[.8 .8 .8])

[x,y]=pol2cart([2.3562 5.4978],[0 LL])
plot(x,y,'-','Color',[.8 .8 .8])
[x,y]=pol2cart([5.4978 2.3562],[0 LL])
plot(x,y,'-','Color',[.8 .8 .8])




%thetaticks(0:45:360)
%thetaticklabels({'1','2','3','4','5','6','7','8'})
% rlim([0 .3])
% rticks(0:.1:.3)
