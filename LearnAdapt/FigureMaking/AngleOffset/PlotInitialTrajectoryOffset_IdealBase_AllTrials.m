function [ErrorAngles, TargetNumberPerTrial, Tp]=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedOfInterest,NumOfSamples, plotcolor,plotFlag,TimeAfterGo)



% Get his initial trajectory for the file of interest
[TrajX, TrajY, TargetNumberPerTrial] = TrajectoriesStarting200AfterGo(binnedOfInterest,TimeAfterGo); %usually 0.4
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
TargetCenters=FindTargetCenter(binnedOfInterest);
ErrorAngles=CalculateErrorAngle_IdealBase_AllTrials(TrajX,TrajY,TargetNumberPerTrial,TargetCenters);
SmoothErrorAngles=movmean(ErrorAngles,NumOfSamples);


if plotFlag==1
    figure
    plot(SmoothErrorAngles,'.','Color',plotcolor,'MarkerSize',12);
    MillerFigure
    % Stats signrank ---------------------------------------------------------
    numSamples=40;
    Tp=(signrank(ErrorAngles(1:numSamples),ErrorAngles(end-numSamples+1:end)))./2;
    if Tp<=0.05
        xlabel('Significant')
    end
    
    
    % Plot according to color (can leave this commented out unti you want to
    % look at the results)
%     figure; hold on
%     for a=1:length(ErrorAngles)
%         plot(a,ErrorAngles(a),'.','Color',colors(TargetNumberPerTrial(a),:),'MarkerSize',12);
%         MillerFigure
%     end
%     if Tp<=0.05
%         xlabel('Significant')
%     end
    
end

end