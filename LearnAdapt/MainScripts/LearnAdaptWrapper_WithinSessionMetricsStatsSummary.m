function [statsVarSummary, statsVarTally] = LearnAdaptWrapper_WithinSessionMetricsStatsSummary(statsVar)

% Run me after LearnAdaptWrapper_WithinSessionMetrics
% Example:
% [Rot_PL_StatsSummary Rot_PL_StatsTally]=LearnAdaptWrapper_WithinSessionMetricsStatsSummaryRotPathLength_PerTargetP)


for row = 1:length(statsVar(:,1))
    for col = 1:length(statsVar(1,:))
        if statsVar(row,col)<0.05
            statsVarSummary(row,col)=1;
        else if statsVar(row,col)>=0.05
                statsVarSummary(row,col)=0;
            end
        end
    end
end

statsVarTally=sum(statsVarSummary);

end