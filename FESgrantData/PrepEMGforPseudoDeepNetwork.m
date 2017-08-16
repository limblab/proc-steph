% Prep EMGs for Pseudo Deep Network



for a=1:14
   sortedEMG = sort(binnedData.emgdatabin(:,a));
   percentile98 = .98*sortedEMG(end);
   NormedEMG(:,a) = binnedData.emgdatabin(:,a)./percentile98;
   sortedEMG=[]; percentile98=[];
end
binnedData.emgdatabin=NormedEMG;