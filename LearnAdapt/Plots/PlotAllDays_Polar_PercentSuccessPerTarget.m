 

% not done

% BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BDF_and_Binned\';
% FileName = {'LongPert_Jango_073115_bdfs_binned_ref.mat', 'LongPert_Jango_080915_bdfs_binned_ref',...
%     'LongPert_Jango_082415_bdfs_binned_ref',...
%      'LongPert_Jango_090615_bdfs_binned_ref','LongPert_Jango_092515_bdfs_binned_ref'};

BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BDFs_and_Binned\';
FileName = {'ShortPert_Kevin_040215_bdfs_binned_ref','ShortPert_Kevin_040615_bdfs_binned_ref',...
    'ShortPert_Kevin_041515_bdfs_binned_ref','ShortPert_Kevin_042015_bdfs_binned_ref',...
'ShortPert_Kevin_042315_bdfs_binned_ref','LongPert_Kevin_050215_bdfs_binned_ref', 'LongPert_Kevin_061415_bdfs_binned_ref',...
    'LongPert_Kevin_062515_bdfs_binned_ref'};
BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BDFs_and_Binned\';


 %Start loop
for a=1:length(FileName)
    
    % Load files
    load(strcat(BaseFolder,FileName{a}))
    currentFile = FileName{a};
    date = FileName{a}(1,16:21);
    
    
     
    if (FileName{a}(1:4))== 'Shor'
        figure; 
        PercentSuccessPerTarget(binnedNormal3,1,'','k')
        hold on
        PercentSuccessPerTarget(binnedReflected3,1,'Jango %success','m')
    else   if (FileName{a}(1:4))== 'Long'
            figure; 
            PercentSuccessPerTarget(binnedNormalBC,1,'','k')
            hold on
            PercentSuccessPerTarget(binnedReflectedBC,1,'Jango %success','m')
            
        end
        
    end
    
    title(strcat('Jango',num2str(date)));
    
    clearvars -except BaseFolder FileName
end


