function [meanEMGForPDtarget, stdEMGForPDtarget] = KO_PlotEMGsForPDtarget(FRandTheta)

% Find the PD for each EMG
 PD=PDcalculation(FRandTheta);

% Find the target that is closest to the PD
TargetLocations = 0:45:360;
thetavals = -pi:pi/4:pi-pi/4;
for a=1:length(PD)
    Target_PD(a) = find(abs(PD(a)-TargetLocations) == min(abs(PD(a)-TargetLocations)));
    if Target_PD(a) == 9
        Target_PD(a)=1;
    end
end

% Only look at EMG during different epochs for the preferred target 
%(loop over EMG)

Theta_PD=thetavals(Target_PD);
for b=1:length(Theta_PD);
    indices = find(FRandTheta(:,2,b)== Theta_PD(b));
    EMGvalsForTarget = FRandTheta(indices,1,b);
    meanEMGForPDtarget(b,1)= mean(EMGvalsForTarget);
    stdEMGForPDtarget(b,1)= std(EMGvalsForTarget);
    TargetIndices = []; EMGvalsForTarget=[];
end


