function LearnAdaptWrapper(monkeyname,saveFlag)
%LearnAdaptWrapper('Kevin',1)
%LearnAdaptWrapper('Jango',1)


if strcmp(monkeyname,'Kevin')
    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\';
    SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\Plots\';
    SubFolder={'LongPert_Kevin_050115_binnedDec_rot','LongPert_Kevin_050215_binnedDec_ref','LongPert_Kevin_050315_binnedDec_rot',...
        'LongPert_Kevin_061315_binnedDec_rot','LongPert_Kevin_061415_binnedDec_ref',...
        'ShorPert_Kevin_040215_binnedDec_ref','ShorPert_Kevin_040315_binnedDec_rot','ShorPert_Kevin_040615_binnedDec_ref'...
        'ShorPert_Kevin_040715_binnedDec_rot','ShorPert_Kevin_041015_binnedDec_rot','ShorPert_Kevin_041515_binnedDec_ref',...
        'ShorPert_Kevin_041615_binnedDec_rot','ShorPert_Kevin_041715_binnedDec_rot','ShorPert_Kevin_042015_binnedDec_ref'...
        'ShorPert_Kevin_042315_binnedDec_ref'};
else if strcmp(monkeyname,'Jango')
        BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
        SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\Plots\';
        SubFolder={'LongPert_Jango_080415_binnedDec_rot',...
        'LongPert_Jango_092915_binnedDec_rot'};
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
        
        
        % PERCENT SUCCESS------------------------------------------------------
        figure;PercentSuccessPerTarget(binnedNormalBC,1,strcat([monkeyname, '']),'k');
        hold on; PercentSuccessPerTarget(binnedPerturbation,1, strcat([monkeyname, ' | Percent success | Brain control','',blockNumber]),'c');
        legend('Normal',taskType); legend boxoff
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'PercentSuccess',blockNumber))
        %----------------------------------------------------------------------
        
        % PERCENT SUCCESS WITHOUT A HOLD TIME ---------------------------------
        figure; PercentSuccessPerTarget(binnedPerturbation,1,' ','k');
        hold on; PlotPercentSuccessWithoutHold(binnedPerturbation);
        legend('With hold','Without hold'); legend boxoff
        title(strcat(['Percent Success without a hold time','',blockNumber]))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'PercentSuccessWithoutHold',blockNumber))
        %----------------------------------------------------------------------
        
        % PERCENT SUCCESS NORMAL DECODER APPLIED TO HAND CONTROL NEURAL ACTIVITY
        % This tells us if the normal decoder was just bad to begin with
        PlotHandControlThroughFES_TargetSuccess(binnedIsoHC, binnedNormalBC,N2E, E2F_normal);
        title(strcat(['Normal Decoder on HC Neural Activity | Hypothetical %Succcess','',blockNumber]))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'NormDecoderOnHCBrain_PercentSuccess',blockNumber))
        %----------------------------------------------------------------------
        
        % INITIAL TRAJECTORIES ------------------------------------------------
        [TrajectoriesX_NormalBC, TrajectoriesY_NormalBC, TargetNumber_NormalBC] = InitialTrajectories(binnedNormalBC,.4);
        plotInitialTrajectoriesPerTarget(binnedNormalBC,TrajectoriesX_NormalBC,TrajectoriesY_NormalBC, TargetNumber_NormalBC);
        title(strcat([monkeyname,' | Initial trajectories | Normal Decoder','',blockNumber]))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'InitialTrajectories_NormalDecoder',blockNumber))
        [TrajectoriesX_PertBC, TrajectoriesY_PertBC, TargetNumber_PertBC] = InitialTrajectories(binnedPerturbation,.4);
        plotInitialTrajectoriesPerTarget(binnedPerturbation,TrajectoriesX_PertBC,TrajectoriesY_PertBC, TargetNumber_PertBC)
        title(strcat([monkeyname,' | Initial trajectories | ',taskType,' Decoder','',blockNumber]))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'InitialTrajectories_',taskType,'Decoder',blockNumber))
        %----------------------------------------------------------------------
        
        % INITIAL TRAJECTORY ERROR POLAR PLOT----------------------------------
        PlotInitialTrajectoryOffset(binnedIsoHC,binnedNormalBC)
        title(strcat(MonkeyandDate,'Trajectory Offset Hand Control V. Normal BC ',blockNumber'))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'TrajOffset_HCvsNormBC_',blockNumber))
        PlotInitialTrajectoryOffset(binnedNormalBC,binnedPerturbation)
        title(strcat([MonkeyandDate,'Trajectory Offset Normal BC V. ',taskType,' BC ',blockNumber']))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'TrajOffset_NormBCvs',taskType,'BC',blockNumber))
        %----------------------------------------------------------------------
        
        % INITIAL TRAJECTORY ERROR OVER TIME-----------------------------------
        % PlotInitialTrajectoryOffset(binnedNormalBC,binnedPerturbation)
        % old
        % New as of 4/17
        PlotInitialTrajectoryOffset_IdealBaseVector(binnedPerturbation,0.4,1,...
            strcat([MonkeyandDate,'Trajectory Offset Ideal V. ',taskType,' BC ',blockNumber']))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'TrajOffset_Idealvs',taskType,'BC',blockNumber))
        %----------------------------------------------------------------------
        
        % IS HE TRYING? -------------------------------------------------------
        PlotIsHeTryingPolar(binnedNormalBC, binnedPerturbation)
        title(strcat(['Is he trying','',blockNumber]))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'IsHeTrying',blockNumber))
        %----------------------------------------------------------------------
        
        % NORMAL DECODER APPLIED TO PERTURBATION NEURAL ACTIVITY --------------
        [~, NormDecoder_PertBrain_Pos] = ApplyCascadeDecoders(binnedPerturbation, N2E, E2F_normal);
        [PredTrajX_NormDec_PertBrain, PredTrajY_NormDec_PertBrain, TargetNum_NormDec_PertBrain]= InitialTrajectories_UsingPredictions(binnedPerturbation,NormDecoder_PertBrain_Pos,0.8);
        plotInitialTrajectoriesPerTarget(binnedPerturbation,PredTrajX_NormDec_PertBrain, PredTrajY_NormDec_PertBrain, TargetNum_NormDec_PertBrain)
        title(strcat(['Normal Decoder on ', taskType,' Brain Activity','',blockNumber]))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'NormDecoderOn',taskType,'Brain',blockNumber))
        %----------------------------------------------------------------------
        
        % PERTURBATION DECODER APPLIED TO NORMAL NEURAL ACTIVITY --------------
        [~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedNormalBC, N2E, E2F_perturbation);
        [PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedNormalBC,PertDecoder_NormBrain_Pos,0.8);
        plotInitialTrajectoriesPerTarget(binnedNormalBC,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)
        title(strcat([taskType, ' Decoder on Normal Brain Activity','',blockNumber]))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,taskType,'DecoderonNormBrain',blockNumber))
        %----------------------------------------------------------------------
        
        % MUSCLE TUNING ---------------------------------------------------
        LearnAdapt_MuscleTuningData(binnedIsoHC,0.8)
        suptitle('Muscle Tuning During Normal Hand Control')
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'MuscleTuningDuringHandControl'))
        %----------------------------------------------------------------------
        
        % CLEAR VARIABLES TO MAKE WAY FOR THE NEXT BLOCK OF 'SHORT' ANALYSIS
        clearvars -except binnedNormalBC binnedNormal1 binnedNormal2 binnedNormal3 binnedIsoHC monkeyname BaseFolder...
            binnedReflected1 binnedReflected2 binnedReflected3 binnedRotated1 binnedRotated2 binnedRotated3 SubFolder...
            E2F_rotated E2F_normal E2F_reflected N2E MonkeyandDate pertType sessionType saveFolder taskType saveFlag ...
            SaveBaseFolder
        
    end
    
    % CLEAR ALL VARIABLES TO MAKE WAY FOR THE NEXT DAY'S ANALYSIS
    clearvars -except monkeyname BaseFolder SubFolder SaveBaseFolder saveFlag
    close all
    
end

% NOTES: Other scripts I can also run:
% Offline VAFs is a separate script that plots VAFs across time

end