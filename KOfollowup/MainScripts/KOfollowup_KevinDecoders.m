function KOfollowup_KevinDecoders
% Loads Jango KO files, processes, makes predictions, saves pred values

% Initialize file variables
monkeyname = 'Kevin';
BaseFolder = 'C:\Stephanie\Data\KOfollowup\Kevin\';
SubFolder = {'06-09-2015','06-11-2015','06-15-2015','06-25-2015'};

% For loop to open each SubFolder file and analyze data
for z = 1:length(SubFolder)
    % Load data into workspace | Open folder directory for saving figs 
    foldername = [BaseFolder SubFolder{z} '\'];
    load([foldername 'KOBinnedVariables_' monkeyname '_' SubFolder{z}]);
    
    % Make sure the datasets have the same set of neurons ----------------
    [IsoMidBinned,IsoProneBinned]=SameNeuronsAcrossBinnedDataFiles(IsoMidBinned,IsoProneBinned);
    [IsoMidBinned,MoveMidBinned]=SameNeuronsAcrossBinnedDataFiles(IsoMidBinned,MoveMidBinned);
    [IsoMidBinned,MoveProneBinned]=SameNeuronsAcrossBinnedDataFiles(IsoMidBinned,MoveProneBinned);
    [IsoProneBinned,MoveMidBinned]=SameNeuronsAcrossBinnedDataFiles(IsoProneBinned,MoveMidBinned);
    [IsoProneBinned,MoveProneBinned]=SameNeuronsAcrossBinnedDataFiles(IsoProneBinned,MoveProneBinned);
    [MoveMidBinned,MoveProneBinned]=SameNeuronsAcrossBinnedDataFiles(MoveMidBinned,MoveProneBinned);
    % --------------------------------------------------------------------
    
    % Pare down the Binned files to only wrist EMGs -----------------------
    FCUind = strmatch('FCU',IsoMidBinned.emgguide(1,:)); FCUind = FCUind(1);
    FCRind = strmatch('FCR',IsoMidBinned.emgguide(1,:)); FCRind = FCRind(1);
    ECUind = strmatch('ECU',IsoMidBinned.emgguide(1,:)); ECUind = ECUind(1);
    ECRind = strmatch('ECR',IsoMidBinned.emgguide(1,:)); ECRind = ECRind(1);
    EMGlist=[FCUind, FCRind, ECUind, ECRind];
    IsoMidBinned.emgguide = {'FCU','FCR','ECU','ECR'};
    IsoMidBinned.emgdatabin=IsoMidBinned.emgdatabin(:,(EMGlist));
    IsoProneBinned.emgguide = {'FCU','FCR','ECU','ECR'};
    IsoProneBinned.emgdatabin=IsoProneBinned.emgdatabin(:,(EMGlist));
    MoveMidBinned.emgguide = {'FCU','FCR','ECU','ECR'};
    MoveMidBinned.emgdatabin=MoveMidBinned.emgdatabin(:,(EMGlist));
    MoveProneBinned.emgguide = {'FCU','FCR','ECU','ECR'};
    MoveProneBinned.emgdatabin=MoveProneBinned.emgdatabin(:,(EMGlist));
    % --------------------------------------------------------------------
    
    % Truncate datasets so you have 10 minutes to train, 5 minutes to test
    % Isometric data
    IsoMidTest = cutBinnedDataFile(IsoMidBinned, 1, 12000);
    IsoMidTrain = cutBinnedDataFile(IsoMidBinned, 12001, 18000);
    IsoProneTest = cutBinnedDataFile(IsoProneBinned, 1, 12000);
    IsoProneTrain = cutBinnedDataFile(IsoProneBinned, 12001, 18000);
    % Movement data
    MoveMidTest = cutBinnedDataFile(MoveMidBinned, 1, 12000);
    MoveMidTrain = cutBinnedDataFile(MoveMidBinned, 12001, 18000);
    MoveProneTest = cutBinnedDataFile(MoveProneBinned, 1, 12000);
    MoveProneTrain = cutBinnedDataFile(MoveProneBinned, 12001, 18000);
    % --------------------------------------------------------------------
    
    % Build decoder using the 10 minute training files -------------------
    options=[]; options.UseAllInputs=1; options.PredEMGs = 1; % Set options parameters
    IsoMidModel = BuildModel(IsoMidTrain, options); % Build IsoMid Decoder
    IsoProneModel = BuildModel(IsoProneTrain, options); % Build IsoProne Decoder
    MoveMidModel = BuildModel(MoveMidTrain, options);% Build MoveMid Decoder
    MoveProneModel = BuildModel(MoveProneTrain, options); % Build MoveProne Decoder
    % --------------------------------------------------------------------
    
    % Apply decoder to the within-posture case ----------------------------
    foldlength = 30;
    % Isometric
    [~, ~, IMonIMpred, ~, ~, IMonIMactTrunk SingleDayStruct.IMonIM_EMGvafsPerFold]=OneDecoderOnManyFolds_KO(IsoMidModel,IsoMidTest,foldlength);
    % Movement
    [~, ~, MMonMM_pred, ~, ~, MMonMM_actTrunk SingleDayStruct.MMonMM_EMGvafsPerFold]=OneDecoderOnManyFolds_KO(MoveMidModel,MoveMidTest,foldlength);
    % ---------------------------------------------------------------------
    
    % Apply decoder to the across-posture case ----------------------------
    % Isometric
    [~, ~, IMonIPpred, ~, ~, IMonIPactTrunk SingleDayStruct.IMonIP_EMGvafsPerFold]=OneDecoderOnManyFolds_KO(IsoMidModel,IsoProneTest,foldlength);
    % Movement
    [~, ~, MMonMP_pred, ~, ~, MMonMP_actTrunk SingleDayStruct.MMonMP_EMGvafsPerFold]=OneDecoderOnManyFolds_KO(MoveMidModel,MoveProneTest,foldlength);
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
    save([foldername 'KOAnalyzedVariables_' monkeyname '_' SubFolder{z}] )
    KO_Plot_VAF_comparison_barplots_Kevin
    suptitle([monkeyname ' | ' SubFolder{z}])
    SaveFigure(foldername, ['KO_VAF_summary_' monkeyname '_' SubFolder{z}])
    close
    % --------------------------------------------------------------------
    
    clearvars -except AcrossDays monkeyname SubFolder BaseFolder
    
end
    
% Save all variables
save('C:\Stephanie\Data\KOfollowup\Jango\AcrossDayData');
    
end