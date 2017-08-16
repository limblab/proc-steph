function [NewTrajX, NewTrajY, NewTargetNumber]=First_X_trajectoriesToEachTarget(TrajectoriesX,TrajectoriesY,TargetNumber)



% Put the trajectories back together with their corresponding target number
X=10;
NewTrajX=[]; NewTrajY=[];NewTargetNumber=[];
for Tgt=1:8
    TargetIndices=find(TargetNumber==Tgt);
    if length(TargetIndices)>X
        TargetIndices=TargetIndices(1:10);
    end
    SingleTargetTrajX=TrajectoriesX(TargetIndices,:);
    SingleTargetTrajY=TrajectoriesY(TargetIndices,:);
    NewTrajX=cat(1,NewTrajX,SingleTargetTrajX);
    NewTrajY=cat(1,NewTrajY,SingleTargetTrajY);
   SingleTarget_TargetNumber=Tgt*ones(length(SingleTargetTrajX(:,1)),1);
    NewTargetNumber=cat(1,NewTargetNumber,SingleTarget_TargetNumber);
end


end