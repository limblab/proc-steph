function [TrialSuccess, PercentSuccessPerTarget] = PlotHandControlThroughFES_TargetSuccess(binnedIsoHC, binnedNormalBC,N2E, E2F_normal)

% Isolate trialtable into its own variable
tt=binnedIsoHC.trialtable;
badTrials = find(tt(:,7)==-1); tt(badTrials,:)=[];

% Get the target info for the BC targets, which are bigger and closer than
% the hand control targets. Put it in the tt trialtable
ttBC=binnedNormalBC.trialtable;
for TargetInd=1:8
    BrainControlTargetInds=[];HandControlTargetInds=[];
    BrainControlTargetInds=find(ttBC(:,10)==TargetInd);
    BC_TargetStats=ttBC(BrainControlTargetInds(1),2:5);
     tt(tt(:,10)==TargetInd,2:5)=repmat(BC_TargetStats,sum(tt(:,10)==TargetInd),1);
end
Target = tt(:,1:5);

%[N2E, E2F_normal] = BuildDecodersFromHandControl(binnedIsoHC);

% Apply normal cascade decoder to hand control data
[~, ForcePreds] = ApplyCascadeDecoders(binnedIsoHC,N2E,E2F_normal);
% ForcePreds = cat(1,nan(13,2),ForcePreds); %add nans to make up for the
% missing 13 vals | commented out 5/18/2017 after I changed apply cascade
% decoders

% Look through the trials
TrialSuccess = zeros(length(tt),2);
%figure; hold on; xlim([-20 20]); ylim([-20 20])
width = Target(1,4)-Target(1,2);
for a=1:length(tt)
    GoCue=[]; TrialEnd = []; TrialIndices=[]; TrialForcePreds=[];
    % Find go cue and trial end time for each trial
    GoCue = tt(a,7);   TrialEnd = tt(a,8);
    TrialIndices = find(binnedIsoHC.timeframe>=GoCue & binnedIsoHC.timeframe<=TrialEnd);
    TrialForcePreds = ForcePreds(TrialIndices,:);
    
    % Plot traces
    %plot(TrialForcePreds(:,1),TrialForcePreds(:,2),'r')
    %RealForce = binnedIsoHC.cursorposbin(TrialIndices,:);
    %plot(RealForce(:,1),RealForce(:,2),'k')
    %rectangle('Position',[Target(a,2) Target(a,3)-width width width]);
    
    % Put target number in trialsuccess variable
    TrialSuccess(a,2)=tt(a,10);
    
    % Loop through the trial time and see if he gets into the target
    for b=1:length(TrialForcePreds)
        % Check: Is X force between the X boundaries of the BC target
        if TrialForcePreds(b,1)>=Target(a,2) && TrialForcePreds(b,1)<=Target(a,4)
            % If Yes, Check: Is Y force between the Y boundaries of the target
            if TrialForcePreds(b,2)<=Target(a,3) && TrialForcePreds(b,2)>=Target(a,5)
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
figure
polarplot(theta,PercentSuccessPerTarget,'k-*','MarkerSize',5,'LineWidth',1.2)
hold on

    


