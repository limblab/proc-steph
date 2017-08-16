%SSE_stats


 SSEratio = collect_SSEratios('Jango')
 SSEratio = collect_SSEratios('Kevin')
 
% Stats for comparing SSE ratio for linear hybrid to SSE ratios for across
% Iso
SSElin_HonI_versus_WonI_p=signrank([SSEratio.HonI],[SSEratio.WonI])/2
SSElin_HonI_versus_SonI_p=signrank([SSEratio.HonI],[SSEratio.SonI])/2

% Wm
SSElin_HonW_versus_IonW_p=signrank([SSEratio.HonW],[SSEratio.IonW])/2
SSElin_HonW_versus_SonW_p=signrank([SSEratio.HonW],[SSEratio.SonW])/2

% Spr
SSElin_HonS_versus_IonS_p=signrank([SSEratio.HonS],[SSEratio.IonS])/2
SSElin_HonS_versus_WonS_p=signrank([SSEratio.HonS],[SSEratio.WonS])/2


% Stats for comparing SSE ratio for linear hybrid to SSE ratios for within
% Iso
SSElin_HonI_versus_IonI_p=signrank([SSEratio.HonI],[ones(1,length(SSEratio.HonI))])/2
SSElin_HonW_versus_WonW_p=signrank([SSEratio.HonW],[ones(1,length(SSEratio.HonI))])/2
SSElin_HonS_versus_SonS_p=signrank([SSEratio.HonS],[ones(1,length(SSEratio.HonI))])/2