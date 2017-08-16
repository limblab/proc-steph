LearnAdapt_TestDifferentDecoders

BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\';
FileName = {'LongPert_Jango_073115_ref'};
    

 for z = 1:length(FileName)
     load(strcat(BaseFolder,FileName{z}))
     currentFile = FileName{z};
     date = FileName{z}(1,16:21); %for jango
     
     % Convert bdf to binned
     BDF2BinArgs = get_default_binning_params(out_struct_handcontrol);BDF2BinArgs.NormData=1;%fix
     binnedIsoHC =convertBDF2binned(out_struct_handcontrol,BDF2BinArgs);
     
     BDF2BinArgs = get_default_binning_params(out_struct_baseline);BDF2BinArgs.NormData=1;%fix
     binnedNormalBC =convertBDF2binned(out_struct_baseline,BDF2BinArgs);
     
     BDF2BinArgs = get_default_binning_params(out_struct_reflected);BDF2BinArgs.NormData=1;%fix
     binnedReflectedBC =convertBDF2binned(out_struct_reflected,BDF2BinArgs);
     
     BDF2BinArgs = get_default_binning_params(out_struct_rotated);BDF2BinArgs.NormData=1;%fix
     binnedRotatedBC =convertBDF2binned(out_struct_rotated,BDF2BinArgs);
     
     BDF2BinArgs = get_default_binning_params(out_struct_washout);BDF2BinArgs.NormData=1;%fix
     binnedWashoutBC =convertBDF2binned(out_struct_washout,BDF2BinArgs);
      
     
      BDF2BinArgs = get_default_binning_params(out_struct_handcontrol);BDF2BinArgs.NormData=1;%fix
     binnedIsoHC =convertBDF2binned(out_struct_handcontrol,BDF2BinArgs);
     
     BDF2BinArgs = get_default_binning_params(out_struct_normal1);BDF2BinArgs.NormData=1;%fix
     binnedNormal1 =convertBDF2binned(out_struct_normal1,BDF2BinArgs);
     BDF2BinArgs = get_default_binning_params(out_struct_normal2);BDF2BinArgs.NormData=1;%fix
     binnedNormal2 =convertBDF2binned(out_struct_normal2,BDF2BinArgs);
     BDF2BinArgs = get_default_binning_params(out_struct_normal3);BDF2BinArgs.NormData=1;%fix
     binnedNormal3 =convertBDF2binned(out_struct_normal3,BDF2BinArgs);
     
     BDF2BinArgs = get_default_binning_params(out_struct_rotated1);BDF2BinArgs.NormData=1;%fix
     binnedRotated1 =convertBDF2binned(out_struct_rotated1,BDF2BinArgs);
     BDF2BinArgs = get_default_binning_params(out_struct_rotated2);BDF2BinArgs.NormData=1;%fix
     binnedRotated2 =convertBDF2binned(out_struct_rotated2,BDF2BinArgs);
     BDF2BinArgs = get_default_binning_params(out_struct_rotated3);BDF2BinArgs.NormData=1;%fix
     binnedRotated3 =convertBDF2binned(out_struct_rotated3,BDF2BinArgs);
     
     
     % Only use 4 emgs
     binnedIsoHC = ReduceBinnedToFourWristMuscles(binnedIsoHC);
     binnedNormalBC = ReduceBinnedToFourWristMuscles(binnedNormalBC);
     binnedReflectedBC = ReduceBinnedToFourWristMuscles(binnedReflectedBC);
    %  binnedRotatedBC = ReduceBinnedToFourWristMuscles(binnedRotatedBC);
     binnedWashoutBC = ReduceBinnedToFourWristMuscles(binnedWashoutBC);
     
        binnedIsoHC = ReduceBinnedToFourWristMuscles(binnedIsoHC);
       binnedNormal1 = ReduceBinnedToFourWristMuscles(binnedNormal1);
         binnedNormal2 = ReduceBinnedToFourWristMuscles(binnedNormal2);
           binnedNormal3 = ReduceBinnedToFourWristMuscles(binnedNormal3);
           
            binnedRotated1 = ReduceBinnedToFourWristMuscles(binnedRotated1);
         binnedRotated2 = ReduceBinnedToFourWristMuscles(binnedRotated2);
           binnedRotated3 = ReduceBinnedToFourWristMuscles(binnedRotated3);
     
     % Build decoders-------------------------------------------------------
     % Normal and reflected decoders from hand control
     [N2E, E2F_normal, E2F_reflected] = BuildDecodersFromHandControl(binnedIsoHC);
     
     % Apply decoders to normal brain data --------------------------------
 
  
     % Plot data
     %[EMGmean, EMGste] = KO_GetEMGMeanAndSTE_DuringHold(binnedIsoHC)
%KO_PolarEMGTuningCurves(1, EMGmean, EMGste, binnedIsoHC)
     
     figure;hold on; plot(RecordedNormBrainPos(14:end,1),'k');plot(NormDecoder_NormBrain_Pos(:,1),'g');
     plot(RefDecoder_NormBrain_Pos(:,1),'m')
     legend('Normal BC','Norm Decoder Preds', 'Ref Decoder Preds')
     legend boxoff
     
        % Plot initial trajectories ------------------------------------------
      % Isometric Hand Control Data
      [TrajectoriesX_IsoHC, TrajectoriesY_IsoHC, TargetNumber_IsoHC] = InitialTrajectories(binnedIsoHC,1);
      plotInitialTrajectoriesPerTarget(binnedIsoHC,TrajectoriesX_IsoHC,TrajectoriesY_IsoHC, TargetNumber_IsoHC)
      title('Isometric Hand Control Data')
      
      [TrajectoriesX_NormalBC, TrajectoriesY_NormalBC, TargetNumber_NormalBC] = InitialTrajectories(binnedNormalBC,.8);
      plotInitialTrajectoriesPerTarget(binnedNormalBC,TrajectoriesX_NormalBC,TrajectoriesY_NormalBC, TargetNumber_NormalBC)
      title('Normal Brain Control Data')
      
      [TrajectoriesX_RefBC, TrajectoriesY_RefBC, TargetNumber_RefBC] = InitialTrajectories(binnedReflectedBC,.8);
      plotInitialTrajectoriesPerTarget(binnedReflectedBC,TrajectoriesX_RefBC,TrajectoriesY_RefBC, TargetNumber_RefBC)
      title('Reflected Brain Control Data')
      
      [TrajectoriesX_RotBC, TrajectoriesY_RotBC, TargetNumber_RotBC] = InitialTrajectories(binnedRotatedBC);
      plotInitialTrajectoriesPerTarget(binnedRotatedBC,TrajectoriesX_RotBC,TrajectoriesY_RotBC, TargetNumber_RotBC)
      title('Rotated Brain Control Data')
      % --------------------------------------------------------------------
      
      set(gca,'xtick',[],'ytick',[])
      set(gca, 'xcolor', 'w', 'ycolor', 'w') ;
      
       % Apply normal decoder to reflected brain data
     [NormDecoder_RefBrain_EMGs, NormDecoder_RefBrain_Pos, RecordedRefEMG, RecordedRefPos] = ApplyCascadeDecoders(binnedReflectedBC, N2E, E2F_normal);
      % Prediction Trajectories
      [PredTrajX_NormDec_RefBrain, PredTrajY_NormDec_RefBrain, TargetNum_NormDec_RefBrain]= InitialTrajectories_UsingPredictions(binnedReflectedBC,NormDecoder_RefBrain_Pos);
      plotInitialTrajectoriesPerTarget(binnedReflectedBC,PredTrajX_NormDec_RefBrain, PredTrajY_NormDec_RefBrain, TargetNum_NormDec_RefBrain)
      title('Reflected Brain Activity Passed Through Normal Decoder')
      
      
           % Apply reflected decoder to reflected brain data
     [RefDecoder_RefBrain_EMGs, RefDecoder_RefBrain_Pos]= ApplyCascadeDecoders(binnedReflectedBC, N2E, E2F_reflected);
           % Reflected Brain Activity Passed Through Reflected Decoder
       [PredTrajX_RefDec_RefBrain, PredTrajY_RefDec_RefBrain, TargetNum_RefDec_RefBrain]= InitialTrajectories_UsingPredictions(binnedReflectedBC,RefDecoder_RefBrain_Pos);
      plotInitialTrajectoriesPerTarget(binnedReflectedBC,PredTrajX_RefDec_RefBrain, PredTrajY_RefDec_RefBrain, TargetNum_RefDec_RefBrain)
      title('Reflected Brain Activity Passed Through Reflected Decoder')
      
          % Apply reflected decoder to normal brain data
     [RefDecoder_NormBrain_EMGs, RefDecoder_NormBrain_Pos] = ApplyCascadeDecoders(binnedNormalBC, N2E, E2F_reflected);
      % Reflected Brain Activity Passed Through Normal Decoder
       [PredTrajX_RefDec_NormBrain, PredTrajY_RefDec_NormBrain, TargetNum_RefDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedNormalBC,RefDecoder_NormBrain_Pos);
      plotInitialTrajectoriesPerTarget(binnedNormalBC,PredTrajX_RefDec_NormBrain, PredTrajY_RefDec_NormBrain, TargetNum_RefDec_NormBrain)
      title('Normal Brain Activity Passed Through Reflected Decoder')
      plotAllInitialTrajectoriesPerTarget(binnedNormalBC,PredTrajX_RefDec_NormBrain, PredTrajY_RefDec_NormBrain, TargetNum_RefDec_NormBrain)
       title('Normal Brain Activity Passed Through Reflected Decoder')
      
       % Apply normal decoder to normal brain data
     [NormDecoder_NormBrain_EMGs, NormDecoder_NormBrain_Pos, RecordedNormBrainEMGs, RecordedNormBrainPos] = ApplyCascadeDecoders(binnedNormalBC, N2E, E2F_normal);
          % Normal Brain Activity Passed Through Normal Decoder
       [PredTrajX_NormDec_NormBrain, PredTrajY_NormDec_NormBrain, TargetNum_NormDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedNormalBC,NormDecoder_NormBrain_Pos);
      plotInitialTrajectoriesPerTarget(binnedNormalBC,PredTrajX_NormDec_NormBrain, PredTrajY_NormDec_NormBrain, TargetNum_NormDec_NormBrain)
      title('Normal Brain Activity Passed Through Normal Decoder') 
      plotAllInitialTrajectoriesPerTarget(binnedNormalBC,PredTrajX_NormDec_NormBrain, PredTrajY_NormDec_NormBrain, TargetNum_NormDec_NormBrain)
      title('Normal Brain Activity Passed Through Normal Decoder')
      
      
        % Hand control brain activity through reflected decoder
        [RefDecoder_HC_EMGs, RefDecoder_HC_Pos, RecordedHCEMGs, RecordedHCPos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_reflected);
       [PredTrajX_RefDec_HC, PredTrajY_RefDec_HC, TargetNum_RefDec_HC]= InitialTrajectories_UsingPredictions(binnedIsoHC,RefDecoder_HC_Pos);
      plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_RefDec_HC, PredTrajY_RefDec_HC, TargetNum_RefDec_HC)
      plotAllInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_RefDec_HC, PredTrajY_RefDec_HC, TargetNum_RefDec_HC)
      title('HC Brain Activity Passed Through Reflected Decoder')
      
         % Hand control brain activity through NZU
        E2F_normalZeroUlnars=E2F_normal; E2F_normalZeroUlnars.H(1:5,:)=0; E2F_normalZeroUlnars.H(11:15,:)=0;
        [NZU_Decoder_HC_EMGs, NZU_Decoder_HC_Pos, RecordedHCEMGs, RecordedHCPos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_normalZeroUlnars);
       [PredTrajX_NZU_Dec_HC, PredTrajY_NZU_Dec_HC, TargetNum_NZU_Dec_HC]= InitialTrajectories_UsingPredictions(binnedIsoHC,NZU_Decoder_HC_Pos);
      plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_NZU_Dec_HC, PredTrajY_NZU_Dec_HC, TargetNum_NZU_Dec_HC)
      plotAllInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_NZU_Dec_HC, PredTrajY_NZU_Dec_HC, TargetNum_NZU_Dec_HC)
      title('HC Brain Activity Passed Through Normal-Zero-Ulnar Decoder')

      
        % Hand control brain activity through RZU
         E2F_refZeroUlnars=E2F_reflected; E2F_refZeroUlnars.H(1:5,:)=0; E2F_refZeroUlnars.H(11:15,:)=0;
        [RZU_Decoder_HC_EMGs, RZU_Decoder_HC_Pos, RecordedHCEMGs, RecordedHCPos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_refZeroUlnars);
       [PredTrajX_RZU_Dec_HC, PredTrajY_RZU_Dec_HC, TargetNum_RZU_Dec_HC]= InitialTrajectories_UsingPredictions(binnedIsoHC,RZU_Decoder_HC_Pos);
      plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_RZU_Dec_HC, PredTrajY_RZU_Dec_HC, TargetNum_RZU_Dec_HC)
       plotAllInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_RZU_Dec_HC, PredTrajY_RZU_Dec_HC, TargetNum_RZU_Dec_HC)
      title('HC Activity Passed Through Ref-Zero-Ulnar Decoder')

      % Percent success per target
       PercentSuccessPerTarget(binnedNormalBC,1,'Jango %success Normal brain control')
        PercentSuccessPerTarget(binnedReflectedBC,1,'Jango %success Reflected brain control')
        PercentSuccessPerTarget(binnedRotatedBC,1,'Kevin %success Rotated brain control','g')
      
      % Polar Muscle Tuning Curves
      % Muscle Tuning Curves Hand Control
      EMGmean=[]; EMGste=[];
      [EMGmean, EMGste] = KO_GetEMGMeanAndSTE_DuringHold(binnedIsoHC);
      KO_PolarEMGTuningCurves(1, EMGmean, EMGste, binnedIsoHC);
      suptitle('Hand control (successes)')
      
      % Muscle Tuning Curves Normal Brain Control
      EMGmean=[]; EMGste=[];
      [EMGmean, EMGste] = LearnAdapt_MuscleTuningData(binnedNormalBC,.5);
      suptitle('Normal brain control | Actual EMGs (traj)')
      
      
      % Muscle Tuning Curves Normal Brain Control
      EMGmean=[]; EMGste=[];
      [EMGmean, EMGste] = LearnAdapt_MuscleTuningData(binnedReflectedBC,.5);
      suptitle('Reflected brain control | Actual EMGs (traj)')
      
       EMGmean=[]; EMGste=[];
       binnedRefPreds=binnedReflectedBC;binnedRefPreds.emgdatabin=cat(1,nan(9,4),RefDecoder_RefBrain_EMGs);
      [EMGmean, EMGste] = LearnAdapt_MuscleTuningData(binnedRefPreds,.5);
      suptitle('Reflected brain control | Pred EMGs (traj)')
      
      % Muscle tuning curve for one target
      EMGmean=[]; EMGste=[];
      [EMGmean, EMGste] = LearnAdapt_MuscleTuningData_ForOneTarget(binnedNormalBC,.5,3);
       EMGmean=[]; EMGste=[];
      [EMGmean, EMGste] = LearnAdapt_MuscleTuningData_ForOneTarget(binnedNormalBC,.5,5);
      
      
          % Hand control brain activity through NZU
        E2F_UlnarReflect=E2F_normal; 
        FCRvals = E2F_normal.H(6:10,:);  ECRvals = E2F_normal.H(16:20,:);
        E2F_UlnarReflect.H(6:10,:)=ECRvals; E2F_UlnarReflect.H(16:20,:)=FCRvals;
        [UR_Decoder_HC_EMGs, UR_Decoder_HC_Pos, RecordedHCEMGs, RecordedHCPos] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_UlnarReflect);
       [PredTrajX_UR_Dec_HC, PredTrajY_UR_Dec_HC, TargetNum_UR_Dec_HC]= InitialTrajectories_UsingPredictions(binnedIsoHC,UR_Decoder_HC_Pos);
      plotInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_UR_Dec_HC, PredTrajY_UR_Dec_HC, TargetNum_UR_Dec_HC)
 plotAllInitialTrajectoriesPerTarget(binnedIsoHC,PredTrajX_UR_Dec_HC, PredTrajY_UR_Dec_HC, TargetNum_UR_Dec_HC)
      title('HC Through Ulnar Reflect')
      
       
 end
 