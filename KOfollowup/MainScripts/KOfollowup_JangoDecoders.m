function KOfollowup_JangoDecoders
% Loads Jango KO files, processes, makes predictions, saves pred values

% Initialize file variables
monkeyname = 'Jango';
BaseFolder = 'C:\Stephanie\Data\KOfollowup\Jango\';
SubFolder = {'07-28-2015','08-01-2015','08-07-2015','08-19-2015','09-01-2015','09-30-2015'};
    %SubFolder ={'09-30-2015'};
SubFolder = {'07-28-2015','08-07-2015','08-19-2015','09-01-2015','09-30-2015'};
SubFolder = {'09-30-2015'};
% For loop to open each SubFolder file and analyze data
for z = 1:length(SubFolder)
    % Load data into workspace | Open folder directory for saving figs 
    foldername = [BaseFolder SubFolder{z} '\'];
    load([foldername 'KO_Sorted_BinnedVariables_' monkeyname '_' SubFolder{z}]);
    
%     % Make sure the datasets have the same set of neurons ----------------
%     [IsoMidBinned,IsoProneBinned]=SameNeuronsAcrossBinnedDataFiles(IsoMidBinned,IsoProneBinned);
%     [IsoMidBinned,MoveMidBinned]=SameNeuronsAcrossBinnedDataFiles(IsoMidBinned,MoveMidBinned);
%     [IsoMidBinned,MoveProneBinned]=SameNeuronsAcrossBinnedDataFiles(IsoMidBinned,MoveProneBinned);
%     [IsoProneBinned,MoveMidBinned]=SameNeuronsAcrossBinnedDataFiles(IsoProneBinned,MoveMidBinned);
%     [IsoProneBinned,MoveProneBinned]=SameNeuronsAcrossBinnedDataFiles(IsoProneBinned,MoveProneBinned);
%     [MoveMidBinned,MoveProneBinned]=SameNeuronsAcrossBinnedDataFiles(MoveMidBinned,MoveProneBinned);
    % --------------------------------------------------------------------
    
    % Pare down the Binned files to only wrist EMGs -----------------------
    FCUind = strmatch('FCU',IsoMidBinned.emgguide(1,:)); FCUind = FCUind(1);
    FCRind = strmatch('FCR',IsoMidBinned.emgguide(1,:)); FCRind = FCRind(1);
    ECUind = strmatch('ECU',IsoMidBinned.emgguide(1,:)); ECUind = ECUind(1);
    ECRbind = strmatch('ECRb',IsoMidBinned.emgguide(1,:)); ECRbind = ECRbind(1);
    ECRlind = strmatch('ECRl',IsoMidBinned.emgguide(1,:)); ECRlind = ECRlind(1);
    EMGlist=[FCUind, FCRind, ECUind, ECRbind, ECRlind];
    IsoMidBinned.emgguide = {'FCU','FCR','ECU','ECRb','ECRl'};
    IsoMidBinned.emgdatabin=IsoMidBinned.emgdatabin(:,(EMGlist));
    IsoProneBinned.emgguide = {'FCU','FCR','ECU','ECRb','ECRl'};
    IsoProneBinned.emgdatabin=IsoProneBinned.emgdatabin(:,(EMGlist));
    MoveMidBinned.emgguide = {'FCU','FCR','ECU','ECRb','ECRl'};
    MoveMidBinned.emgdatabin=MoveMidBinned.emgdatabin(:,(EMGlist));
    MoveProneBinned.emgguide = {'FCU','FCR','ECU','ECRb','ECRl'};
    MoveProneBinned.emgdatabin=MoveProneBinned.emgdatabin(:,(EMGlist));
    % --------------------------------------------------------------------
        
    % Build decoder using the 10 minute training files -------------------
    options=[]; options.UseAllInputs=1; options.PredEMGs = 1; % Set options parameters
    IsoMidModel = BuildModel(IsoMidBinned, options); % Build IsoMid Decoder
    MoveMidModel = BuildModel(MoveMidBinned, options);% Build MoveMid Decoder
    
        % Apply decoder to the within-posture case ----------------------------
    foldlength = 60;
    % Isometric
    [~,SingleDayStruct.IMonIM_EMGvafsPerFold, ~, IMonIMpred]=mfxval(IsoMidBinned, options);
    % Movement
     [~,SingleDayStruct.MMonMM_EMGvafsPerFold, ~, MMonMMpred]=mfxval(MoveMidBinned, options);
    
    % ---------------------------------------------------------------------
    
    % Apply decoder to the across-posture case ----------------------------
    % Isometric
    [~, ~, IMonIPpred, ~, ~, IMonIPactTrunk SingleDayStruct.IMonIP_EMGvafsPerFold]=OneDecoderOnManyFolds_KO(IsoMidModel,IsoProneBinned,foldlength);
    % Movement
    [~, ~, MMonMP_pred, ~, ~, MMonMP_actTrunk SingleDayStruct.MMonMP_EMGvafsPerFold]=OneDecoderOnManyFolds_KO(MoveMidModel,MoveProneBinned,foldlength);
    % --------------------------------------------------------------------
     
    
    % Concatenate the single day data into an across day struct
    if z==1
        AcrossDays.IMonIM_EMGvafsPerFold = SingleDayStruct.IMonIM_EMGvafsPerFold;
        AcrossDays.IMonIP_EMGvafsPerFold = SingleDayStruct.IMonIP_EMGvafsPerFold;
        AcrossDays.MMonMM_EMGvafsPerFold = SingleDayStruct.MMonMM_EMGvafsPerFold;
        AcrossDays.MMonMP_EMGvafsPerFold = SingleDayStruct.MMonMP_EMGvafsPerFold;
        AcrossDays.EMGnames=IsoMidBinned.emgguide;
    else if z>1
            AcrossDays.IMonIM_EMGvafsPerFold = cat(1,AcrossDays.IMonIM_EMGvafsPerFold,SingleDayStruct.IMonIM_EMGvafsPerFold);
            AcrossDays.IMonIP_EMGvafsPerFold = cat(1,AcrossDays.IMonIP_EMGvafsPerFold,SingleDayStruct.IMonIP_EMGvafsPerFold);
            AcrossDays.MMonMM_EMGvafsPerFold = cat(1,AcrossDays.MMonMM_EMGvafsPerFold,SingleDayStruct.MMonMM_EMGvafsPerFold);
            AcrossDays.MMonMP_EMGvafsPerFold = cat(1,AcrossDays.MMonMP_EMGvafsPerFold,SingleDayStruct.MMonMP_EMGvafsPerFold);
            AcrossDays.EMGnames=cat(1, AcrossDays.EMGnames,IsoMidBinned.emgguide);
        end
    end
    % --------------------------------------------------------------------
    
    % Save workspace variables in the Basefolder --------------------------
  %  save([foldername 'KOAnalyzedVariables_' monkeyname '_' SubFolder{z}] )
    KO_Plot_VAF_comparison_barplots_Jango
    suptitle([monkeyname ' | ' SubFolder{z}])
   % SaveFigure(foldername, ['KO_VAF_summary_' monkeyname '_' SubFolder{z}])
    %close
    % --------------------------------------------------------------------
    
    % Make EMG tuning curves
    [EMGmean_IsoMid, EMGste_IsoMid] = KO_GetEMGMeanAndSTE_DuringHold(IsoMidBinned);
    [EMGmean_IsoProne, EMGste_IsoProne] = KO_GetEMGMeanAndSTE_DuringHold(IsoProneBinned);
    KO_PolarEMGTuningCurves(2,EMGmean_IsoMid,EMGste_IsoMid,IsoMidBinned,EMGmean_IsoProne,EMGste_IsoProne,IsoProneBinned)
    suptitle([monkeyname ' | Isometric | ' SubFolder{z}])
  %  SaveFigure(foldername, ['KO_EMGtuning_Iso_' monkeyname '_' SubFolder{z}]); close
    [EMGmean_MoveMid, EMGste_MoveMid] = KO_GetEMGMeanAndSTE_DuringHold(MoveMidBinned);
    [EMGmean_MoveProne, EMGste_MoveProne] = KO_GetEMGMeanAndSTE_DuringHold(MoveProneBinned);
    KO_PolarEMGTuningCurves(2,EMGmean_MoveMid,EMGste_MoveMid,MoveMidBinned,EMGmean_MoveProne,EMGste_MoveProne,MoveProneBinned);
    suptitle([monkeyname ' | Movement |  ' SubFolder{z}])
  %  SaveFigure(foldername, ['KO_EMGtuning__Move_' monkeyname '_' SubFolder{z}]); close;
    
    
    clearvars -except AcrossDays monkeyname SubFolder BaseFolder
    
end
    
% Save all variables
%save('C:\Stephanie\Data\KOfollowup\Jango\AcrossDayData');
    
end
    