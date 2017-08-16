

% Organize the data for a kruskal wallis test

MetricCell=PathLengthsPerTargetCell_rot;

NumOfTrials=10;
Day=2;Groups=[];Data=[];
for Tgt=1:8
    %Data(1:NumOfTrials,Tgt) = MetricCell{Day,Day}{1,Tgt}(1:NumOfTrials);
    currentdata=MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
    Data=cat(1,Data,currentdata);
    %currentstring  = cell(1, NumOfTrials);
    %currentstring(:)={strcat('T',num2str(Tgt))};
    currentstring = repmat({strcat('T',num2str(Tgt))}, [1 NumOfTrials]);
    Groups = [Groups currentstring];
    currentstring=[];
end
Data=Data';

[p,tbl,stats] = kruskalwallis(Data,Groups)
c = multcompare(stats)

% friedman test is a two-way anova. I'm gonna test for groups and early/late-----

% Construct Friedman data variable
NumOfTrials=10;
Day = 1;
for Tgt=1:8
DataEarly(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
end

Day = 7;
for Tgt=1:8
DataLate(1:NumOfTrials,Tgt) = MetricCell{Day,1}{1,Tgt}(1:NumOfTrials);
end

AllFData=cat(1,DataEarly,DataLate);

[p,tbl,stats] = friedman(AllFData,NumOfTrials,'on')
c = multcompare(stats)

%---------------------------------
% rows: targets | columns: early/late
NumOfTrials=7;
Day = 1;DataEarly=[];
for Tgt=1:8
DataEarly = cat(1,DataEarly, MetricCell{Day,1}{1,Tgt}(1:NumOfTrials));
end

Day = 7;DataLate=[];
for Tgt=1:8
DataLate = cat(1,DataLate, MetricCell{Day,1}{1,Tgt}(1:NumOfTrials));
end

AllFData=cat(2,DataEarly,DataLate);

[p,tbl,stats] = friedman(AllFData,NumOfTrials,'on')
c = multcompare(stats)




% What do I ultimately want to do? Test the difference between Block 1 and
% Block 2 (early days and late days) for the 8 different targets. So I
% would have 2 types of treatment. Time and 8 targets



