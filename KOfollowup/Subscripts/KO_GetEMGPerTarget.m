function [meanEMG] = KO_GetEMGPerTarget(FRandTheta)

thetavals = -pi:pi/4:pi-pi/4;

for a=1:8
    TargetIndices = find(FRandTheta(:,2)== thetavals(a));
    EMGvalsForTarget = FRandTheta(TargetIndices,1);
    meanEMG(a,1)= mean(EMGvalsForTarget);
    TargetIndices = []; EMGvalsForTarget=[];
end