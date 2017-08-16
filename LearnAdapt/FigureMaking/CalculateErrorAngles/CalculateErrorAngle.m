function ErrorAngles_TargetNum=CalculateErrorAngle(TrajX,TrajY,TargetNum,TargetNumberPerTrial,BaselineVector,StartPointA)

  BaselineVector=BaselineVector(TargetNum,:);
        
  Targetindices = find(TargetNumberPerTrial==TargetNum);
  for b=1:length(Targetindices)
      ind=Targetindices(b);
      %meanPointA=[TrajX(ind,1) TrajY(ind,1)]; use common starting point.
      meanPointB=[TrajX(ind,end) TrajY(ind,end)];
      CurrentVector = meanPointB-StartPointA;
      % Find the angle between the two vectors
      %Equation: acos ( dot product of the two vectors ) / (product of vector magnitude)
      dProduct = dot(CurrentVector,BaselineVector);
      NormProduct = norm(CurrentVector)*norm(BaselineVector);
      ErrorAngles_TargetNum(b,:) = radtodeg(acos(dProduct/NormProduct));      
  end

 
end