function MetricPerTargetCell=SeparateOutByTarget(Metric, TargetNumber)

for TgtInd=1:8
    targetIndices=find(TargetNumber==TgtInd);
    MetricPerTargetCell{TgtInd} = Metric(targetIndices);
    targetIndices=[];
end

end