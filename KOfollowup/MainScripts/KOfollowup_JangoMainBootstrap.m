function KOfollowup_JangoMainBootstrap

% Initialize file variables
% monkeyname = 'Jango';
% BaseFolder = 'C:\Stephanie\Data\KOfollowup\Jango\';
% SubFolder = {'07-28-2015','08-01-2015','08-07-2015','08-19-2015','09-01-2015','09-30-2015'};

%Initialize file variables
monkeyname = 'Kevin';
BaseFolder = 'C:\Stephanie\Data\KOfollowup\Kevin\';
SubFolder = {'06-11-2015','06-15-2015','06-25-2015'};
SubFolder = {'06-09-2015'};

% For loop to open each SubFolder file and analyze data
for z = 1:length(SubFolder)
    % Load data into workspace | Open folder directory for saving figs 
    foldername = [BaseFolder SubFolder{z} '\'];
    load([foldername 'KO_Sorted_BDFVariables_' monkeyname '_' SubFolder{z}]);
    
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
    
boot=1;

PD_IsoMidHold=nan(length(out_struct_IsoMid.units),1000); R2_IsoMidHold=nan(length(out_struct_IsoMid.units),1000); Pval_IsoMidHold=nan(length(out_struct_IsoMid.units),1000); 
PD_IsoProneHold=nan(length(out_struct_IsoProne.units),1000);R2_IsoProneHold=nan(length(out_struct_IsoProne.units),1000);Pval_IsoProneHold=nan(length(out_struct_IsoProne.units),1000);
PD_MoveMidHold=nan(length(out_struct_MoveMid.units),1000);R2_MoveMidHold=nan(length(out_struct_MoveMid.units),1000);Pval_MoveMidHold=nan(length(out_struct_MoveMid.units),1000);
PD_MoveProneHold=nan(length(out_struct_MoveProne.units),1000);R2_MoveProneHold=nan(length(out_struct_MoveProne.units),1000);Pval_MoveProneHold=nan(length(out_struct_MoveProne.units),1000);
for a=1:1000
[FRandTheta_IsoMid] = KO_GetNeuralActivity_DuringHold(out_struct_IsoMid,boot);[PD_IsoMidHold(:,a),R2_IsoMidHold(:,a),Pval_IsoMidHold(:,a)] = PDcalculation(FRandTheta_IsoMid);
[FRandTheta_IsoProne] = KO_GetNeuralActivity_DuringHold(out_struct_IsoProne,boot);[PD_IsoProneHold(:,a),R2_IsoProneHold(:,a),Pval_IsoProneHold(:,a)] = PDcalculation(FRandTheta_IsoProne);

[FRandTheta_MoveMid] = KO_GetNeuralActivity_DuringHold(out_struct_MoveMid,boot);[PD_MoveMidHold(:,a),R2_MoveMidHold(:,a),Pval_MoveMidHold(:,a)] = PDcalculation(FRandTheta_MoveMid);
[FRandTheta_MoveProne] = KO_GetNeuralActivity_DuringHold(out_struct_MoveProne,boot);[PD_MoveProneHold(:,a),R2_MoveProneHold(:,a),Pval_MoveProneHold(:,a)] = PDcalculation(FRandTheta_MoveProne);

end



save([foldername 'KO_NeuralData_' monkeyname '_' SubFolder{z}] )

end

end
