function ErrorAngles=CalculateErrorAngle_IdealBase_AllTrials(TrajX,TrajY,TargetNumberPerTrial,TargetCenters)

  for ind=1:length(TrajX)
      StartPointA=[TrajX(ind,1) TrajY(ind,1)];
      %Actual trial
      ActualEndPointB=[TrajX(ind,end) TrajY(ind,end)];
      CurrentVector = ActualEndPointB-StartPointA;
      %Baseline trial
      % The end point of the baseline vector is the center of the target.
      % It's an ideal vector of where teh trajectory should go
      BaseEndPointB=TargetCenters(TargetNumberPerTrial(ind),:);
      BaselineVector=BaseEndPointB-StartPointA;
      
      % Find the angle between the two vectors
      %Equation: acos ( dot product of the two vectors ) / (product of vector magnitude)
      dProduct = dot(CurrentVector,BaselineVector);
      NormProduct = norm(CurrentVector)*norm(BaselineVector);
      if dProduct==0 & NormProduct == 0
          ErrorAngles(ind,:)=radtodeg(acos(0));
      else 
      ErrorAngles(ind,:) = radtodeg(acos(dProduct/NormProduct));  
      end
  end

 
end