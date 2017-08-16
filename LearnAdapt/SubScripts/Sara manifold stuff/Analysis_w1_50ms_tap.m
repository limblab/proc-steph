
% Build decoders with one tap
% Let's pick a day
% Kevin 6/14
% N2E decoder from 6/14
% E2F decoder is from 6/9
 

load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_061415_binnedDec_ref.mat')
load('Z:\data\Kevin_12A2\FES\BinnedData\KOfollowup\06-09-2015\Kevin_IsoBoxCO_HC_SpikesEMGs_06092015_SN_001.mat')
% Loading this file doesn't help because the EMGs/Forces are not normalized
binnedData0609=binnedData;

% Now calculate decoder weights using 1 tap
options=[]; options.PredEMGs = 1; options.fillen = 0.05;
N2E_1tap = BuildModel(binnedIsoHC, options);


FCUind = strmatch('FCU',binnedData.emgguide(1,:)); FCUind = FCUind(1);
FCRind = strmatch('FCR',binnedData.emgguide(1,:)); FCRind = FCRind(1);
ECUind = strmatch('ECU',binnedData.emgguide(1,:)); ECUind = ECUind(1);
ECRind = strmatch('ECR',binnedData.emgguide(1,:)); ECRind = ECRind(1);
emg_vector = [FCUind FCRind ECUind ECRind];
binnedData_subset = binnedData;
binnedData_subset.emgdatabin = binnedData.emgdatabin(:,emg_vector);
binnedData_subset.emgguide = binnedData.emgguide(emg_vector);

% Build EMG to Force model
options.Use_EMGs=1; options.PredCursPos=1; options.PredEMGs=0; options.fillen=0.05;
E2F_1tap  = BuildModel(binnedData_subset,options);

% Make reflected EMG to Force decoder--------------------------------------
FCRweightsInd = strmatch('FCR',N2E.outnames(1,:));
ECRweightsInd = strmatch('ECR',N2E.outnames(1,:));
noOfWeights = 1;
FCRindices = fliplr((noOfWeights*FCRweightsInd:-1:noOfWeights*FCRweightsInd-noOfWeights+1));
FCR2Fweights = E2F_1tap.H(FCRindices,:);
ECRindices = fliplr((noOfWeights*ECRweightsInd:-1:noOfWeights*ECRweightsInd-noOfWeights+1));
ECR2Fweights = E2F_1tap.H(ECRindices,:);
E2F_1tap_reflected = E2F_1tap;
E2F_1tap_reflected.H(ECRindices,:) = FCR2Fweights;
E2F_1tap_reflected.H(FCRindices,:) = ECR2Fweights;
%--------------------------------------------------------------------------





% PERTURBATION DECODER APPLIED TO NORMAL NEURAL ACTIVITY --------------
[~, PertDecoder_NormBrain_Pos] = ApplyCascadeDecoders_1tap(binnedNormalBC, N2E_1tap, E2F_1tap);
[PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain]= InitialTrajectories_UsingPredictions(binnedNormalBC,PertDecoder_NormBrain_Pos,.5);
plotInitialTrajectoriesPerTarget(binnedNormalBC,PredTrajX_PertDec_NormBrain, PredTrajY_PertDec_NormBrain, TargetNum_PertDec_NormBrain)
      

% Possible analyses
% can use one tap thats 400ms long
