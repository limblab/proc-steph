function LearnAdaptWrapperForBDFs(monkeyname,saveFlag)
%LearnAdaptWrapper('Kevin',1)


if strcmp(monkeyname,'Kevin')
    BaseFolder = '';
    SaveBaseFolder = 'C:\Stephanie\Data\LearnAdapt\Kevin\Plots\';
    SubFolder={'ShorPert_Kevin_050115_bdfs_binned_rot'};
else if strcmp(monkeyname,'Jango')
        BaseFolder = '\';
        SubFolder={};
    end
end


for a=1:length(SubFolder)
    load(strcat(BaseFolder,SubFolder{a}))
    saveFolder=strcat(SaveBaseFolder,SubFolder{a},'\');
    MonkeyandDate=SubFolder{a}(10:22);
    pertType=SubFolder{a}(end-2:end); % Either 'rot' or 'ref'
    sessionType = SubFolder{a}(1:4);
    % Prepare the setup that distinguishes between the Long and Short pert
    % sessions
    if strcmp(sessionType,'Long')
        numOfblocks=1;
    else if strcmp(sessionType,'Shor')
            numOfblocks=3;
        end
    end
   
    for b=1:numOfblocks
        
        % Set up binnedPerturbation depending on if it was a rot or ref day
        if strcmp(sessionType,'Shor')
            out_struct_baseline=eval(strcat('binnedNormal',num2str(b)));
            blockNumber = num2str(b);
        else if strcmp(sessionType,'Long')
                blockNumber='';
            end
        end
        if strcmp(pertType,'ref')
            taskType='Reflected';
            if strcmp(sessionType,'Shor')
                binnedPerturbation=eval(strcat('binnedReflected',num2str(b)));
            else if strcmp(sessionType,'Long')
                    binnedPerturbation=binnedReflectedBC;
                end
            end
        end
        if strcmp(pertType,'rot')
            taskType = 'Rotated';
            if strcmp(sessionType,'Shor')
                out_struct_perturbationn=eval(strcat('out_struct_rotated',num2str(b)));
            else if strcmp(sessionType,'Long')
                    out_struct_perturbation=out_struct_rotated;
                end
            end
        end
        
        
      % TIME TO TARGET OVER TIME-----------------------------------
        Plot_T2T_AcrossTime_PerTarget(out_struct_perturbation,strcat([MonkeyandDate,taskType,' T2T']))
        SaveLearnAdaptPlots(saveFlag,saveFolder,strcat(MonkeyandDate,'T2T_',taskType,'BC',blockNumber))
        %----------------------------------------------------------------------
        