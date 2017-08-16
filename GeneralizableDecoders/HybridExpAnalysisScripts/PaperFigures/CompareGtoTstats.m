% Modified hybrid decoder stats

%Jango
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\Updates\jango_gt_mvafs.mat')
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\Updates\vaf_results_rnn.mat')
Indices=[1:9];

% Kevin
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\Updates\kevin_gt_mvafs.mat')
load('C:\Users\LimbLabSteph\Dropbox\HybridData\Results\Updates\vaf_results_rnn.mat')
Indices=[10:14];



% Compare GT to the RNN
GT_versus_RNN_Iso_p=signrank([mvafs_tg_Iso],[hybrid_rnn_Iso_vafs(Indices)])/2
GT_versus_RNN_Wm_p=signrank([mvafs_tg_Wm],[hybrid_rnn_Wm_vafs(Indices)])/2
GT_versus_RNN_Spr_p=signrank([mvafs_tg_Spr],[hybrid_rnn_Spr_vafs(Indices)])/2

% Compare G to T
G_versus_T_Iso_p=signrank([mvafs_g_Iso],[mvafs_t_Iso])/2
G_versus_T_Wm_p=signrank([mvafs_g_Wm],[mvafs_t_Wm])/2
G_versus_T__Sprp=signrank([mvafs_g_Spr],[mvafs_t_Spr)/2


mean(mvafs_w_Iso)/mean(hybrid_rnn_Iso_vafs(Indices))
mean(mvafs_w_Wm)/mean(hybrid_rnn_Wm_vafs(Indices))
mean(mvafs_w_Spr)/mean(hybrid_rnn_Spr_vafs(Indices))


mean(mvafs_gt_Iso)/mean(hybrid_rnn_Iso_vafs(Indices))
mean(mvafs_gt_Wm)/mean(hybrid_rnn_Wm_vafs(Indices))
mean(mvafs_gt_Spr)/mean(hybrid_rnn_Spr_vafs(Indices))

mean(mvafs_g_Iso)/mean(hybrid_rnn_Iso_vafs(Indices))
mean(mvafs_g_Wm)/mean(hybrid_rnn_Wm_vafs(Indices))
mean(mvafs_g_Spr)/mean(hybrid_rnn_Spr_vafs(Indices))





