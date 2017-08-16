function TargetPathLength = SeparatePathLengthByTarget(TargetNumber,AllPathLengths,TgtNum)


TargetIndices=find(TargetNumber==TgtNum);
TargetPathLength = AllPathLengths(TargetIndices);

end