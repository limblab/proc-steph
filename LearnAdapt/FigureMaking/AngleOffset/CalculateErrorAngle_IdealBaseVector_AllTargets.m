function ErrorAngles_TargetNum=CalculateErrorAngle_IdealBaseVector_AllTargets(TrajX,TrajY,TargetNum,TargetNumberPerTrial,TargetCenters)

BaseEndPointB=TargetCenters(TargetNum,:);
        
  Targetindices = find(TargetNumberPerTrial==TargetNum);
  for b=1:length(Targetindices)
      ind=Targetindices(b);
      StartPointA=[TrajX(ind,1) TrajY(ind,1)];
      %Actual trial
      ActualEndPointB=[TrajX(ind,end) TrajY(ind,end)];
      CurrentVector = ActualEndPointB-StartPointA;
      %Baseline trial
      % The end point of the baseline vector is the center of the target.
      % It's an ideal vector of where teh trajectory should go
      BaselineVector=BaseEndPointB-StartPointA;
      
      % Find the angle between the two vectors
      %Equation: acos ( dot product of the two vectors ) / (product of vector magnitude)
      dProduct = dot(CurrentVector,BaselineVector);
      NormProduct = norm(CurrentVector)*norm(BaselineVector);
      ErrorAngles_TargetNum(b,:) = radtodeg(acos(dProduct/NormProduct));      
  end

 
end