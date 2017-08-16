function Plot_InitialTrajectoryAngle_AllTargets_AllRotDays
% 
 BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
 FileName={'LongPert_Jango_080415_binnedDec_rot','LongPert_Jango_080515_binnedDec_rot'...
     'LongPert_Jango_080815_binnedDec_rot','LongPert_Jango_082615_binnedDec_rot',...
     'LongPert_Jango_092615_binnedDec_rot','LongPert_Jango_092915_binnedDec_rot'};
 FileName={'LongPert_Jango_092615_binnedDec_rot'};

%    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\';
%     FileName={'ShorPert_Kevin_040315_binnedDec_rot',...
%         'ShorPert_Kevin_040715_binnedDec_rot','ShorPert_Kevin_041015_binnedDec_rot',...
%         'ShorPert_Kevin_041615_binnedDec_rot','ShorPert_Kevin_041715_binnedDec_rot',};
%         FileName={'LongPert_Kevin_050115_binnedDec_rot','LongPert_Kevin_050315_binnedDec_rot',...
%         'LongPert_Kevin_061315_binnedDec_rot'};

for a=1:length(FileName)
    % Load files
    load(strcat(BaseFolder,FileName{a}))
    currentFile = FileName{a};
    figure
    
    subplot(1,4,1)
    PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedIsoHC,20,'k',1)
    xlabel('Hand control')
    ylim([0 90])
    MillerFigure
    title(currentFile(10:19), 'Interpreter', 'none')
    
    subplot(1,4,2)
    PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedNormalBC,20,'k',1)
    xlabel('Normal BC')
    ylim([0 90])
    MillerFigure
    
    subplot(1,4,3)
    PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedRotatedBC,20,'k',1)
    xlabel('Rotated BC')
    ylim([0 90])
    MillerFigure
    
    subplot(1,4,4)
    PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedWashoutBC,20,'k',1)
    ylim([0 90])
    xlabel('Washout')
    MillerFigure
    
    
    clearvars -except BaseFolder FileName
end

