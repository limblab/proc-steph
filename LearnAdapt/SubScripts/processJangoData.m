base='Z:\data\Jango_12a1\CerebusData\LearnAdapt\09-06-15';
load(strcat(base,'\',binnedNormalBC.meta.filename(1:end-4),'_params'),'emg_decoder')
load(strcat(base,'\',binnedNormalBC.meta.filename(1:end-4),'_params'),'neuron_decoder')
E2F_normal=emg_decoder;
N2E=neuron_decoder;
clear emg_decoder
clear neuron_decoder
% load(strcat(base,'\',binnedRotatedBC.meta.filename(1:end-4),'_params'),'emg_decoder')
% E2F_rotated=emg_decoder;
load(strcat(base,'\',binnedReflectedBC.meta.filename(1:end-4),'_params'),'emg_decoder')
E2F_reflected=emg_decoder;
clear emg_decoder
clear base 