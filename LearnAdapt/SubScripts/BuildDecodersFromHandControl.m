function [N2E, E2F_normal, E2F_reflected] = BuildDecodersFromHandControl(binnedData)
% This script takes in binnedDatafile of isometric hand control data and
% spits out the N2F and two E2F (normal and reflected) models
% Input: hand control binned 

% Make sure you are using the right EMGs
FCUind = strmatch('FCU',binnedData.emgguide(1,:)); FCUind = FCUind(1);
FCRind = strmatch('FCR',binnedData.emgguide(1,:)); FCRind = FCRind(1);
ECUind = strmatch('ECU',binnedData.emgguide(1,:)); ECUind = ECUind(1);
ECRind = strmatch('ECR',binnedData.emgguide(1,:)); ECRind = ECRind(1);
emg_vector = [FCUind FCRind ECUind ECRind];
binnedData.emgdatabin = binnedData.emgdatabin(:,emg_vector);
binnedData.emgguide = binnedData.emgguide(emg_vector);

% Build neuron to EMG model
N2E_options.PredEMGs=1; 
N2E  = BuildModel(binnedData,N2E_options);

% Build Normal EMG to Force model
E2F_options.fillen=0.25;  E2F_options.PredCursPos=1;
E2F_options.Use_EMGs=1;  E2F_options.UseAllInputs=1;
E2F_normal  = BuildModel(binnedData,E2F_options);

% Build Reflected EMG to Force model
FCRweightsInd = strmatch('FCR',N2E.outnames(1,:));
ECRweightsInd = strmatch('ECR',N2E.outnames(1,:));
noOfWeights = E2F_options.fillen/.05;
FCRindices = fliplr((noOfWeights*FCRweightsInd:-1:noOfWeights*FCRweightsInd-noOfWeights+1));
FCR2Fweights = E2F_normal.H(FCRindices,:);
ECRindices = fliplr((noOfWeights*ECRweightsInd:-1:noOfWeights*ECRweightsInd-noOfWeights+1));
ECR2Fweights = E2F_normal.H(ECRindices,:);
E2F_reflected = E2F_normal;
E2F_reflected.H(ECRindices,:) = FCR2Fweights;
E2F_reflected.H(FCRindices,:) = ECR2Fweights;

end
