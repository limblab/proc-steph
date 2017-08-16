
%PlotAllIsHeTryingAndPvalue

BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
SubFolder=JangoReflectedFileList();

for a=1:length(SubFolder)
    load(strcat(BaseFolder,SubFolder{a}))
    figure; hold on
    [Normalp(a,:),IsHeTryingAllDaysCell{a,1}]=PlotIsHeTrying_PerTarget_PerTrial(binnedNormalBC,'.');
    [Reflectedp(a,:),IsHeTryingAllDaysCell{a,1}]=PlotIsHeTrying_PerTarget_PerTrial(binnedReflectedBC,'o');
    suptitle(SubFolder{a}(16:21));
   
end

[NormalPSummary, NormalPTally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(Normalp);
[ReflectedPSummary, ReflectedPTally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(Reflectedp);