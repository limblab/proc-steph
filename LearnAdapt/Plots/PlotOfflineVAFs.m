function PlotOfflineVAFs

BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BDF_and_Binned\';
FileName = {'LongPert_Jango_073115_bdfs_binned_ref.mat', 'LongPert_Jango_080915_bdfs_binned_ref',...
    'LongPert_Jango_082415_bdfs_binned_ref',...
     'LongPert_Jango_090615_bdfs_binned_ref','LongPert_Jango_092515_bdfs_binned_ref'};
 
 
% BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BDFs_and_Binned\';
% FileName = {'ShortPert_Kevin_040215_bdfs_binned_ref','ShortPert_Kevin_040615_bdfs_binned_ref',...
%     'ShortPert_Kevin_041515_bdfs_binned_ref','ShortPert_Kevin_042015_bdfs_binned_ref',...
% 'ShortPert_Kevin_042315_bdfs_binned_ref','LongPert_Kevin_050215_bdfs_binned_ref', 'LongPert_Kevin_061415_bdfs_binned_ref',...
%     'LongPert_Kevin_062515_bdfs_binned_ref'};
%  
%  Start loop
for a=1:length(FileName)
    
    % Load files
    load(strcat(BaseFolder,FileName{a}))
    currentFile = FileName{a};
    date = FileName{a}(1,16:21);
    
     % Build decoders-------------------------------------------------------
    % Normal and reflected decoders from hand control
    [N2E, E2F_normal] = BuildDecodersFromHandControl(binnedIsoHC);
    
     [HC_PredEMGs, HC_PredForce] = ApplyCascadeDecoders(binnedIsoHC, N2E, E2F_normal);

     ForceVAFs(:,a)=calculateVAF(HC_PredForce,binnedIsoHC.cursorposbin(14:end,:));
     
     EMGVAFs(:,a)=calculateVAF(HC_PredEMGs,binnedIsoHC.emgdatabin(10:end,:));
     
     % options.EMGcascade=1;options.fillen=0.5;options.foldlength=60;options.plotflag=1;
    % [~,EMGVAFs_mf(:,a)]=mfxval(binnedIsoHC,options);
     
     clearvars -except BaseFolder FileName ForceVAFs EMGVAFs EMGVAFs_mf
end

figure; hold on;ylim([0 1]);xlim([0 9])
for b=1:length(FileName)
    plot(b, ForceVAFs(1,b), '*k','MarkerSize',8);
     plot(b, ForceVAFs(2,b), 'ok','MarkerSize',5);
       plot(b, EMGVAFs(1,b), '.b','MarkerSize',15);
        plot(b, EMGVAFs(2,b), '.c','MarkerSize',15);
         plot(b, EMGVAFs(3,b), '.r','MarkerSize',15);
        plot(b, EMGVAFs(4,b), '.m','MarkerSize',15);
end
MillerFigure
% Jango
xlim([0 6])
set(gca,'Xtick',1:5,'XTickLabel',{'0731','0809', '0824','0906','0925'})
legend('XForce','YForce','FCU','FCR','ECU','ECR')
%Kevin
set(gca,'Xtick',1:8,'XTickLabel',{'0402','0406', '0415','0420','0423','0502','0614','0625'})
legend('XForce','YForce','FCU','FCR','ECU','ECR')
legend boxoff


     
     
     
     