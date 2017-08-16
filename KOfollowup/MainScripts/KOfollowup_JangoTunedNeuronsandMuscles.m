function KOfollowup_JangoTunedNeuronsandMuscles

% Initialize file variables
monkeyname = 'Jango';
BaseFolder = 'C:\Stephanie\Data\KOfollowup\Jango\';
SubFolder = {'07-28-2015','08-01-2015','08-07-2015','08-19-2015','09-01-2015','09-30-2015'};

% For loop to open each SubFolder file and analyze data
%for z = 1:length(SubFolder)
    z=1
    % Load data into workspace | Open folder directory for saving figs 
    foldername = [BaseFolder SubFolder{z} '\'];
    load([foldername 'KOBDFVariables_' monkeyname '_' SubFolder{z}]);
    
    % Pare down the BDFs to only wrist EMGs -----------------------
    FCUind = strmatch('EMG_FCU',out_struct_IsoMid.emg.emgnames(:,1)); FCUind = FCUind(1);
    FCRind = strmatch('EMG_FCR',out_struct_IsoMid.emg.emgnames(:,1)); FCRind = FCRind(1);
    ECUind = strmatch('EMG_ECU',out_struct_IsoMid.emg.emgnames(:,1)); ECUind = ECUind(1);
    ECRbind = strmatch('EMG_ECRb',out_struct_IsoMid.emg.emgnames(:,1)); ECRbind = ECRbind(1);
    ECRlind = strmatch('EMG_ECRl',out_struct_IsoMid.emg.emgnames(:,1)); ECRlind = ECRlind(1);
    EMGlist=[1 FCUind+1, FCRind+1, ECUind+1, ECRbind+1, ECRlind+1];
    out_struct_IsoMid.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECRb','EMG_ECRl'}';
    out_struct_IsoMid.emg.data =  out_struct_IsoProne.emg.data(:,EMGlist);
    out_struct_IsoProne.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECRb','EMG_ECRl'}';
    out_struct_IsoProne.emg.data =  out_struct_IsoProne.emg.data(:,EMGlist);
    out_struct_MoveMid.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECRb','EMG_ECRl'}';
    out_struct_MoveMid.emg.data =  out_struct_MoveMid.emg.data(:,EMGlist);
    out_struct_MoveProne.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECRb','EMG_ECRl'}';
    out_struct_MoveProne.emg.data =  out_struct_MoveProne.emg.data(:,EMGlist);

    % --------------------------------------------------------------------

    % Make sure the BDFs have the same set of neurons ----------------
    [out_struct_IsoMid,out_struct_IsoProne]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_IsoProne);
    [out_struct_IsoMid,out_struct_MoveMid]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_MoveMid);
    [out_struct_IsoMid,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_MoveProne);
    [out_struct_IsoProne,out_struct_MoveMid]=SameNeuronsAcrossBDFs(out_struct_IsoProne,out_struct_MoveMid);
    [out_struct_IsoProne,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_IsoProne,out_struct_MoveProne);
    [out_struct_MoveMid,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_MoveMid,out_struct_MoveProne);
    
    % Get meanFRandTheta during hold time for neurons
    [meanFRandTheta_IsoMid] = KO_GetNeuralActivity_DuringHold_MeanAcrossTrials(out_struct_IsoMid);
    [meanFRandTheta_IsoProne] = KO_GetNeuralActivity_DuringHold_MeanAcrossTrials(out_struct_IsoProne);
    
    % Calculate PD and Rsquared
    [PD_R_P(:,1),PD_R_P(:,2),PD_R_P(:,3)] = PDcalculation(meanFRandTheta_IsoMid);
    TunedNeuronIndices=(find(Pvalue<=0.02));
    
     
     