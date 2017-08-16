

BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
SubFolder=JangoReflectedFileList();

for a=1:length(SubFolder)
    load(strcat(BaseFolder,SubFolder{a}))
    figure; hold on
    [~,IsHeTryingAllDaysCell_Normal{a,1}]=PlotIsHeTrying_PerTarget_PerTrial(binnedNormalBC,'.');
    [~,IsHeTryingAllDaysCell_Reflected{a,1}]=PlotIsHeTrying_PerTarget_PerTrial(binnedReflectedBC,'o');
    suptitle(SubFolder{a}(16:21));
    IsHeTryingAllDaysPerTargetCell_Normal{a,1}=SeparateOutByTarget(IsHeTryingAllDaysCell_Normal{a,1}(:,1),IsHeTryingAllDaysCell_Normal{a,1}(:,end));
    IsHeTryingAllDaysPerTargetCell_Reflected{a,1}=SeparateOutByTarget(IsHeTryingAllDaysCell_Reflected{a,1}(:,1),IsHeTryingAllDaysCell_Reflected{a,1}(:,end));
end

for Day=1:length(SubFolder)
pvalsEarly(Day)=IsHeTrying_repeatedmeasures_EarlyWithinDays(IsHeTryingAllDaysPerTargetCell_Normal,IsHeTryingAllDaysPerTargetCell_Reflected,Day)

pvalsLate(Day)=IsHeTrying_repeatedmeasures_LateWithinDays(IsHeTryingAllDaysPerTargetCell_Normal,IsHeTryingAllDaysPerTargetCell_Reflected,Day)
end