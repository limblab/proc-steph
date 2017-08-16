function ErrorAngles_TargetNum=CalculateErrorAngle_LineFit_Ideal(TrajX,TrajY,TargetNum,TargetNumberPerTrial,TargetCenters)

% A: actual
% B: ideal

BaseEndPointB=TargetCenters(TargetNum,:);
        
  Targetindices = find(TargetNumberPerTrial==TargetNum);
  for b=1:length(Targetindices)
      ind=Targetindices(b);
      
      % LineFit
      x=TrajX(b,:)';
      y=TrajY(b,:)';
      X=[ones(length(x),1),x];
      coeff=X\y;      
      yCalc2=X*coeff;
      ActualStartPointA=[x(1) yCalc2(1)];
      %If you want to plot plot(x,yCalc2,'k--')
      ActualEndPointB=[x(end) yCalc2(end)];
      CurrentVector = ActualEndPointB-ActualStartPointA;
      
      %Baseline trial
      % The end point of the baseline vector is the center of the target.
      % It's an ideal vector of where the trajectory should go
      BaselineVector=BaseEndPointB-ActualStartPointA;
      
      % Find the angle between the two vectors
      %Equation: acos ( dot product of the two vectors ) / (product of vector magnitude)
      dProduct = dot(CurrentVector,BaselineVector);
      NormProduct = norm(CurrentVector)*norm(BaselineVector);
      ErrorAngles_TargetNum(b,:) = radtodeg(acos(dProduct/NormProduct));      
  end

 
end