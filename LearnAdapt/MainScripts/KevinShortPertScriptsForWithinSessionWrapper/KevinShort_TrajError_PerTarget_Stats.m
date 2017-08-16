function Tp=KevinShort_TrajError_PerTarget_Stats(binnedPerturbation1,binnedPerturbation2,binnedPerturbation3,SecAfterGo);


[TrajX1, TrajY1, TargetNumberPerTrial1] = TrajectoriesStarting200AfterGo(binnedPerturbation1,SecAfterGo);
[TrajX2, TrajY2, TargetNumberPerTrial2] = TrajectoriesStarting200AfterGo(binnedPerturbation2,SecAfterGo);
[TrajX3, TrajY3, TargetNumberPerTrial3] = TrajectoriesStarting200AfterGo(binnedPerturbation3,SecAfterGo);

TrajX=cat(1,TrajX1, TrajX2, TrajX3);
TrajY = cat(1,TrajY1, TrajY2, TrajY3);
TargetNumberPerTrial=cat(1, TargetNumberPerTrial1,TargetNumberPerTrial2,TargetNumberPerTrial3);

TargetCenters1=FindTargetCenter(binnedPerturbation1);
TargetCenters2=FindTargetCenter(binnedPerturbation2);
TargetCenters3=FindTargetCenter(binnedPerturbation3);

TargetCenters=cat(1,TargetCenters1,TargetCenters2,TargetCenters3);

ErrorAngles_Target1=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,1,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target2=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,2,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target3=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,3,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target4=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,4,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target5=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,5,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target6=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,6,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target7=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,7,TargetNumberPerTrial,TargetCenters);
ErrorAngles_Target8=CalculateErrorAngle_IdealBaseVector(TrajX,TrajY,8,TargetNumberPerTrial,TargetCenters);

% Stats signrank
numSamples=10;
Tp(1)=signrank(ErrorAngles_Target1(1:numSamples),ErrorAngles_Target1(end-numSamples+1:end));
Tp(2)=signrank(ErrorAngles_Target2(1:numSamples),ErrorAngles_Target2(end-numSamples+1:end));
Tp(3)=signrank(ErrorAngles_Target3(1:numSamples),ErrorAngles_Target3(end-numSamples+1:end));
Tp(4)=signrank(ErrorAngles_Target4(1:numSamples),ErrorAngles_Target4(end-numSamples+1:end));
Tp(5)=signrank(ErrorAngles_Target5(1:numSamples),ErrorAngles_Target5(end-numSamples+1:end));
Tp(6)=signrank(ErrorAngles_Target6(1:numSamples),ErrorAngles_Target6(end-numSamples+1:end));
Tp(7)=signrank(ErrorAngles_Target7(1:numSamples),ErrorAngles_Target7(end-numSamples+1:end));
Tp(8)=signrank(ErrorAngles_Target8(1:numSamples),ErrorAngles_Target8(end-numSamples+1:end));
Tp=Tp';
Tp=Tp./2;


end

