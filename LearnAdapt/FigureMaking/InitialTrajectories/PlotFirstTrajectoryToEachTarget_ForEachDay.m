function PlotFirstTrajectoryToEachTarget_ForEachDay(monkeyname,taskType)
%PlotFirstTrajectoryToEachTarget_ForEachDay('Jango','rot')

% For each day, take the first trajectory to the target

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

for Day=1:length(SubFolder)
    load(strcat(BaseFolder,SubFolder{Day}))
    saveFolder=strcat(SaveBaseFolder,SubFolder{Day},'\');
    MonkeyandDate=SubFolder{Day}(10:22);
    pertType=SubFolder{Day}(end-2:end); % Either 'rot' or 'ref'
    sessionType = SubFolder{Day}(1:4);
    
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
                binnedPerturbation1=eval(strcat('binnedReflected',num2str(1)));
                binnedPerturbation2=eval(strcat('binnedReflected',num2str(2)));
                binnedPerturbation3=eval(strcat('binnedReflected',num2str(3)));
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
                binnedPerturbation1=eval(strcat('binnedRotated',num2str(1)));
                binnedPerturbation2=eval(strcat('binnedRotated',num2str(2)));
                binnedPerturbation3=eval(strcat('binnedRotated',num2str(3)));
            else if strcmp(sessionType,'Long')
                    binnedPerturbation=binnedRotatedBC;
                end
            end
        end
    end
    
[TrajectoriesX, TrajectoriesY, TargetNumber] = InitialTrajectories(binnedPerturbation,.5);

for TgtInd=1:8
    targetIndices=find(TargetNumber==TgtInd);
    FirstTrajectoryPerTargetX{Day,TgtInd} = TrajectoriesX(targetIndices(1),:);
    FirstTrajectoryPerTargetY{Day,TgtInd} = TrajectoriesY(targetIndices(1),:);
    targetIndices=[];
end

end


colors = distinguishable_colors(9); colors(8,:)=colors(9,:);
figure
PlotTargetsFromBinned(binnedNormalBC); hold on
for Day=1:length(SubFolder)
    for TgtInd=1:8
        meanX=mean(cat(1,FirstTrajectoryPerTargetX{:,TgtInd}));meanY=mean(cat(1,FirstTrajectoryPerTargetY{:,TgtInd}));
        stdX=std(cat(1,FirstTrajectoryPerTargetX{:,TgtInd})); stdY=std(cat(1,FirstTrajectoryPerTargetY{:,TgtInd}));
        upperX=meanX+stdX; upperY=meanY+stdY; lowerX=meanX-stdX; lowerY=meanY-stdY;
        plot(meanX,meanY,'Color',colors(TgtInd,:))
        %plot(upperX,upperY,'--','Color',colors(TgtInd,:))
        %plot(lowerX,lowerY,'--','Color',colors(TgtInd,:))
        % Plot all trajectories
        %plot(FirstTrajectoryPerTargetX{Day,TgtInd},FirstTrajectoryPerTargetY{Day,TgtInd},'Color',colors(TgtInd,:))
    end
end
title(strcat([monkeyname,' First traj to each target | ', taskType]))

figure
PlotTargetsFromBinned(binnedNormalBC); hold on
for Day=1:length(SubFolder)
    for TgtInd=1:8
        plot(FirstTrajectoryPerTargetX{Day,TgtInd},FirstTrajectoryPerTargetY{Day,TgtInd},'Color',colors(TgtInd,:))
    end
end

end
