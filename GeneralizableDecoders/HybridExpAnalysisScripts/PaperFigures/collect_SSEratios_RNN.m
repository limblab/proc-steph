function SSEratio = collect_SSEratios_RNN(monkeyname)
% Ratio of SSE


%old data
% BaseFolder = 'C:\Users\LimbLabSteph\Dropbox\HybridData\Results\';
% SubFolder = {'RNN3_JangoGDdata_07242014_results3','RNN3_JangoGDdata_07252014_results3',...
%     'RNN3_JangoGDdata_08192014_results3','RNN3_JangoGDdata_08202014_results3',...
%     'RNN3_JangoGDdata_08212014_results3','RNN3_JangoGDdata_09232014_results3',...
%     'RNN3_JangoGDdata_10102014_results3','RNN3_JangoGDdata_10112014_results3',...
%     'RNN3_JangoGDdata_10122014_results3'};
% 
% 

if strcmp(monkeyname,'Jango')
BaseFolder = 'C:\Users\LimbLabSteph\Dropbox\HybridData\Results\Updates\Individual_Days\';
SubFolder = {'RNN_JangoGDdata4_072414_results2','RNN_JangoGDdata4_072514_results2',...
    'RNN_JangoGDdata4_081914_results2','RNN_JangoGDdata4_082014_results2',...
    'RNN_JangoGDdata4_082114_results2','RNN_JangoGDdata4_092314_results2',...
    'RNN_JangoGDdata4_101014_results2','RNN_JangoGDdata4_101114_results2',...
    'RNN_JangoGDdata4_101214_results2'};
end

% BaseFolder = 'C:\Users\LimbLabSteph\Dropbox\HybridData\Results\';
% SubFolder = {'RNN3_KevinGDdata_05192015_results3','RNN3_KevinGDdata_05212015_results3',...
%     'RNN3_KevinGDdata_05252015_results3','RNN3_KevinGDdata_05262015_results3',...
%     'RNN3_KevinGDdata_06042015_results3'};

for a=1:length(SubFolder)
    load([BaseFolder SubFolder{a}]);

% Hybrid ratios
SSEratio.HonI(a)=calculateSSEratio(pred_hybrid_rnn_mm_Iso,pred_within_rnn_mm_Iso,actual_Iso);
SSEratio.HonW(a)=calculateSSEratio(pred_hybrid_rnn_mm_Wm,pred_within_rnn_mm_Wm,actual_Wm);
SSEratio.HonS(a)=calculateSSEratio(pred_hybrid_rnn_mm_Spr,pred_within_rnn_mm_Spr,actual_Spr);

clearvars -except BaseFolder SubFolder SSEratio

end

end

