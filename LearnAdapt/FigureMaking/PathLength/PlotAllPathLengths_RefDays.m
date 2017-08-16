function PlotAllPathLengths_RefDays

BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
FileName = {'LongPert_Jango_073115_binnedDec_ref', 'LongPert_Jango_080915_binnedDec_ref',...
    'LongPert_Jango_082415_binnedDec_ref',...
     'LongPert_Jango_090615_binnedDec_ref','LongPert_Jango_092515_binnedDec_ref',...
     'LongPert_Jango_092815_binnedDec_ref'};

for a=1:length(FileName)
    % Load files
    load(strcat(BaseFolder,FileName{a}))
    currentFile = FileName{a};
    figure
    
    subplot(1,4,1)
    [AllPathLengths_IsoHC] = CalculateAllPathLengths(binnedIsoHC);
    plot(movmean(AllPathLengths_IsoHC,15),'k.')
    xlabel('Hand control')
    ylim([0 70])
    MillerFigure
    title(currentFile(10:19), 'Interpreter', 'none')
    
    subplot(1,4,2)
    [AllPathLengths_NormalBC] = CalculateAllPathLengths(binnedNormalBC);
    plot(movmean(AllPathLengths_NormalBC,15),'k.')
    xlabel('Normal BC')
    ylim([0 90])
    MillerFigure
    
    subplot(1,4,3)
    [AllPathLengths_RefBC, TargetNumber] = CalculateAllPathLengths(binnedReflectedBC);
    plot(movmean(AllPathLengths_RefBC,15),'c.')
    xlabel('Reflected BC')
    ylim([0 90])
    MillerFigure
    
    subplot(1,4,4)
    [AllPathLengths_WashBC] = CalculateAllPathLengths(binnedWashoutBC);
    plot(movmean(AllPathLengths_WashBC,15),'m.')
    ylim([0 90])
    xlabel('Washout')
    MillerFigure
    
    figure
    PlotPathLengthPerTarget(AllPathLengths_RefBC,TargetNumber)
    title('Path length by target')
    
    clearvars -except BaseFolder FileName
end
