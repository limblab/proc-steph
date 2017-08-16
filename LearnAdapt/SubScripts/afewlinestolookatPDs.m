
% a few lines to look at PDs

N2F_lag =10; %150ms
num_btstrp = 100; %num bootstrap rep
neural_tuning = compute_tuning_from_bin(binnedIsoHC,'emg',N2F_lag,num_btstrp,'poisson');
pd_table = get_pd_table(neural_tuning);
plot_pds_snn(pd_table);
figure
rose(pd_table.dir) 