function pvals=IsHeTrying_repeatedmeasures_LateWithinDays(IsHeTryingAllDaysPerTargetCell_Normal,IsHeTryingAllDaysPerTargetCell_Reflected,Day)


% One-way repeated measures anova Early Trial. 
% Rows by columns: Normal/Reflected are rows and columns are targets

    AllNormalData=[];AllReflectedData=[];Labels=[]; NumOfTrials=10;
    for Tgt=1:8
        NormalData(1:NumOfTrials,Tgt) =  IsHeTryingAllDaysPerTargetCell_Normal{Day,1}{1,Tgt}(end-NumOfTrials+1:end);
        ReflectedData(1:NumOfTrials,Tgt) = IsHeTryingAllDaysPerTargetCell_Reflected{Day,1}{1,Tgt}(end-NumOfTrials+1:end);
    end
    %     currentstring = repmat({strcat('Day',num2str(Day))}, [NumOfTrials 1]);
    %     Labels=cat(1,Labels,currentstring);
    %     currentstring=[];
    AllNormalData=cat(1,AllNormalData,NormalData);
     AllReflectedData=cat(1,AllReflectedData,ReflectedData);


Normalstring = repmat({'Normal'}, [NumOfTrials 1]);
Reflectedstring = repmat({'Reflected'}, [NumOfTrials 1]);
Labels=cat(1,Normalstring,Reflectedstring);
AllData=cat(1,AllNormalData,AllReflectedData);

% Make a table
t = table(Labels,AllData(:,1),AllData(:,2),AllData(:,3),AllData(:,4),...
    AllData(:,5),AllData(:,6),AllData(:,7),AllData(:,8),...
'VariableNames',{'TaskType','target1','target2','target3','target4',...
'target5','target6','target7','target8'});
Meas = dataset([1 2 3 4 5 6 7 8]','VarNames',{'Measurements'});  


% Fit a repeated measures model, where the measurements are the responses
% and the TaskType is the predictor variable. 
rm = fitrm(t,'target1-target8~TaskType','WithinDesign',Meas); 

t = table(Labels,AllData(:,3),AllData(:,6),AllData(:,7),...
'VariableNames',{'TaskType','target3','target6','target7'});
Meas = dataset([1 2 3]','VarNames',{'Measurements'});  
rm = fitrm(t,'target3-target7~TaskType','WithinDesign',Meas); 


% Perform repeated measures analysis of variance. 
ranovatbl = ranova(rm)
pvals=ranovatbl.pValue(2);



end