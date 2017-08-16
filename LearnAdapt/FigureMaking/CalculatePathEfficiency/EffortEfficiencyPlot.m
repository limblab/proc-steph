function EffortEfficiencyPlot(monkeyname)


if strcmp(monkeyname,'Kevin')
    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\';
    SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\WithinSessionMetrics\';
    SubFolder=KevinReflectedFileList('both');
else if strcmp(monkeyname,'Jango')
        BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
        SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\WithinSessionMetrics\';
        SubFolder=JangoReflectedFileList();
    end
end

for Tgt=5%[1 2 5]
    figure; hold on
    
    for a=1:length(SubFolder)
        load(strcat(BaseFolder,SubFolder{a}))
        saveFolder=strcat(SaveBaseFolder,SubFolder{a},'\');
        MonkeyandDate=SubFolder{a}(10:22);
        pertType=SubFolder{a}(end-2:end); % Either 'rot' or 'ref'
        sessionType = SubFolder{a}(1:4);
        
        if strcmp(sessionType,'Shor')
            binnedReflectedBC=binnedReflected1;
        end
        
        % Is He Trying
        % Show path lengths for all sessions
        [~,PathEfficiencyTargets,AllPathEfficiency_Perturbation] = CalculatePathEfficiency(binnedReflectedBC);
        NumOfSamples=5;
        AllPathEfficiency_Perturbation=AllPathEfficiency_Perturbation*(4.8/3);
        PathEfficiencyPerTargetCell=SeparateOutByTarget(AllPathEfficiency_Perturbation, PathEfficiencyTargets);
        % Go through and sdmooth each target
        SmoothPLPerTargetCell{1,Tgt}=movmean(PathEfficiencyPerTargetCell{1,Tgt},NumOfSamples);
        
        % path length during hold
        [~,AllPathEfficiencyTargets_Hold,AllPathEfficiency_Perturbation_Hold] = CalculateHoldTimePathEfficiency(binnedReflectedBC);
        AllPathEfficiency_Perturbation_Hold=AllPathEfficiency_Perturbation_Hold*(4.8/3)
         PathEfficiencyPerTargetCell_Hold=SeparateOutByTarget(AllPathEfficiency_Perturbation_Hold, AllPathEfficiencyTargets_Hold);
        % Go through and sdmooth each target
        SmoothPLPerTargetCell_Hold{1,Tgt}=movmean(PathEfficiencyPerTargetCell_Hold{1,Tgt},NumOfSamples);
        
        colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
        subplotLocations = [15 9 3 7 11 17 23 19];
        location= subplotLocations(Tgt);
        plot(SmoothPLPerTargetCell{1,Tgt},'.-','Color',colors(Tgt,:),'MarkerSize',5)
        plot(SmoothPLPerTargetCell_Hold{1,Tgt},'.-','Color',[0.8 0.8 0.8],'MarkerSize',5)
        title('Ref Smooth')
        ylim([-.5 24]);set(gca,'YTickLabel', cat(2,[0 1],[4:4:24]));set(gca,'Ytick', cat(2,[0 1],[4:4:24]))
        xlim([0 35])
        MillerFigure
        title(MonkeyandDate)
    end

        
end


% 
% 
% % pick the day you like
% % Target 2 jango example
% load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_082415_binnedDec_ref.mat')
% [TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedReflectedBC,1);
% Target1Indices=find(TargetNumber==2);
% TrajectoriesX=TrajectoriesX(Target1Indices,:);TrajectoriesY=TrajectoriesY(Target1Indices,:);
% TargetNumber=TargetNumber(Target1Indices);
% plotAllInitialTrajectoriesPerTarget(binnedReflectedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
% 
% 
% load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_073115_binnedDec_ref.mat')
% [TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedReflectedBC,1);
% Target1Indices=find(TargetNumber==5);
% TrajectoriesX=TrajectoriesX(Target1Indices,:);TrajectoriesY=TrajectoriesY(Target1Indices,:);
% TargetNumber=TargetNumber(Target1Indices);
% plotAllInitialTrajectoriesPerTarget(binnedReflectedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
% 
%  load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_092515_binnedDec_ref.mat')
% [TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedReflectedBC,1);
% Target1Indices=find(TargetNumber==1);
% TrajectoriesX=TrajectoriesX(Target1Indices,:);TrajectoriesY=TrajectoriesY(Target1Indices,:);
% TargetNumber=TargetNumber(Target1Indices);
% plotAllInitialTrajectoriesPerTarget(binnedReflectedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
% 
% % Kevin
% load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_050415_binnedDec_ref.mat')
% [TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedReflectedBC,1);
% Target1Indices=find(TargetNumber==1);
% TrajectoriesX=TrajectoriesX(Target1Indices,:);TrajectoriesY=TrajectoriesY(Target1Indices,:);
% TargetNumber=TargetNumber(Target1Indices);
% plotAllInitialTrajectoriesPerTarget(binnedReflectedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
% 
% load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_050415_binnedDec_ref.mat')
% [TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedReflectedBC,1);
% Target1Indices=find(TargetNumber==2);
% TrajectoriesX=TrajectoriesX(Target1Indices,:);TrajectoriesY=TrajectoriesY(Target1Indices,:);
% TargetNumber=TargetNumber(Target1Indices);
% plotAllInitialTrajectoriesPerTarget(binnedReflectedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
% 
% load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_050415_binnedDec_ref.mat')
% [TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedReflectedBC,1);
% Target1Indices=find(TargetNumber==5);
% TrajectoriesX=TrajectoriesX(Target1Indices,:);TrajectoriesY=TrajectoriesY(Target1Indices,:);
% TargetNumber=TargetNumber(Target1Indices);
% plotAllInitialTrajectoriesPerTarget(binnedReflectedBC,TrajectoriesX,TrajectoriesY, TargetNumber)
% 
end
% 
% 
% 
