%LearnAdapt_OfflinePredictions (Created 8/8/16)
function LearnAdapt_OfflinePredictions(binnedData)
% This script makes offline Neuron->EMG->Force predictions
% Saves intermediate EMG predictions as well as force predictions

% Pare down binnedData to only include the 4 wrist muscles used


params.hp_rc = 0; opts.fillen = 0.5;
opts.UseAllInputs=1;opts.PolynomialOrder=0; opts.PredEMG=1;

% Build neuron to EMG model
N2E  = BuildModel(binnedData,opts);

% Build EMG to force model
opts.PredEMG=0; opts.PredForce=1; 
E2F  = BuildModel(train_data_subset,opts);


 data.emgs = [pred; data.emgs(1:end-1,:)];
                % force predictions:
                data.curs_pred = rowvec(data.emgs(:))'*emg_decoder.H;