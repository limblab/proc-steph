function [ErrorAnglesPerTargetCell,StrategyAnglesPerTargetCell, PathLengthsPerTargetCell, BinarySuccessPerTargetCell,PathEfficiencyPerTargetCell,T2T_FirstPerTargetCell]= AcrossDaysStatsAnalysis(monkeyname,tasktype)
%AcrossDaysStatsAnalysis('Jango')
%[ErrorAnglesPerTargetCell_ref, StrategyAnglesPerTargetCell_ref, PathLengthsPerTargetCell_ref, BinarySuccessPerTargetCell_ref,PathEfficiencyPerTargetCell_ref T2T_FirstPerTargetCell_ref]= AcrossDaysStatsAnalysis('Jango','ref')
%[ErrorAnglesPerTargetCell_rot, StrategyAnglesPerTargetCell_rot, PathLengthsPerTargetCell_rot, BinarySuccessPerTargetCell_rot,PathEfficiencyPerTargetCell_rot T2T_FirstPerTargetCell_rot]= AcrossDaysStatsAnalysis('Jango','rot')
%[ErrorAnglesPerTargetCell_ref, StrategyAnglesPerTargetCell_ref, PathLengthsPerTargetCell_ref, BinarySuccessPerTargetCell_ref,PathEfficiencyPerTargetCell_ref T2T_FirstPerTargetCell_ref]= AcrossDaysStatsAnalysis('Kevin','ref')
%[ErrorAnglesPerTargetCell_rot, StrategyAnglesPerTargetCell_rot, PathLengthsPerTargetCell_rot, BinarySuccessPerTargetCell_rot,PathEfficiencyPerTargetCell_rot T2T_FirstPerTargetCell_rot]= AcrossDaysStatsAnalysis('Kevin','rot')


if strcmp(monkeyname,'Kevin')
    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\';
    SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\WithinSessionMetrics\';
    if strcmp(tasktype,'rot')
        SubFolder=KevinRotatedFileList('both');
    end
    if strcmp(tasktype,'ref')
        SubFolder=KevinReflectedFileList('both');
    end
else if strcmp(monkeyname,'Jango')
        BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
        SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\WithinSessionMetrics\';
        if strcmp(tasktype,'rot')
            SubFolder=JangoRotatedFileList();
        end
        if strcmp(tasktype,'ref')
            SubFolder=JangoReflectedFileList();
        end
        
    end
end

for a=1:length(SubFolder)
    
    load(strcat(BaseFolder,SubFolder{a}))
    saveFolder=strcat(SaveBaseFolder,SubFolder{a},'\');
    MonkeyandDate=SubFolder{a}(10:22);
    pertType=SubFolder{a}(end-2:end); % Either 'rot' or 'ref'
    sessionType = SubFolder{a}(1:4);
    % Prepare the setup that distinguishes between the Long and Short pert
    % sessions
    if strcmp(sessionType,'Long')
        numOfblocks=1;
    else if strcmp(sessionType,'Shor')
            numOfblocks=3;
        end
    end
    
    
    % Initialize
    ErrorAngles=[];ErrorAngleTargets=[];
    AllPathLengths=[];PathLengthTargets=[];
    AllPathEfficiency=[];PathEfficiencyTargets=[];
    StrategyAngles=[]; StrategyTargets=[];
    BinarySuccess=[]; BinaryTargets=[];
    T2T_First=[];    T2T_FirstTargets=[];
    
    
    for b=1:numOfblocks
        
        % Set up binnedPerturbation depending on if it was a rot or ref day
        if strcmp(sessionType,'Shor')
            binnedNormalBC=eval(strcat('binnedNormal',num2str(b)));
            blockNumber = num2str(b);
        else if strcmp(sessionType,'Long')
                blockNumber='';
            end
        end
        if strcmp(pertType,'ref')
            E2F_perturbation=E2F_reflected;
            taskType='Reflected';
            if strcmp(sessionType,'Shor')
                binnedPerturbation=eval(strcat('binnedReflected',num2str(b)));
            else if strcmp(sessionType,'Long')
                    binnedPerturbation=binnedReflectedBC;
                end
            end
        end
        if strcmp(pertType,'rot')
            E2F_perturbation=E2F_rotated;
            taskType = 'Rotated';
            if strcmp(sessionType,'Shor')
                binnedPerturbation=eval(strcat('binnedRotated',num2str(b)));
            else if strcmp(sessionType,'Long')
                    binnedPerturbation=binnedRotatedBC;
                end
            end
        end
        
        % Error angles-----------------------------------------------------
        [tempErrorAngles, tempErrorAngleTargets]=PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbation,1, 'k',0,.4);
        ErrorAngles=cat(1,ErrorAngles,tempErrorAngles);
        ErrorAngleTargets=cat(1,ErrorAngleTargets,tempErrorAngleTargets);
        %------------------------------------------------------------------
        
        % Path efficiency-----------------------------------------------------
        [~,tempPathEfficiencyTargets,tempAllPathEfficiency] = CalculatePathEfficiency(binnedPerturbation);
        AllPathEfficiency=cat(1,AllPathEfficiency,tempAllPathEfficiency);
        PathEfficiencyTargets=cat(1,PathEfficiencyTargets,tempPathEfficiencyTargets);
        %------------------------------------------------------------------
        
        % Path lenghts-----------------------------------------------------
        [tempAllPathLengths,tempPathLengthTargets] = CalculateAllPathLengths(binnedPerturbation);
        AllPathLengths=cat(1,AllPathLengths,tempAllPathLengths);
        PathLengthTargets=cat(1,PathLengthTargets,tempPathLengthTargets);
        %------------------------------------------------------------------
        
        % Strategy Angles-----------------------------------------------------
        [tempStrategyAngles, tempStrategyTargets]=PlotNeuralStrategyAngleError_AllTrials(binnedPerturbation,N2E,E2F_normal,1,0.4);
        StrategyAngles=cat(1,StrategyAngles,tempStrategyAngles);
        StrategyTargets=cat(1,StrategyTargets,tempStrategyTargets);
        %------------------------------------------------------------------
        
        % Binary Percent Angles -------------------------------------------
        [tempBinarySuccess, tempBinaryTargets] = BinaryPercentSuccess(binnedPerturbation);
        BinarySuccess=cat(1,BinarySuccess,tempBinarySuccess);
        BinaryTargets=cat(1,BinaryTargets,tempBinaryTargets);
        %------------------------------------------------------------------
        
        % T2Tfirst
        [~,tempT2T_First, tempT2T_FirstTargets] = T2Tfirst(binnedPerturbation);
        T2T_First=cat(1,T2T_First,tempT2T_First);
        T2T_FirstTargets=cat(1,T2T_FirstTargets,tempT2T_FirstTargets);
        
        
    end
    
    ErrorAnglesPerTargetCell{a,1}=SeparateOutByTarget(ErrorAngles, ErrorAngleTargets);
    PathLengthsPerTargetCell{a,1}=SeparateOutByTarget(AllPathLengths,PathLengthTargets);
    PathEfficiencyPerTargetCell{a,1}=SeparateOutByTarget(AllPathEfficiency,PathEfficiencyTargets);
    StrategyAnglesPerTargetCell{a,1}=SeparateOutByTarget(StrategyAngles,StrategyTargets);
    BinarySuccessPerTargetCell{a,1}=SeparateOutByTarget(BinarySuccess, BinaryTargets);
      T2T_FirstPerTargetCell{a,1}=SeparateOutByTarget(T2T_First, T2T_FirstTargets)
    
    % CLEAR VARIABLES TO MAKE WAY FOR THE NEXT BLOCK OF 'SHORT' ANALYSIS
    clearvars -except binnedNormalBC binnedNormal1 binnedNormal2 binnedNormal3 binnedIsoHC monkeyname BaseFolder...
        binnedReflected1 binnedReflected2 binnedReflected3 binnedRotated1 binnedRotated2 binnedRotated3 SubFolder...
        E2F_rotated E2F_normal E2F_reflected N2E MonkeyandDate pertType sessionType saveFolder taskType saveFlag ...
        SaveBaseFolder meanPathLengths_firstBlock   stdPathLengths_firstBlock ErrorAnglesPerTargetCell...
        meanNeuralStrategy_firstBlock stdNeuralStrategy_firstBlock PathLengthsPerTargetCell ...
        StrategyAnglesPerTargetCell BinarySuccessPerTargetCell PathEfficiencyPerTargetCell T2T_FirstPerTargetCell 
    
end

% CLEAR ALL VARIABLES TO MAKE WAY FOR THE NEXT DAY'S ANALYSIS
clearvars -except monkeyname BaseFolder SubFolder SaveBaseFolder saveFlag meanPathLengths_firstBlock   stdPathLengths_firstBlock...
    meanNeuralStrategy_firstBlock stdNeuralStrategy_firstBlock PathLengthsPerTargetCell StrategyAnglesPerTargetCell...
    ErrorAnglesPerTargetCell BinarySuccessPerTargetCell PathEfficiencyPerTargetCell T2T_FirstPerTargetCell

end




