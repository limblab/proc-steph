function PlotAllPathLengths_RotDays(monkeyname,saveFlag)

if monkeyname=='Kevin'
   BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\';
   SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\Plots\';
   % FileName={'ShorPert_Kevin_040315_binnedDec_rot',...
    %    'ShorPert_Kevin_040715_binnedDec_rot','ShorPert_Kevin_041015_binnedDec_rot',...
    %   'ShorPert_Kevin_041615_binnedDec_rot','ShorPert_Kevin_041715_binnedDec_rot',...
    FileName={'LongPert_Kevin_050115_binnedDec_rot','LongPert_Kevin_050315_binnedDec_rot',...
        'LongPert_Kevin_061315_binnedDec_rot'};
end
   
if monkeyname=='Jango'
    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
    SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\WithinSessionMetrics\';
    FileName={'LongPert_Jango_080415_binnedDec_rot','LongPert_Jango_080515_binnedDec_rot'...
        'LongPert_Jango_080815_binnedDec_rot',...
        'LongPert_Jango_082015_binnedDec_rot',...
        'LongPert_Jango_082615_binnedDec_rot',...
        'LongPert_Jango_092615_binnedDec_rot','LongPert_Jango_092915_binnedDec_rot'};
end

for a=1:length(FileName)
    % Load files
    load(strcat(BaseFolder,FileName{a}))
    currentFile = FileName{a};
    figure
    
    subplot(1,4,1)
    [AllPathLengths_IsoHC] = CalculateAllPathLengths(binnedIsoHC);
    plot(movmean(AllPathLengths_IsoHC,10),'k.')
    xlabel('Hand control')
    ylim([0 70])
    MillerFigure
    title(currentFile(10:19), 'Interpreter', 'none')
    
    subplot(1,4,2)
    [AllPathLengths_NormalBC] = CalculateAllPathLengths(binnedNormalBC);
    plot(movmean(AllPathLengths_NormalBC,10),'k.')
    xlabel('Normal BC')
    ylim([0 90])
    MillerFigure
    
    subplot(1,4,3)
    [AllPathLengths_RotBC,TargetNumber] = CalculateAllPathLengths(binnedRotatedBC);
    plot(movmean(AllPathLengths_RotBC,10),'c.')
    xlabel('Rotated BC')
    ylim([0 90])
    MillerFigure
    
    
    subplot(1,4,4)
    [AllPathLengths_WashBC] = CalculateAllPathLengths(binnedWashoutBC);
    plot(movmean(AllPathLengths_WashBC,10),'m.')
    ylim([0 90])
    xlabel('Washout')
    MillerFigure
    
    
    PlotPathLengthPerTarget(AllPathLengths_RotBC,TargetNumber)
    MillerFigure
    title(currentFile(10:19), 'Interpreter', 'none')
    
    title(strcat([monkeyname,' | PathLengths | ',taskType,' Decoder','',blockNumber]))
    if saveFlag==1
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'InitialTrajectories_',taskType,'Decoder',blockNumber))
    end
    
    
    clearvars -except BaseFolder FileName
end
