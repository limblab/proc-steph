function PlotAcrossDay_PercentSuccess_PerTarget(monkeyname,taskType)

% Initialize variables
if strcmp(monkeyname,'Jango')
      BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
        FileName=JangoReflectedFileList();
end
        
        
 
 
% Start loop
for a=1:length(FileName)

% Load files
 load(strcat(BaseFolder,FileName{a}))
    currentFile = FileName{a};
    date = FileName{a}(1,16:21);

    NormalBC_TargetSuccess(:,a)=PercentSuccessPerTarget(binnedNormalBC,0);
    % if statement
    if (FileName{a}(end-2:end)) == 'ref'
        PerturbedBC_TargetSuccess(:,a)=PercentSuccessPerTarget(binnedReflectedBC,0);
    else if (FileName{a}(end-2:end)) == 'rot' % else if rotated
            PerturbedBC_TargetSuccess(:,a)=PercentSuccessPerTarget(binnedRotatedBC,0);
        end
    end
    
 
% Plot ratio of target successes
% Ratio_TargetSuccess(:,a) = PerturbedBC_TargetSuccess(:,a)./NormalBC_TargetSuccess(:,a)


% Clear variables
clearvars -except BaseFolder FileName NormalBC_TargetSuccess PerturbedBC_TargetSuccess

end


% Plot percent success separately for each target across days
subplotLocations = [15 9 3 7 11 17 23 19];
figure
for T=1:8
   locale= subplotLocations(T);
subplot(5,5,locale); hold on
%plot(NormalBC_TargetSuccess(T,:),'k.','MarkerSize',15)
plot(PerturbedBC_TargetSuccess(T,:),'r.','MarkerSize',15)
title(strcat(['Target ', num2str(T)]))
ylim([0 1])
xlim([0 9])
end


