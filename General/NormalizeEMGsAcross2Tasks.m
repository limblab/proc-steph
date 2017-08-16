function [NormalizedBinned1, NormalizedBinned2] = NormalizeEMGsAcross2Tasks(binned1, binned2)
    
EMGs1=binned1.emgdatabin; EMGs2= binned2.emgdatabin;
EMGacrossTasks = cat(1,EMGs1,EMGs2);
SortedEMGacrossTasks = sort(EMGacrossTasks,'descend');
NinetyNinthEMGpercentile = SortedEMGacrossTasks(floor(.0005*length(SortedEMGacrossTasks)),:);
for a=1:length(NinetyNinthEMGpercentile)
EMGs1Normed(:,a) = EMGs1(:,a)./ NinetyNinthEMGpercentile(a);
EMGs2Normed(:,a) = EMGs2(:,a)./ NinetyNinthEMGpercentile(a);
end
NormalizedBinned1=binned1; NormalizedBinned1.emgdatabin=EMGs1Normed;
NormalizedBinned2=binned2; NormalizedBinned2.emgdatabin=EMGs2Normed;

end