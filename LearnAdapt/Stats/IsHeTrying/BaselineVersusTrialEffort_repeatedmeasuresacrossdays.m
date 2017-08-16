%BaselineVersusTrialEffort_repeatedmeasuresacrossdays


BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
SubFolder=JangoReflectedFileList();

for a=1:length(SubFolder)
    load(strcat(BaseFolder,SubFolder{a}))
    figure; hold on
    [BaselineTryingAllDaysCell_Reflected{a,1}]=BaselineTrying_PerTarget_PerTrial(binnedReflectedBC,'o');
    [~,IsHeTryingAllDaysCell_Reflected{a,1}]=PlotIsHeTrying_PerTarget_PerTrial(binnedReflectedBC,'.');
    suptitle(SubFolder{a}(16:21));
    BaselineTryingAllDaysPerTargetCell_Reflected{a,1}=SeparateOutByTarget(BaselineTryingAllDaysCell_Reflected{a,1}(:,1),BaselineTryingAllDaysCell_Reflected{a,1}(:,end));
    IsHeTryingAllDaysPerTargetCell_Reflected{a,1}=SeparateOutByTarget(IsHeTryingAllDaysCell_Reflected{a,1}(:,1),IsHeTryingAllDaysCell_Reflected{a,1}(:,end));
end