

ind =1;
figure
 PlotTargetsFromBinned(binnedOfInterest);
 hold on
 plot(TrajX(ind,:),TrajY(ind,:))
 TargetNumberPerTrial(ind)
 TargetCenters=FindTargetCenter(binnedOfInterest);
   plot([TrajX(ind,1) TargetCenters(tgt,1)],[TrajY(ind,1) TargetCenters(tgt,2)])
 
 TargetCenters(ind,:)
 plot([TrajX(ind) TargetCenters(1)],[TrajY(ind) TargetCenters(2)])
 
 ErrorAngles_Target2(ind)
 
 tgt=2;
 targetinds=find(TargetNumberPerTrial==2);
 for a=1:length(targetinds)
     b=targetinds(a);
     plot(TrajX(b,:),TrajY(b,:))
 end
  plot([TrajX(b,1) TargetCenters(tgt,1)],[TrajY(b) TargetCenters(tgt,2)])
     