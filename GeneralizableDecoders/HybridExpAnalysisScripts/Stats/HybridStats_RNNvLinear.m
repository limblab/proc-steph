HybridStats_RNNvLinear

% RNN versus Linear Hybrid Stats
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\For Making Summary Figures\Jango_linear_vaf_results.mat')
 load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\For Making Summary Figures\Kevin_linear_vaf_results.mat')
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\Updates\vaf_results_rnn.mat')

Indices=[1:9]; % for jango
Indices=[10:14]; % for kevin

% RNN v Linear
RNN_HonI_versus_Lin_HonI_p=signrank([hybrid_rnn_Iso_vafs(Indices)],[MegaVAFstruct.HonI_mVAF])/2
RNN_HonI_versus_Lin_HonW_p=signrank([hybrid_rnn_Wm_vafs(Indices)],[MegaVAFstruct.HonW_mVAF])/2
RNN_HonI_versus_Lin_HonS_p=signrank([hybrid_rnn_Spr_vafs(Indices)],[MegaVAFstruct.HonS_mVAF])/2