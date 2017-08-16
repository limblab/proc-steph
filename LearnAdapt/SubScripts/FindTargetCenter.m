  function TargetCenters=FindTargetCenter(binnedData)
  % This function finds the center of each of the 8 targets
  
  
  % Extract target info from trial table and plot targets
  trialtable = binnedData.trialtable;
  colors = distinguishable_colors(9);
  [~, TgtInd] = unique(trialtable(:,10));
  %figure; 
  %hold on; axis('square'); xlim([-14 14]); ylim([-14 14]);
  %MillerFigure;
  %rectangle('Position',[-2,-2,4,4],'EdgeColor',[0.7 0.7 0.7])
  for i=1:length(TgtInd)
      width = trialtable(TgtInd(i),4)-trialtable(TgtInd(i),2);
      height = trialtable(TgtInd(i),3)-trialtable(TgtInd(i),5);
      % Get lower left target coordinates
      LLx = trialtable(TgtInd(i),2); LLy = trialtable(TgtInd(i),5);
      %Find center
      TargetCenterX(i,1)=LLx+(width/2);
      TargetCenterY(i,1)=LLy+(height/2);
  end
  
  TargetCenters=cat(2,TargetCenterX,TargetCenterY);
  
  end