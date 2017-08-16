% BaselineTrying_repeatedmeasuresacrossdays

BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
SubFolder=JangoReflectedFileList();

for a=1:length(SubFolder)
    load(strcat(BaseFolder,SubFolder{a}))
    figure; hold on
     [BaselineTryingAllDaysCell_Reflected{a,1}]=BaselineTrying_PerTarget_PerTrial(binnedReflectedBC,'*');
    [~,IsHeTryingAllDaysCell_Reflected{a,1}]=PlotIsHeTrying_PerTarget_PerTrial(binnedReflectedBC,'s');
    suptitle(SubFolder{a}(16:21));
    BaselineTryingAllDaysPerTargetCell_Reflected{a,1}=SeparateOutByTarget(BaselineTryingAllDaysCell_Reflected{a,1}(:,1),BaselineTryingAllDaysCell_Reflected{a,1}(:,end));
    IsHeTryingAllDaysPerTargetCell_Reflected{a,1}=SeparateOutByTarget(IsHeTryingAllDaysCell_Reflected{a,1}(:,1),IsHeTryingAllDaysCell_Reflected{a,1}(:,end));
end

% for Day=1:length(SubFolder)
% pvalsEarly(Day)=IsHeTrying_repeatedmeasures_EarlyWithinDays(BaselineTryingAllDaysPerTargetCell_Reflected,IsHeTryingAllDaysPerTargetCell_Reflected,Day);
% 
% pvalsLate(Day)=IsHeTrying_repeatedmeasures_LateWithinDays(BaselineTryingAllDaysPerTargetCell_Reflected,IsHeTryingAllDaysPerTargetCell_Reflected,Day);
% end
% 
% pvalsEarly
% pvalsLate


for Day=1:length(SubFolder)
pvalsEarly1245(Day)=IsHeTrying_repeatedmeasures_EarlyWithinDays_Targets1245(BaselineTryingAllDaysPerTargetCell_Reflected,IsHeTryingAllDaysPerTargetCell_Reflected,Day);

pvalsLate1245(Day)=IsHeTrying_repeatedmeasures_LateWithinDays(BaselineTryingAllDaysPerTargetCell_Reflected,IsHeTryingAllDaysPerTargetCell_Reflected,Day);
end

pvalsEarly1245
pvalsLate1245

