%TestHCdecoderOnReflectedBrainData

% Load that one good reflected day from Kevin

train_data = convert2BDF2Binned;

train_data=binnedData;
% Build decoder from hand control
options=[]; options.PredEMG=0; options.PredCursPos=1; options.PredVeloc = 0; options.fillen=0.5;
% Only use 4 emgs
FCUind = strmatch('FCU',train_data.emgguide(1,:)); FCUind = FCUind(1);
FCRind = strmatch('FCR',train_data.emgguide(1,:)); FCRind = FCRind(1);
ECUind = strmatch('ECU',train_data.emgguide(1,:)); ECUind = ECUind(1);
ECRind = strmatch('ECR',train_data.emgguide(1,:)); ECRind = ECRind(1);
emg_vector = [FCUind FCRind ECUind ECRind];
train_data_subset = train_data;
train_data_subset.emgdatabin = train_data.emgdatabin(:,emg_vector);
train_data_subset.emgguide = train_data.emgguide(emg_vector);

% Build neuron to EMG model
N2E  = BuildModel(train_data_subset,options);
% %opts = BuildModelGUI; %(in=EMG, out=cursor position, ***PAY ATTENTION length = 250ms****, polyn order=0 )
% Build EMG to Force model
E2F  = BuildModel(train_data_subset,options);
%--------------------------------------------------------------------------

% Load data for perturbation and isolate the 4 muscles
FCUind = strmatch('FCU',train_data.emgguide(1,:)); FCUind = FCUind(1);
FCRind = strmatch('FCR',train_data.emgguide(1,:)); FCRind = FCRind(1);
ECUind = strmatch('ECU',train_data.emgguide(1,:)); ECUind = ECUind(1);
ECRind = strmatch('ECR',train_data.emgguide(1,:)); ECRind = ECRind(1);
emg_vector = [FCUind FCRind ECUind ECRind];
binnedData.emgdatabin = binnedData.emgdatabin(:,emg_vector);
binnedData.emgguide = binnedData.emgguide(emg_vector);

% Test decoder on 
[PredData_EMGs, varargout] = predictSignals(N2E, binnedData);

[PredData_Force, varargout] = predictSignals(E2F, PredData_EMGs);
