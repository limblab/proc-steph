
function [PercentSuccessPerTarget, IndividualTrialSuccess]=PlotHypotheticalSuccessWithPerturbation(monkeyname,taskType)

%PlotHypotheticalSuccessWithPerturbation('Jango','ref')
%PlotHypotheticalSuccessWithPerturbation('Jango','rot')
%PlotHypotheticalSuccessWithPerturbation('Kevin','ref')
%PlotHypotheticalSuccessWithPerturbation('Kevin','rot')


if strcmp(monkeyname,'Kevin')
    BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\';
    SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\WithinSessionMetrics\';
    if strcmp(taskType,'ref')
        SubFolder=KevinReflectedFileList('both');
    end
    if strcmp(taskType,'rot')
        SubFolder=KevinRotatedFileList('both');
    end
else if strcmp(monkeyname,'Jango')
        BaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\';
        SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Jango\WithinSessionMetrics\';
        if strcmp(taskType,'ref')
            SubFolder=JangoReflectedFileList();
        end
        if strcmp(taskType,'rot')
            SubFolder=JangoRotatedFileList();
        end
    end
end


for a=1:length(SubFolder)
    load(strcat(BaseFolder,SubFolder{a}))
    saveFolder=strcat(SaveBaseFolder,SubFolder{a},'\');
    MonkeyandDate=SubFolder{a}(10:22);
    pertType=SubFolder{a}(end-2:end); % Either 'rot' or 'ref'
    sessionType = SubFolder{a}(1:4);
    
    for b=1
        % Set up binnedPerturbation depending on if it was a rot or ref day
        if strcmp(sessionType,'Shor')
            binnedNormalBC=eval(strcat('binnedNormal',num2str(b)));
            blockNumber = num2str(b);
        else if strcmp(sessionType,'Long')
                blockNumber='';
            end
        end
        if strcmp(pertType,'ref')
            E2F_perturbation=E2F_reflected;
            taskType='Reflected';
            if strcmp(sessionType,'Shor')
                binnedPerturbation=eval(strcat('binnedReflected',num2str(b)));
            else if strcmp(sessionType,'Long')
                    binnedPerturbation=binnedReflectedBC;
                end
            end
        end
        if strcmp(pertType,'rot')
            E2F_perturbation=E2F_rotated;
            taskType = 'Rotated';
            if strcmp(sessionType,'Shor')
                binnedPerturbation=eval(strcat('binnedRotated',num2str(b)));
            else if strcmp(sessionType,'Long')
                    binnedPerturbation=binnedRotatedBC;
                end
            end
        end
    end
     
    [IndividualTrialSuccess{a,1},PercentSuccessPerTarget(a,:)]=PlotHandControlThroughFES_TargetSuccess(binnedIsoHC, binnedPerturbation,N2E, E2F_perturbation);
    TickFix
    
end

% Plot percent success separately for each target across days
colors = [ 0 .6 1; 1 .4 0];
colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
subplotLocations = [15 9 3 7 11 17 23 19];
figure
for Tgt=1:8
    location= subplotLocations(Tgt);
    subplot(5,5,location); hold on
    for Day=1:length(PercentSuccessPerTarget(:,1))
        plot(Day,PercentSuccessPerTarget(Day,Tgt),'.','Color',colors(Tgt,:),'MarkerSize',12)
    end
    title(strcat(['Target ', num2str(Tgt)]))
    MillerFigure;
    ylim([0 1]);xlim([0 length(PercentSuccessPerTarget(:,1))+1]);
    set(gca,'Ytick',0:.2:1.0),set(gca,'Xtick',0:1:7)
end
MillerFigure

