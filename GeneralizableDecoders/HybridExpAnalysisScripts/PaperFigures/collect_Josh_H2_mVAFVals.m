function MegaVAFstruct = collect_Josh_H2_mVAFVals


BaseFolder = 'C:\Users\LimbLabSteph\Dropbox\HybridData\Results\H2Results\';
SubFolder = {'RNN3_JangoGDdata_07242014_results_h2','RNN3_JangoGDdata_07252014_results_h2', 'RNN3_JangoGDdata_08192014_results_h2',...
    'RNN3_JangoGDdata_08202014_results_h2','RNN3_JangoGDdata_08212014_results_h2','RNN3_JangoGDdata_09232014_results_h2',...
    'RNN3_JangoGDdata_10102014_results_h2','RNN3_JangoGDdata_10112014_results_h2'...
  'RNN3_JangoGDdata_10122014_results_h2'};

BaseFolder = 'C:\Users\LimbLabSteph\Dropbox\HybridData\Results\H2Results\';
SubFolder = {'RNN3_KevinGDdata_05192015_results_h2','RNN3_KevinGDdata_05212015_results_h2',...
'RNN3_KevinGDdata_05252015_results_h2', 'RNN3_KevinGDdata_05262015_results_h2',...
'RNN3_KevinGDdata_06042015_results_h2'};

for a=1:length(SubFolder)
    load([BaseFolder SubFolder{a}]);
    datalabel = SubFolder{a}(11:16);

MegaVAFstruct.Lin_H2IWonI_mVAF(a)=MultivariateVAF(pred_hybrid2_iw_lin_Iso,actual_Iso);
MegaVAFstruct.Hyb_H2IWonI_mVAF(a)=MultivariateVAF(pred_hybrid2_iw_rnn_mm_Iso,actual_Iso);
MegaVAFstruct.Lin_H2SWonI_mVAF(a)=MultivariateVAF(pred_hybrid2_sw_lin_Iso,actual_Iso);
MegaVAFstruct.Hyb_H2SWonI_mVAF(a)=MultivariateVAF(pred_hybrid2_sw_rnn_mm_Iso,actual_Iso);

MegaVAFstruct.Lin_H2IWonW_mVAF(a)=MultivariateVAF(pred_hybrid2_iw_lin_Wm,actual_Wm);
MegaVAFstruct.Hyb_H2IWonW_mVAF(a)=MultivariateVAF(pred_hybrid2_iw_rnn_mm_Wm,actual_Wm);
MegaVAFstruct.Lin_H2SWonW_mVAF(a)=MultivariateVAF(pred_hybrid2_sw_lin_Wm,actual_Wm);
MegaVAFstruct.Hyb_H2SWonW_mVAF(a)=MultivariateVAF(pred_hybrid2_sw_rnn_mm_Wm,actual_Wm);

MegaVAFstruct.Lin_H2IWonS_mVAF(a)=MultivariateVAF(pred_hybrid2_iw_lin_Spr,actual_Spr);
MegaVAFstruct.Hyb_H2IWonS_mVAF(a)=MultivariateVAF(pred_hybrid2_iw_rnn_mm_Spr,actual_Spr);
MegaVAFstruct.Lin_H2SWonS_mVAF(a)=MultivariateVAF(pred_hybrid2_sw_lin_Spr,actual_Spr);
MegaVAFstruct.Hyb_H2SWonS_mVAF(a)=MultivariateVAF(pred_hybrid2_sw_rnn_mm_Spr,actual_Spr);

clearvars -except BaseFolder SubFolder MegaVAFstruct

end

end

