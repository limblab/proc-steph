function KOfollowup_JangoMainNeuronAnalysis

% Loads Jango KO files, processes, makes predictions, saves pred values

% Initialize file variables
monkeyname = 'Jango';
BaseFolder = 'C:\Stephanie\Data\KOfollowup\Jango\';
SubFolder = {'07-28-2015','08-01-2015','08-07-2015','08-19-2015','09-01-2015','09-30-2015'};

% Initialize file variables
% monkeyname = 'Kevin';
% BaseFolder = 'C:\Stephanie\Data\KOfollowup\Kevin\';
% SubFolder = {'06-09-2015','06-11-2015','06-15-2015','06-25-2015'};

% For loop to open each SubFolder file and analyze data
for z = 1:length(SubFolder)
    % Load data into workspace | Open folder directory for saving figs 
    foldername = [BaseFolder SubFolder{z} '\'];
    load([foldername 'KOBDFVariables_' monkeyname '_' SubFolder{z}]);
     load([foldername 'KOBinnedVariables_' monkeyname '_' SubFolder{z}]);

    % Make sure the BDFs have the same set of neurons ----------------
    [out_struct_IsoMid,out_struct_IsoProne]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_IsoProne);
    [out_struct_IsoMid,out_struct_MoveMid]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_MoveMid);
    [out_struct_IsoMid,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_MoveProne);
    [out_struct_IsoProne,out_struct_MoveMid]=SameNeuronsAcrossBDFs(out_struct_IsoProne,out_struct_MoveMid);
    [out_struct_IsoProne,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_IsoProne,out_struct_MoveProne);
    [out_struct_MoveMid,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_MoveMid,out_struct_MoveProne);
    
% Get Neural Activity During Epochs for Iso
boot=0;
[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoMid, 100,boot); [PD_IsoMid100msAfter] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoProne, 100,boot); [PD_IsoProne100msAfter] = PDcalculation(FRandTheta_IsoProne);
dPD_Iso100 = PD_IsoMid100msAfter-PD_IsoProne100msAfter;
dPD_Iso100 = PD_IsoProne100msAfter-PD_IsoMid100msAfter;

[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoMid, 400,boot); [PD_IsoMid400msAfter] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoProne, 400,boot); [PD_IsoProne400msAfter] = PDcalculation(FRandTheta_IsoProne);
dPD_Iso400 = PD_IsoMid400msAfter-PD_IsoProne400msAfter;
dPD_Iso400 = PD_IsoProne400msAfter-PD_IsoMid400msAfter;

[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoMid, 700,boot); [PD_IsoMid700msAfter] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoProne, 700,boot); [PD_IsoProne700msAfter] = PDcalculation(FRandTheta_IsoProne);
dPD_Iso700 = PD_IsoMid700msAfter-PD_IsoProne700msAfter;
dPD_Iso700 = PD_IsoProne700msAfter-PD_IsoMid700msAfter;

[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoMid, 1000,boot); [PD_IsoMid1000msAfter] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_IsoProne, 1000,boot); [PD_IsoProne1000msAfter] = PDcalculation(FRandTheta_IsoProne);
dPD_Iso1000 = PD_IsoMid1000msAfter-PD_IsoProne1000msAfter;
dPD_Iso1000 = PD_IsoProne1000msAfter-PD_IsoMid1000msAfter;

[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringHold(out_struct_IsoMid,boot);[PD_IsoMidHold] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringHold(out_struct_IsoProne,boot);[PD_IsoProneHold] = PDcalculation(FRandTheta_IsoProne);
dPD_IsoHold = PD_IsoMidHold-PD_IsoProneHold;
dPD_IsoHold = PD_IsoProneHold-PD_IsoMidHold;


 
 % Get Neural Activity During Epochs for Movement
[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveMid, 100,boot); [PD_MoveMid100msAfter] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveProne, 100,boot); [PD_MoveProne100msAfter] = PDcalculation(FRandTheta_MoveProne);
dPD_Move100 = PD_MoveMid100msAfter-PD_MoveProne100msAfter;
dPD_Move100 = PD_MoveProne100msAfter-PD_MoveMid100msAfter;

[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveMid, 400,boot); [PD_MoveMid400msAfter] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveProne, 400,boot); [PD_MoveProne400msAfter] = PDcalculation(FRandTheta_MoveProne);
dPD_Move400 = PD_MoveMid400msAfter-PD_MoveProne400msAfter;
dPD_Move400 = PD_MoveProne400msAfter-PD_MoveMid400msAfter;

[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveMid, 700,boot); [PD_MoveMid700msAfter] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveProne, 700,boot); [PD_MoveProne700msAfter] = PDcalculation(FRandTheta_MoveProne);
dPD_Move700 = PD_MoveMid700msAfter-PD_MoveProne700msAfter;
dPD_Move700 = PD_MoveProne700msAfter-PD_MoveMid700msAfter;

[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveMid, 1000,boot); [PD_MoveMid1000msAfter] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringEpoch(out_struct_MoveProne, 1000,boot); [PD_MoveProne1000msAfter] = PDcalculation(FRandTheta_MoveProne);
dPD_Move1000 = PD_MoveMid1000msAfter-PD_MoveProne1000msAfter;
dPD_Move1000 = PD_MoveProne1000msAfter-PD_MoveMid1000msAfter;

[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringHold(out_struct_MoveMid,boot);[PD_MoveMidHold] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringHold(out_struct_MoveProne,boot);[PD_MoveProneHold] = PDcalculation(FRandTheta_MoveProne);
dPD_MoveHold = PD_MoveMidHold-PD_MoveProneHold;
dPD_MoveHold = PD_MoveProneHold-PD_MoveMidHold;


% Plot
figure; hold on
 plot([1 2 3 4], [mean(dPD_Iso100) mean(dPD_Iso400) mean(dPD_Iso700)  mean(dPD_Iso1000)],'k.-','MarkerSize',15);
plot([1 2 3 4], [mean(dPD_Move100) mean(dPD_Move400)  mean(dPD_Move700)  mean(dPD_Move1000)],'g.-','MarkerSize',15); 
plot(5, mean(dPD_IsoHold),'k.','MarkerSize',15);plot(5, mean(dPD_MoveHold),'g.','MarkerSize',15);
MillerFigure; ylabel('dPD (degrees)'); xlabel('Time of epoch start (ms after go cue');
set(gca,'XTick',1:5);set(gca,'XTickLabel',({'100', '400', '700', '1000', 'Hold'}));
title(['dPD' monkeyname '_' SubFolder{z}])

figure; hold on
all_IsoPDs=[(dPD_Iso100) (dPD_Iso400) (dPD_Iso700)  (dPD_Iso1000) (dPD_IsoHold)];
all_MovePDs=[(dPD_Move100) (dPD_Move400)  (dPD_Move700)  (dPD_Move1000)];
 plot([1 2 3 4], [mean(dPD_Iso100-mean(all_IsoPDs,2)) mean(dPD_Iso400-mean(all_IsoPDs,2)) mean(dPD_Iso700-mean(all_IsoPDs,2))  mean(dPD_Iso1000-mean(all_IsoPDs,2))],'k.-','MarkerSize',15);
plot([1 2 3 4], [mean(dPD_Move100-mean(all_MovePDs,2)) mean(dPD_Move400-mean(all_MovePDs,2)) mean(dPD_Move700-mean(all_MovePDs,2))  mean(dPD_Move1000-mean(all_MovePDs,2))],'g.-','MarkerSize',15); 
plot(5, (dPD_IsoHold),'k.','MarkerSize',15);plot(5, (dPD_MoveHold),'g.','MarkerSize',15);
MillerFigure; ylabel('dPD (degrees)'); xlabel('Time of epoch start (ms after go cue');
set(gca,'XTick',1:5);set(gca,'XTickLabel',({'100', '400', '700', '1000', 'Hold'}));
title(['dPD' monkeyname '_' SubFolder{z}])

clearvars -except SubFolder monkeyname BaseFolder

end
