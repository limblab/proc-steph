function PlotPercentSuccessWithoutHold(binnedData)
% This script calculates percent success without a hold time, meaning that
% if the monkey went in the target even briefly, we count that as a success

% Isolate trialtable into its own variable
tt=binnedData.trialtable;
badTrials = find(tt(:,7)==-1); tt(badTrials,:)=[];
Target = tt(:,1:5);

% Look through the trials
TrialSuccess = zeros(length(tt),2);
width = Target(1,4)-Target(1,2);
for a=1:length(tt)
    GoCue=[]; TrialEnd = []; TrialIndices=[]; TrialForcePreds=[];
    % Find go cue and trial end time for each trial
    GoCue = tt(a,7);   TrialEnd = tt(a,8);
    TrialIndices = find(binnedData.timeframe>=GoCue & binnedData.timeframe<=TrialEnd);
    CursorPosition = binnedData.cursorposbin(TrialIndices,:);
    
    % Put target number in trialsuccess variable
    TrialSuccess(a,2)=tt(a,10);
    
    % Loop through the trial time and see if he gets into the target
    for b=1:length(CursorPosition)
        % Check: Is X force between the X boundaries of the BC target
        if CursorPosition(b,1)>=Target(a,2) && CursorPosition(b,1)<=Target(a,4)
            % If Yes, Check: Is Y force between the Y boundaries of the target
            if CursorPosition(b,2)<=Target(a,3) && CursorPosition(b,2)>=Target(a,5)
                TrialSuccess(a,1)=1;
                continue
            end
        end
    end
end

for c=1:8 %num of targets
    TargetIndex=[];
    TargetIndex = find(TrialSuccess(:,2)==c);
    TotalTrials=length(TargetIndex);
    NumOfSuccesses=sum(TrialSuccess(TargetIndex,1));
    PercentSuccessPerTarget(c,1) = NumOfSuccesses/TotalTrials;
end


PercentSuccessPerTarget(9)=PercentSuccessPerTarget(1);

theta = degtorad(0:45:360);
polarplot(theta,PercentSuccessPerTarget,'m-*','MarkerSize',5,'LineWidth',1.2)
% In Matlab 2017
%rlim([0 1]);thetaticks(0:45:360)
%thetaticklabels({'1','2','3','4','5','6','7','8'})

% If I wanted to plot the targets:
%rectangle('Position',[Target(a,2) Target(a,3)-width width width]);
    


