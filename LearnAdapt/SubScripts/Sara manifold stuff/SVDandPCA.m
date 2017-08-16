
% make the filter using MIMO3

% only use 4 emgs
FCUind = strmatch('FCU',binnedData.emgguide(1,:)); FCUind = FCUind(1);
FCRind = strmatch('FCR',binnedData.emgguide(1,:)); FCRind = FCRind(1);
ECUind = strmatch('ECU',binnedData.emgguide(1,:)); ECUind = ECUind(1);
ECRind = strmatch('ECR',binnedData.emgguide(1,:)); ECRind = ECRind(1);
emg_vector = [FCUind FCRind ECUind ECRind];
binnedData_subset = binnedData;
binnedData_subset.emgdatabin = binnedData.emgdatabin(:,emg_vector);
binnedData_subset.emgguide = binnedData.emgguide(emg_vector);

% Load N2E filter
% Normal:
load('C:\Stephanie\Data\LearnAdapt\ManifoldAnalysis\Jango_EMGBC_20150826_SN_20150826_141206_002_Binned250ms4EMGs.mat')
load('C:\Stephanie\Data\LearnAdapt\ManifoldAnalysis\Jango_EMGBC_20150826_SN_20150826_141206_002_Binned250ms4EMGs_Decoder.mat')

% Rotated:
load('C:\Stephanie\Data\LearnAdapt\ManifoldAnalysis\Jango_EMGBC_20150826_003_Rotated_Binned250ms4EMGs.mat')
load('C:\Stephanie\Data\LearnAdapt\ManifoldAnalysis\Jango_EMGBC_20150826_003_Rotated_Binned250ms4EMGs_Decoder.mat')


% SVD calculations---------------------------------------------------------
filter.H(1,:)=[]; % get rid of extra row
A=filter.H'; % A dimensions are 4xN where N=#ofneurons (~96)
[U,S,V] = svd(A);

% Get neural data (250ms bins)
NormalNeurons=binnedData.spikeratedata; % dimensions are Timestamps x N

v4=S*V;   % 4xN = 4xN * N*N
for ind=1:length(NormalNeurons(:,1))
    n=(NormalNeurons(ind,:))'; % Nx1 matrix for FR of all neurons for one timestamp
    alphas(ind,:)=v4*n;
end
% alphas ends up being Observations x 4 matrix

% PCA----------------------------------------------------------------------
[coeff,score,latent,tsquared,explained,mu] = pca(alphas);
% Calculate PCs
PCs = (alphas-repmat(mu,length(alphas(:,1)),1))*coeff;

figure; MillerFigure;
plot(NormalPCs(:,1),NormalPCs(:,2),'bv');
hold on
plot(RotatedPCs(:,1),RotatedPCs(:,2),'cv');




