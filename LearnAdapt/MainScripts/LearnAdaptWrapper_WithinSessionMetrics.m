function [AllTargets_PathLengthP, PathLength_PerTargetP, AllTargets_TrajErrorP, TrajError_PerTargetP, AllTargets_NeuralStrategyP, NeuralStrategy_PerTargetP] = LearnAdaptWrapper_WithinSessionMetrics(monkeyname,taskType,saveFlag)
%[RotPathLengthP_AllTargets RotPathLength_PerTargetP, RotAllTargets_TrajErrorP, RotTrajError_PerTargetP, RotAllTargets_NeuralStrategyP, RotNeuralStrategy_PerTargetP]=LearnAdaptWrapper_WithinSessionMetrics('Jango','rot',0)
%[RefPathLengthP_AllTargets RefPathLength_PerTargetP, RefAllTargets_TrajErrorP,RefTrajError_PerTargetP, RefAllTargets_NeuralStrategyP,RefNeuralStrategy_PerTargetP]=LearnAdaptWrapper_WithinSessionMetrics('Jango','ref',0)
%[RotPathLengthP_AllTargets RotPathLength_PerTargetP, RotAllTargets_TrajErrorP,RotTrajError_PerTargetP, RotAllTargets_NeuralStrategyP, RotNeuralStrategy_PerTargetP]=LearnAdaptWrapper_WithinSessionMetrics('Kevin','rot',0)
%[RefPathLengthP_AllTargets RefPathLength_PerTargetP, RefAllTargets_TrajErrorP, RefTrajError_PerTargetP, RefAllTargets_NeuralStrategyP, RefNeuralStrategy_PerTargetP]=LearnAdaptWrapper_WithinSessionMetrics('Kevin','ref',0)

if strcmp(monkeyname,'Kevin')
    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\';
    SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\WithinSessionMetrics\';
    if strcmp(taskType,'ref')
        SubFolder=KevinReflectedFileList('both');
    end
    if strcmp(taskType,'rot')
        SubFolder=KevinRotatedFileList('both');
    end
else if strcmp(monkeyname,'Jango')
        BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
        SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\WithinSessionMetrics\';
        if strcmp(taskType,'ref')
            SubFolder=JangoReflectedFileList();
        end
        if strcmp(taskType,'rot')
            SubFolder=JangoRotatedFileList();
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
   
    for b=1%:numOfblocks
        
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
                binnedPerturbation1=eval(strcat('binnedReflected',num2str(1)));
                binnedPerturbation2=eval(strcat('binnedReflected',num2str(2)));
                binnedPerturbation3=eval(strcat('binnedReflected',num2str(3)));
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
                binnedPerturbation1=eval(strcat('binnedRotated',num2str(1)));
                binnedPerturbation2=eval(strcat('binnedRotated',num2str(2)));
                binnedPerturbation3=eval(strcat('binnedRotated',num2str(3)));
            else if strcmp(sessionType,'Long')
                    binnedPerturbation=binnedRotatedBC;
                end
            end
        end
        
              
        
        % PATH LENGTHS ALL TARGETS ------------------------------------------------
        if strcmp(sessionType,'Shor')
            AllTargets_PathLengthP(a,1)=KevinShort_PlotPathLenghs_GenericFiles_AllTargets(binnedPerturbation1,binnedPerturbation2,binnedPerturbation3);
        end
        if strcmp(sessionType,'Long')
            AllTargets_PathLengthP(a,1)=PlotPathLenghs_GenericFiles_AllTargets(binnedIsoHC,binnedNormalBC,binnedPerturbation,binnedWashoutBC,MonkeyandDate,taskType);
            SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'PathLengthAllTargets_',taskType,'Decoder',blockNumber))
        end
        %----------------------------------------------------------------------
        
        % PATH LENGTHS PER TARGET ------------------------------------------------
        if strcmp(sessionType,'Shor')
            [AllPathLengths_Perturbation1,PathLengthTargets1] = CalculateAllPathLengths(binnedPerturbation1);
            [AllPathLengths_Perturbation2,PathLengthTargets2] = CalculateAllPathLengths(binnedPerturbation2);
            [AllPathLengths_Perturbation3,PathLengthTargets3] = CalculateAllPathLengths(binnedPerturbation3);
            AllPathLengths_Perturbation=cat(1,AllPathLengths_Perturbation1,AllPathLengths_Perturbation2,AllPathLengths_Perturbation3);
            PathLengthTargets=cat(1,PathLengthTargets1,PathLengthTargets2,PathLengthTargets3);
        end
        if strcmp(sessionType,'Long')
            [AllPathLengths_Perturbation,PathLengthTargets] = CalculateAllPathLengths(binnedPerturbation);
        end
        PathLength_PerTargetP(:,a) = PlotPathLengthPerTarget(AllPathLengths_Perturbation,PathLengthTargets,...
            strcat([MonkeyandDate,'Path Lengths Per Target ',taskType,' BC ',blockNumber']));
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'PathLengthPerTarget_',taskType,'Decoder',blockNumber))
        %----------------------------------------------------------------------
        
        % INITIAL TRAJECTORY ERROR OVER TIME ALL TARGETS-----------------------------------
        %Just the pert section: PlotInitialTrajectoryOffset_IdealBase_AllTrials(binnedPerturbation,5, 'k',1)
        if strcmp(sessionType,'Shor')
            AllTargets_TrajErrorP(a,1)=KevinShort_TrajError_AllTargets_Stats(binnedPerturbation1,binnedPerturbation2,binnedPerturbation3,0.4);
        end
        if strcmp(sessionType,'Long')
            AllTargets_TrajErrorP(a,1) = PlotInitialTrajectoryOffset_IdealBase_AllTrials_AllBlocks(binnedIsoHC,binnedNormalBC,binnedPerturbation,binnedWashoutBC,MonkeyandDate,taskType,5,.4);
            SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'TrajOffset_AllTgts_Idealvs',taskType,'BC',blockNumber))
        end
        %----------------------------------------------------------------------
        
        % INITIAL TRAJECTORY ERROR OVER TIME PER TARGET-----------------------------------
        if strcmp(sessionType,'Shor')
            TrajError_PerTargetP(:,a)=KevinShort_TrajError_PerTarget_Stats(binnedPerturbation1,binnedPerturbation2,binnedPerturbation3,0.4);
        end
        if strcmp(sessionType,'Long')
            TrajError_PerTargetP(:,a)=PlotInitialTrajectoryOffset_IdealBaseVector(binnedPerturbation,0.4,1,...
                (strcat([MonkeyandDate,'Trajectory Offset Per Tgt | Ideal V. ',taskType,' BC ',blockNumber'])));
            SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'TrajOffset_PerTgt_Idealvs',taskType,'BC',blockNumber))
        end
        %----------------------------------------------------------------------
        
        % NEURAL STRATEGY ERROR OVER TIME ALL TARGETS-----------------------------------
        if strcmp(sessionType,'Shor')
            AllTargets_NeuralStrategyP(a,1)=KevinShort_NeuralStrategy_AllTargets_Stats(binnedPerturbation1,binnedPerturbation2,binnedPerturbation3, N2E, E2F_normal);
        end
        if strcmp(sessionType,'Long')
            [~,~,AllTargets_NeuralStrategyP(a,1)]=PlotNeuralStrategyAngleError_AllTrials(binnedPerturbation,N2E,E2F_normal,5,0.4);
            title(strcat([MonkeyandDate,'NeuralStrategyErrorAllTargets ',taskType,' BC ',blockNumber']),'Interpreter','none')
            SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'NeuralStrategyErrorAllTargets',taskType,'BC',blockNumber))
        end
        %----------------------------------------------------------------------
        
        % NEURAL STRATEGY ERROR OVER TIME PER TARGET-----------------------------------
        if strcmp(sessionType,'Shor')
            NeuralStrategy_PerTargetP(:,a)=KevinShort_NeuralStrategy_PerTarget_Stats(binnedPerturbation1,binnedPerturbation2,binnedPerturbation3, N2E, E2F_normal);
        end
        if strcmp(sessionType,'Long')
            NeuralStrategy_PerTargetP(:,a)=PlotNeuralStrategyAngleError_PerTarget(binnedPerturbation,N2E,E2F_normal,...
                strcat([MonkeyandDate,'NeuralStrategyErrorPerTargets ',taskType,' BC ',blockNumber']),0.4);
            SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'NeuralStrategyErrorPerTarget',taskType,'BC',blockNumber))
        end
        %----------------------------------------------------------------------
        
        % PERCENT SUCCESS
        
        
        
        % CLEAR VARIABLES TO MAKE WAY FOR THE NEXT BLOCK OF 'SHORT' ANALYSIS
        clearvars -except binnedNormalBC binnedNormal1 binnedNormal2 binnedNormal3 binnedIsoHC monkeyname BaseFolder...
            binnedReflected1 binnedReflected2 binnedReflected3 binnedRotated1 binnedRotated2 binnedRotated3 SubFolder...
            E2F_rotated E2F_normal E2F_reflected N2E MonkeyandDate pertType sessionType saveFolder taskType saveFlag ...
            SaveBaseFolder AllTargets_PathLengthP PathLength_PerTargetP TrajError_PerTargetP  NeuralStrategy_PerTargetP ...
            AllTargets_TrajErrorP AllTargets_NeuralStrategyP
        
    end
    
    % CLEAR ALL VARIABLES TO MAKE WAY FOR THE NEXT DAY'S ANALYSIS
    clearvars -except monkeyname BaseFolder SubFolder SaveBaseFolder saveFlag...
        AllTargets_PathLengthP PathLength_PerTargetP TrajError_PerTargetP  ...
        AllTargets_NeuralStrategyP NeuralStrategy_PerTargetP AllTargets_TrajErrorP
    close all
    
end


end