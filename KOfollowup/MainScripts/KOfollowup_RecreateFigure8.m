function KOfollowup_RecreateFigure8

% Initialize file variables
monkeyname = 'Jango';
BaseFolder = 'C:\Stephanie\Data\KOfollowup\Jango\';
SubFolder = {'07-28-2015','08-01-2015','08-07-2015','08-19-2015','09-01-2015','09-30-2015'};
SubFolder = {'07-28-2015'};
%SubFolder = {'08-07-2015','08-19-2015','09-01-2015','09-30-2015'};
% % Initialize file variables
%  monkeyname = 'Kevin';
%  BaseFolder = 'C:\Stephanie\Data\KOfollowup\Kevin\';
% % SubFolder = {'06-09-2015','06-11-2015','06-15-2015','06-25-2015'};
% SubFolder = {'06-11-2015','06-15-2015','06-25-2015'};

% For loop to open each SubFolder file and analyze data
for z = 1:length(SubFolder)
    % Load data into workspace | Open folder directory for saving figs
    foldername = [BaseFolder SubFolder{z} '\'];
    load([foldername 'KO_Sorted_BDFVariables_' monkeyname '_' SubFolder{z}]);
    load([foldername 'KOBootstrappedPDs_' monkeyname '_' SubFolder{z}]);
    load([foldername 'KO_Sorted_BinnedVariables_' monkeyname '_' SubFolder{z}]);
    
    if monkeyname == 'Jango'
        % Pare down the BDFs to only wrist EMGs -----------------------
        FCUind = strmatch('EMG_FCU',out_struct_IsoMid.emg.emgnames(:,1)); FCUind = FCUind(1);
        FCRind = strmatch('EMG_FCR',out_struct_IsoMid.emg.emgnames(:,1)); FCRind = FCRind(1);
        ECUind = strmatch('EMG_ECU',out_struct_IsoMid.emg.emgnames(:,1)); ECUind = ECUind(1);
        ECRbind = strmatch('EMG_ECRb',out_struct_IsoMid.emg.emgnames(:,1)); ECRbind = ECRbind(1);
        ECRlind = strmatch('EMG_ECRl',out_struct_IsoMid.emg.emgnames(:,1)); ECRlind = ECRlind(1);
        EMGlist=[1 FCUind+1, FCRind+1, ECUind+1, ECRbind+1, ECRlind+1];
        out_struct_IsoMid.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECRb','EMG_ECRl'}';
        out_struct_IsoMid.emg.data =  out_struct_IsoMid.emg.data(:,EMGlist);
        out_struct_IsoProne.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECRb','EMG_ECRl'}';
        out_struct_IsoProne.emg.data =  out_struct_IsoProne.emg.data(:,EMGlist);
        out_struct_MoveMid.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECRb','EMG_ECRl'}';
        out_struct_MoveMid.emg.data =  out_struct_MoveMid.emg.data(:,EMGlist);
        out_struct_MoveProne.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECRb','EMG_ECRl'}';
        out_struct_MoveProne.emg.data =  out_struct_MoveProne.emg.data(:,EMGlist);
        
        % Normalize the EMG data
        [IsoMidBinned, IsoProneBinned] = NormalizeEMGsAcross2Tasks(IsoMidBinned, IsoProneBinned);
        [MoveMidBinned, MoveProneBinned] = NormalizeEMGsAcross2Tasks(MoveMidBinned, MoveProneBinned);
        
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
        
    else if monkeyname == 'Kevin'
            % Pare down the BDFs to only wrist EMGs -----------------------
            FCUind = strmatch('EMG_FCU',out_struct_IsoMid.emg.emgnames(1,:)); FCUind = FCUind(1);
            FCRind = strmatch('EMG_FCR',out_struct_IsoMid.emg.emgnames(1,:)); FCRind = FCRind(1);
            ECUind = strmatch('EMG_ECU',out_struct_IsoMid.emg.emgnames(1,:)); ECUind = ECUind(1);
            ECRind = strmatch('EMG_ECR',out_struct_IsoMid.emg.emgnames(1,:)); ECRind = ECRind(1);
            EMGlist=[1 FCUind+1, FCRind+1, ECUind+1, ECRind+1];
            out_struct_IsoMid.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECR'}';
            out_struct_IsoMid.emg.data =  out_struct_IsoMid.emg.data(:,EMGlist);
            out_struct_IsoProne.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECR'}';
            out_struct_IsoProne.emg.data =  out_struct_IsoProne.emg.data(:,EMGlist);
            out_struct_MoveMid.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECR'}';
            out_struct_MoveMid.emg.data =  out_struct_MoveMid.emg.data(:,EMGlist);
            out_struct_MoveProne.emg.emgnames= {'EMG_FCU','EMG_FCR','EMG_ECU','EMG_ECR'}';
            out_struct_MoveProne.emg.data =  out_struct_MoveProne.emg.data(:,EMGlist);
            
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
        end
    end
    
    % Cut out the 0 unit fields to get rid of non-neurons
    out_struct_IsoMid=ClearNonNeurons(out_struct_IsoMid);
    out_struct_IsoProne=ClearNonNeurons(out_struct_IsoProne);
    out_struct_MoveMid=ClearNonNeurons(out_struct_MoveMid);
    out_struct_MoveProne=ClearNonNeurons(out_struct_MoveProne);
    
    % Make sure the BDFs have the same set of neurons ----------------
%     [out_struct_IsoMid,out_struct_IsoProne]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_IsoProne);
%     [out_struct_IsoMid,out_struct_MoveMid]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_MoveMid);
%     [out_struct_IsoMid,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_MoveProne);
%     [out_struct_IsoProne,out_struct_MoveMid]=SameNeuronsAcrossBDFs(out_struct_IsoProne,out_struct_MoveMid);
%     [out_struct_IsoProne,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_IsoProne,out_struct_MoveProne);
%     [out_struct_MoveMid,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_MoveMid,out_struct_MoveProne);
    
    % Get the index of the neurons with small confidence bounds
    % (+-25degrees)
    [~,ConfidentNeuronInd_IsoMid] = KO_FindConfidenceBounds(PD_IsoMidHold);
    [~,ConfidentNeuronInd_IsoProne] = KO_FindConfidenceBounds(PD_IsoProneHold);
    [~,ConfidentNeuronInd_MoveMid] = KO_FindConfidenceBounds(PD_MoveMidHold);
    [~,ConfidentNeuronInd_MoveProne] = KO_FindConfidenceBounds(PD_MoveProneHold);
    
    % Find the common high confidence neurons for both iso conditions, and
    % both movement conditions separately
    [ConfidentNeuronsForAllIso]=intersect(ConfidentNeuronInd_IsoMid,ConfidentNeuronInd_IsoProne);
    [ConfidentNeuronsForAllMovement]=intersect(ConfidentNeuronInd_MoveMid,ConfidentNeuronInd_MoveProne);
    
    % Get the indices for the significantly tuned neurons
    Tuned_IsoMid = KO_FindSignificantlyTunedNeurons(out_struct_IsoMid);
    Tuned_IsoProne = KO_FindSignificantlyTunedNeurons(out_struct_IsoProne);
    [TunedNeuronsForAllIso]=intersect(Tuned_IsoMid,Tuned_IsoProne);
    Tuned_MoveMid = KO_FindSignificantlyTunedNeurons(out_struct_MoveMid);
    Tuned_MoveProne = KO_FindSignificantlyTunedNeurons(out_struct_MoveProne);
    [TunedNeuronsForAllMovement]=intersect(Tuned_MoveMid,Tuned_MoveProne);
    
    % Find the neurons that are both confident and tuned
    [ConfidentAndTunedIsoNeurons]= intersect(ConfidentNeuronsForAllIso, TunedNeuronsForAllIso);
    [ConfidentAndTunedMoveNeurons]= intersect(ConfidentNeuronsForAllMovement, TunedNeuronsForAllMovement);
    
    % Pare down the out_struct neuron list to only include high confidence
    % neurons
    out_struct_IsoMid.units=out_struct_IsoMid.units(ConfidentAndTunedIsoNeurons);
    out_struct_IsoProne.units=out_struct_IsoProne.units(ConfidentAndTunedIsoNeurons);
    out_struct_MoveMid.units=out_struct_MoveMid.units(ConfidentAndTunedMoveNeurons);
    out_struct_MoveProne.units=out_struct_MoveProne.units(ConfidentAndTunedMoveNeurons);
    
    
       
% Get Neural Activity During Epochs for Iso
boot=0;
postGoTime1=150; postGoTime2=250; postGoTime3=350;postGoTime4=450;
[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoMid, postGoTime1,boot); [PD_IsoMid1] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoProne, postGoTime1,boot); [PD_IsoProne1] = PDcalculation(FRandTheta_IsoProne);
dPD_Iso1 = CircularSubtraction(PD_IsoMid1,PD_IsoProne1);

[FRandTheta_IsoMid_EMG1] = KO_GetEMGmean_DuringEpoch(IsoMidBinned, postGoTime1); [PD_IsoMid1_EMG] = PDcalculation(FRandTheta_IsoMid_EMG1);
[FRandTheta_IsoProne_EMG1] = KO_GetEMGmean_DuringEpoch(IsoProneBinned, postGoTime1); [PD_IsoProne1_EMG] = PDcalculation(FRandTheta_IsoProne_EMG1);
dPD_Iso1_EMG = CircularSubtraction(PD_IsoMid1_EMG,PD_IsoProne1_EMG);

[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoMid, postGoTime2,boot); [PD_IsoMid2] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoProne, postGoTime2,boot); [PD_IsoProne2] = PDcalculation(FRandTheta_IsoProne);
dPD_Iso2 = CircularSubtraction(PD_IsoMid2,PD_IsoProne2);
[FRandTheta_IsoMid_EMG2] = KO_GetEMGmean_DuringEpoch(IsoMidBinned, postGoTime2); [PD_IsoMid2_EMG] = PDcalculation(FRandTheta_IsoMid_EMG2);
[FRandTheta_IsoProne_EMG2] = KO_GetEMGmean_DuringEpoch(IsoProneBinned, postGoTime2); [PD_IsoProne2_EMG] = PDcalculation(FRandTheta_IsoProne_EMG2);
dPD_Iso2_EMG = CircularSubtraction(PD_IsoMid2_EMG,PD_IsoProne2_EMG);

[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoMid, postGoTime3,boot); [PD_IsoMid3] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoProne, postGoTime3,boot); [PD_IsoProne3] = PDcalculation(FRandTheta_IsoProne);
dPD_Iso3 = CircularSubtraction(PD_IsoMid3,PD_IsoProne3);
[FRandTheta_IsoMid_EMG3] = KO_GetEMGmean_DuringEpoch(IsoMidBinned, postGoTime3); [PD_IsoMid3_EMG] = PDcalculation(FRandTheta_IsoMid_EMG3);
[FRandTheta_IsoProne_EMG3] = KO_GetEMGmean_DuringEpoch(IsoProneBinned, postGoTime3); [PD_IsoProne3_EMG] = PDcalculation(FRandTheta_IsoProne_EMG3);
dPD_Iso3_EMG = CircularSubtraction(PD_IsoMid3_EMG,PD_IsoProne3_EMG);

[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoMid, postGoTime4,boot); [PD_IsoMid4] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoProne, postGoTime4,boot); [PD_IsoProne4] = PDcalculation(FRandTheta_IsoProne);
dPD_Iso4 = CircularSubtraction(PD_IsoMid4,PD_IsoProne4);
[FRandTheta_IsoMid_EMG4] = KO_GetEMGmean_DuringEpoch(IsoMidBinned, postGoTime4); [PD_IsoMid4_EMG] = PDcalculation(FRandTheta_IsoMid_EMG4);
[FRandTheta_IsoProne_EMG4] = KO_GetEMGmean_DuringEpoch(IsoProneBinned, postGoTime4); [PD_IsoProne4_EMG] = PDcalculation(FRandTheta_IsoProne_EMG4);
dPD_Iso4_EMG = CircularSubtraction(PD_IsoMid4_EMG,PD_IsoProne4_EMG);

[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringHold(out_struct_IsoMid,boot);[PD_IsoMidHold] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringHold(out_struct_IsoProne,boot);[PD_IsoProneHold] = PDcalculation(FRandTheta_IsoProne);
dPD_IsoHold = CircularSubtraction(PD_IsoMidHold, PD_IsoProneHold);
[FRandTheta_IsoMid_EMGHold] = KO_GetEMGActivity_DuringHold(IsoMidBinned);[PD_IsoMidHold_EMGHold] = PDcalculation(FRandTheta_IsoMid_EMGHold);
[FRandTheta_IsoProne_EMGHold] = KO_GetEMGActivity_DuringHold(IsoProneBinned);[PD_IsoProneHold_EMGHold] = PDcalculation(FRandTheta_IsoProne_EMGHold); 
dPD_IsoHold_EMG = CircularSubtraction(PD_IsoMidHold_EMGHold, PD_IsoProneHold_EMGHold);

 % Get Neural Activity During Epochs for Movement
[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveMid, postGoTime1,boot); [PD_MoveMid1] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveProne, postGoTime1,boot); [PD_MoveProne1] = PDcalculation(FRandTheta_MoveProne);
dPD_Move1 = CircularSubtraction(PD_MoveMid1,PD_MoveProne1);
[FRandTheta_MoveMid_EMG1] = KO_GetEMGmean_DuringEpoch(MoveMidBinned, postGoTime1); [PD_MoveMid1_EMG] = PDcalculation(FRandTheta_MoveMid_EMG1);
[FRandTheta_MoveProne_EMG1] = KO_GetEMGmean_DuringEpoch(MoveProneBinned, postGoTime1); [PD_MoveProne1_EMG] = PDcalculation(FRandTheta_MoveProne_EMG1);
dPD_Move1_EMG = CircularSubtraction(PD_MoveMid1_EMG,PD_MoveProne1_EMG);

[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveMid, postGoTime2,boot); [PD_MoveMid2] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveProne, postGoTime2,boot); [PD_MoveProne2] = PDcalculation(FRandTheta_MoveProne);
dPD_Move2 = CircularSubtraction(PD_MoveMid2,PD_MoveProne2);
[FRandTheta_MoveMid_EMG2] = KO_GetEMGmean_DuringEpoch(MoveMidBinned, postGoTime2); [PD_MoveMid2_EMG] = PDcalculation(FRandTheta_MoveMid_EMG2);
[FRandTheta_MoveProne_EMG2] = KO_GetEMGmean_DuringEpoch(MoveProneBinned, postGoTime2); [PD_MoveProne2_EMG] = PDcalculation(FRandTheta_MoveProne_EMG2);
dPD_Move2_EMG = CircularSubtraction(PD_MoveMid2_EMG,PD_MoveProne2_EMG);

[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveMid, postGoTime3,boot); [PD_MoveMid3] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveProne, postGoTime3,boot); [PD_MoveProne3] = PDcalculation(FRandTheta_MoveProne);
dPD_Move3 = CircularSubtraction(PD_MoveMid3,PD_MoveProne3);
[FRandTheta_MoveMid_EMG3] = KO_GetEMGmean_DuringEpoch(MoveMidBinned, postGoTime3); [PD_MoveMid3_EMG] = PDcalculation(FRandTheta_MoveMid_EMG3);
[FRandTheta_MoveProne_EMG3] = KO_GetEMGmean_DuringEpoch(MoveProneBinned, postGoTime3); [PD_MoveProne3_EMG] = PDcalculation(FRandTheta_MoveProne_EMG3);
dPD_Move3_EMG = CircularSubtraction(PD_MoveMid3_EMG,PD_MoveProne3_EMG);

[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveMid, postGoTime4,boot); [PD_MoveMid4] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveProne, postGoTime4,boot); [PD_MoveProne4] = PDcalculation(FRandTheta_MoveProne);
dPD_Move4 = CircularSubtraction(PD_MoveMid4,PD_MoveProne4);
[FRandTheta_MoveMid_EMG4] = KO_GetEMGmean_DuringEpoch(MoveMidBinned, postGoTime4); [PD_MoveMid4_EMG] = PDcalculation(FRandTheta_MoveMid_EMG4);
[FRandTheta_MoveProne_EMG4] = KO_GetEMGmean_DuringEpoch(MoveProneBinned, postGoTime4); [PD_MoveProne4_EMG] = PDcalculation(FRandTheta_MoveProne_EMG4);
dPD_Move4_EMG = CircularSubtraction(PD_MoveMid4_EMG,PD_MoveProne4_EMG);

[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringHold(out_struct_MoveMid,boot);[PD_MoveMidHold] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringHold(out_struct_MoveProne,boot);[PD_MoveProneHold] = PDcalculation(FRandTheta_MoveProne);
dPD_MoveHold = CircularSubtraction(PD_MoveMidHold, PD_MoveProneHold);
[FRandTheta_MoveMid_EMGHold] = KO_GetEMGActivity_DuringHold(MoveMidBinned);[PD_MoveMidHold_EMGHold] = PDcalculation(FRandTheta_MoveMid_EMGHold);
[FRandTheta_MoveProne_EMGHold] = KO_GetEMGActivity_DuringHold(MoveProneBinned);[PD_MoveProneHold_EMGHold] = PDcalculation(FRandTheta_MoveProne_EMGHold); 
dPD_MoveHold_EMG = CircularSubtraction(PD_MoveMidHold_EMGHold, PD_MoveProneHold_EMGHold);


% Plot
figure; hold on
plot([1 2 3 4 5], [(dPD_Iso1) (dPD_Iso2) (dPD_Iso3)  (dPD_Iso4) (dPD_IsoHold)],'k.-','MarkerSize',15);
title([monkeyname SubFolder(z) 'Iso | Fig 8a recreated']); MillerFigure; ylabel('dPD (degrees)'); xlabel('Time of epoch start (ms after go cue');
set(gca,'XTick',1:5);set(gca,'XTickLabel',({'1', '2', '3', '4', 'Hold'}));

figure; hold on;
plot([1 2 3 4 5], [mean(dPD_Iso1) mean(dPD_Iso2) mean(dPD_Iso3)  mean(dPD_Iso4) mean(dPD_IsoHold)],'k.-','MarkerSize',15);
title('Mean Across All Neurons')


figure;hold on;
for a=3:length(dPD_Iso1)
    Neurontracemean= mean([dPD_Iso1(a) dPD_Iso2(a) dPD_Iso3(a)  dPD_Iso4(a) dPD_IsoHold(a)]);
    plot([1 2 3 4 5], [dPD_Iso1(a) dPD_Iso2(a) dPD_Iso3(a)  dPD_Iso4(a) dPD_IsoHold(a)]-Neurontracemean,'k.-','MarkerSize',15);
    dPDcentered_data(a,:)=[dPD_Iso1(a) dPD_Iso2(a) dPD_Iso3(a)  dPD_Iso4(a) dPD_IsoHold(a)]-Neurontracemean;
end
title('Iso | Fig 8B recreated');MillerFigure;

figure;hold on;
plot(mean(dPDcentered_data),'k.-','LineWidth',2,'MarkerSize',15)
Stdcentered_dPD_data=std(dPDcentered_data);
errorbar(1:5,mean(dPDcentered_data),Stdcentered_dPD_data)
Colors=['r','m','g','b','c'];
for a=1:length(dPD_Iso1_EMG)
    EMGtracemean= mean([dPD_Iso1_EMG(a) dPD_Iso2_EMG(a) dPD_Iso3_EMG(a)  dPD_Iso4_EMG(a) dPD_IsoHold_EMG(a)]);
    plot([1 2 3 4 5], [dPD_Iso1_EMG(a) dPD_Iso2_EMG(a) dPD_Iso3_EMG(a)  dPD_Iso4_EMG(a) dPD_IsoHold_EMG(a)]-EMGtracemean,strcat(Colors(a), '.-'),'MarkerSize',15);
end
title([monkeyname SubFolder(z) 'Iso | Fig 8C recreated']);MillerFigure;
set(gca,'XTick',1:5);set(gca,'XTickLabel',({'1', '2', '3', '4', 'Hold'}));
xlabel('Time of epoch start (ms after go cue)');
legend('Neurons','','FCU','FCR','ECU','ECR');
ylim([-60 60])




%-----------------------------------------------------------------------------

figure;hold on;
for a=1:length(dPD_Move1)
    Neurontracemean= mean([(dPD_Move1(a)) (dPD_Move2(a)) (dPD_Move3(a))  dPD_Move4(a) dPD_MoveHold(a)]);
    plot([1 2 3 4 5], [(dPD_Move1(a)) (dPD_Move2(a)) (dPD_Move3(a))  (dPD_Move4(a)) dPD_MoveHold(a)]-Neurontracemean,'k.-','MarkerSize',15);
    dPDcentered_data(a,:)=[(dPD_Move1(a)) (dPD_Move2(a)) (dPD_Move3(a))  (dPD_Move4(a)) dPD_MoveHold(a)]-Neurontracemean;
end
title([monkeyname SubFolder(z) 'Move | Fig 8B recreated']);MillerFigure;

figure;hold on;
plot(mean(dPDcentered_data),'k.-','LineWidth',2,'MarkerSize',15)
Stdcentered_dPD_data=std(dPDcentered_data);
errorbar(1:5,mean(dPDcentered_data),Stdcentered_dPD_data)
Colors=['r','m','g','b','c'];
for a=1:length(dPD_Move1_EMG)
    EMGtracemean= mean([(dPD_Move1_EMG(a)) (dPD_Move2_EMG(a)) (dPD_Move3_EMG(a))  (dPD_Move4_EMG(a)) dPD_MoveHold_EMG(a)]);
    plot([1 2 3 4 5], [(dPD_Move1_EMG(a)) (dPD_Move2_EMG(a)) (dPD_Move3_EMG(a))  (dPD_Move4_EMG(a)) dPD_MoveHold_EMG(a)]-EMGtracemean,strcat(Colors(a), '.-'),'MarkerSize',15);
end
title([monkeyname SubFolder(z) 'Move | Fig 8C recreated']);MillerFigure;
set(gca,'XTick',1:5);set(gca,'XTickLabel',({'1', '2', '3', '4', 'Hold'}));
legend('Neurons','','FCU','FCR','ECU','ECR');
xlabel('Time of epoch start (ms after go cue');
ylim([-60 60])



% Plot EMGs for their preferred direction
[meanEMGForPDtarget_MoveMid1, stdEMGForPDtargetMoveMid1] = KO_PlotEMGsForPDtarget(FRandTheta_MoveMid_EMG1);
[meanEMGForPDtarget_MoveMid2, stdEMGForPDtargetMoveMid2] = KO_PlotEMGsForPDtarget(FRandTheta_MoveMid_EMG2);
[meanEMGForPDtarget_MoveMid3, stdEMGForPDtargetMoveMid3] = KO_PlotEMGsForPDtarget(FRandTheta_MoveMid_EMG3);
[meanEMGForPDtarget_MoveMid4, stdEMGForPDtargetMoveMid4] = KO_PlotEMGsForPDtarget(FRandTheta_MoveMid_EMG4);
[meanEMGForPDtarget_MoveMidHold, stdEMGForPDtargetMoveMidHold] = KO_PlotEMGsForPDtarget(FRandTheta_MoveMid_EMGHold);

[meanEMGForPDtarget_MoveProne1, stdEMGForPDtargetMoveProne1] = KO_PlotEMGsForPDtarget(FRandTheta_MoveProne_EMG1);
[meanEMGForPDtarget_MoveProne2, stdEMGForPDtargetMoveProne2] = KO_PlotEMGsForPDtarget(FRandTheta_MoveProne_EMG2);
[meanEMGForPDtarget_MoveProne3, stdEMGForPDtargetMoveProne3] = KO_PlotEMGsForPDtarget(FRandTheta_MoveProne_EMG3);
[meanEMGForPDtarget_MoveProne4, stdEMGForPDtargetMoveProne4] = KO_PlotEMGsForPDtarget(FRandTheta_MoveProne_EMG4);
[meanEMGForPDtarget_MoveProneHold, stdEMGForPDtargetMoveProneHold] = KO_PlotEMGsForPDtarget(FRandTheta_MoveProne_EMGHold);

figure; hold on;Colors=['r','m','g','b','c'];
for EMGind = 1:length(meanEMGForPDtarget_MoveMid1)
plot(1:5, [meanEMGForPDtarget_MoveMid1(EMGind), meanEMGForPDtarget_MoveMid2(EMGind),meanEMGForPDtarget_MoveMid3(EMGind),meanEMGForPDtarget_MoveMid4(EMGind),meanEMGForPDtarget_MoveMidHold(EMGind)],strcat(Colors(EMGind),'.-'),'MarkerSize',15)
plot(1:5, [meanEMGForPDtarget_MoveProne1(EMGind), meanEMGForPDtarget_MoveProne2(EMGind),meanEMGForPDtarget_MoveProne3(EMGind),meanEMGForPDtarget_MoveProne4(EMGind),meanEMGForPDtarget_MoveProneHold(EMGind)],strcat(Colors(EMGind),'o-'),'MarkerSize',5)
end
ylim([0 1]); xlim([1 5]); MillerFigure
set(gca,'XTick',1:5);set(gca,'XTickLabel',({'1', '2', '3', '4', 'Hold'}));
title([monkeyname SubFolder(z) 'Mean EMG For Its Preferred Direction'])
legend('FCU mid','FCU prone','FCR','FCR','ECU','ECU','ECR','ECR');
legend boxoff



%--------------------------------------
% 
%  plot(5, mean(dPD_IsoHold-mean(all_IsoPDs,2)),'k.','MarkerSize',15);plot(5, mean(dPD_MoveHold-mean(all_MovePDs,2)),'g.','MarkerSize',15);
% MillerFigure; ylabel('dPD (degrees)'); xlabel('Time of epoch start (ms after go cue');
% set(gca,'XTick',1:5);set(gca,'XTickLabel',({'1', '2', '3', '4', 'Hold'}));
% title(['dPD2' monkeyname '_' SubFolder{z}])

clearvars -except SubFolder monkeyname BaseFolder

end
    