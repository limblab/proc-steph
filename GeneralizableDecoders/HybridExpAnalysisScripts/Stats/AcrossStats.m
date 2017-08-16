%AcrossStats

% Run after running Main script and F_AcrossDayDecoderPerformance_NoFolds

% OR:
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\For Making Summary Figures\Jango_linear_vaf_results.mat')

% Stats for the across predictions for Iso actual
WonI_versus_IonI_p=signrank([MegaVAFstruct.WonI_mVAF],[MegaVAFstruct.IonI_mVAF])/2
SonI_versus_IonI_p=signrank([MegaVAFstruct.SonI_mVAF],[MegaVAFstruct.IonI_mVAF])/2

% Stats for the across predictions for Wm actual
IonW_versus_WonW_p=signrank([MegaVAFstruct.IonW_mVAF],[MegaVAFstruct.WonW_mVAF])/2
SonW_versus_WonW_p=signrank([MegaVAFstruct.SonW_mVAF],[MegaVAFstruct.WonW_mVAF])/2

% Stats for the across predictions for Spring actual
IonS_versus_SonS_p=signrank([MegaVAFstruct.IonS_mVAF],[MegaVAFstruct.SonS_mVAF])/2
WonS_versus_SonS_p=signrank([MegaVAFstruct.WonS_mVAF],[MegaVAFstruct.SonS_mVAF])/2

%------------------------------------------------------------------------------

% Stats for the hybrid predictions for Iso actual
HonI_versus_IonI_p=signrank([MegaVAFstruct.HonI_mVAF],[MegaVAFstruct.IonI_mVAF])/2

% Stats for the across predictions for Wm actual
HonW_versus_WonW_p=signrank([MegaVAFstruct.HonW_mVAF],[MegaVAFstruct.WonW_mVAF])/2

% Stats for the across predictions for Spring actual
HonS_versus_SonS_p=signrank([MegaVAFstruct.HonS_mVAF],[MegaVAFstruct.SonS_mVAF])/2

%--------------------------------------------------------------------------

% Stats for hybrid versus across
HonI_versus_WonI_p=signrank([MegaVAFstruct.HonI_mVAF],[MegaVAFstruct.WonI_mVAF])/2
HonI_versus_SonI_p=signrank([MegaVAFstruct.HonI_mVAF],[MegaVAFstruct.SonI_mVAF])/2

HonW_versus_SonW_p=signrank([MegaVAFstruct.HonW_mVAF],[MegaVAFstruct.SonW_mVAF])/2
HonW_versus_IonW_p=signrank([MegaVAFstruct.HonW_mVAF],[MegaVAFstruct.IonW_mVAF])/2

HonS_versus_IonS_p=signrank([MegaVAFstruct.HonS_mVAF],[MegaVAFstruct.IonS_mVAF])/2
HonS_versus_WonS_p=signrank([MegaVAFstruct.HonS_mVAF],[MegaVAFstruct.WonS_mVAF])/2


% RNN versus within
RNNHonI_versus_RNNIonI_p=signrank(hybrid_rnn_Iso_vafs(1:9),within_rnn_Iso_vafs(1:9))/2
RNNHonW_versus_RNNWonW_p=signrank(hybrid_rnn_Wm_vafs(1:9),within_rnn_Wm_vafs(1:9))/2
RNNHonS_versus_RNNSonS_p=signrank(hybrid_rnn_Spr_vafs(1:9),within_rnn_Wm_vafs(1:9))/2


RNNHonI_versus_RNNIonI_p=signrank(hybrid_rnn_Iso_vafs(10:14),within_rnn_Iso_vafs(10:14))/2
RNNHonW_versus_RNNWonW_p=signrank(hybrid_rnn_Wm_vafs(10:14),within_rnn_Wm_vafs(10:14))/2
RNNHonS_versus_RNNSonS_p=signrank(hybrid_rnn_Spr_vafs(10:14),within_rnn_Wm_vafs(10:14))/2


%------------------------------------------------------------------------------

% SSE ratio stats

%The SSE ratio for the Hybrid decoder ranged from 0.53-0.79 for Monkey J and 0.70 and 0.85 for Monkey K,
%all better than the Across decoders, except for Spring data predicted by the Isometric decoder for Monkey J,
% but consistently poorer than the Within performance (p>0.005).







