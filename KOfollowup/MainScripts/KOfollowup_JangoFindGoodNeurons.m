function KOfollowup_JangoFindGoodNeurons

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
    load([foldername 'KOBootstrappedPDs_' monkeyname '_' SubFolder{z}]);

    % Make sure the BDFs have the same set of neurons ----------------
    [out_struct_IsoMid,out_struct_IsoProne]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_IsoProne);
    [out_struct_IsoMid,out_struct_MoveMid]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_MoveMid);
    [out_struct_IsoMid,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_IsoMid,out_struct_MoveProne);
    [out_struct_IsoProne,out_struct_MoveMid]=SameNeuronsAcrossBDFs(out_struct_IsoProne,out_struct_MoveMid);
    [out_struct_IsoProne,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_IsoProne,out_struct_MoveProne);
    [out_struct_MoveMid,out_struct_MoveProne]=SameNeuronsAcrossBDFs(out_struct_MoveMid,out_struct_MoveProne);
    
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
    
    % Pare down the out_struct neuron list to only include high confidence
    % neurons
    out_struct_IsoMid.units=out_struct_IsoMid.units(ConfidentNeuronsForAllIso);
    out_struct_IsoProne.units=out_struct_IsoProne.units(ConfidentNeuronsForAllIso);
    out_struct_MoveMid.units=out_struct_MoveMid.units(ConfidentNeuronsForAllMovement);
    out_struct_MoveProne.units=out_struct_MoveProne.units(ConfidentNeuronsForAllMovement);


clearvars -except SubFolder monkeyname BaseFolder

end
    
    
    
