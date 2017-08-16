

function shitsignal=byebyeoutliers(shitsignal);
mult=10;
STDtimes=std(shitsignal)*mult;
highIndices=find(shitsignal>STDtimes);
for a=1:length(highIndices)
    back=10;
    if highIndices(1)<=back
        back = highIndices(1)-1;
    end        
    one99=199;
    if highIndices(1)+one99>length(shitsignal)
        one99=length(shitsignal)-highIndices(1)-1;
    end
    segment=(shitsignal(highIndices(1)-back:highIndices(1)+one99));
    %     plot(segment);hold on
    %     plot(x,y)
    theDiff = diff(sign(segment));
    GoingNegative = find(theDiff<0);
    if length(GoingNegative<2)
        endEpoch=one99+1;
    else endEpoch = GoingNegative(2); %the second time the signal goes negative (should be after the hump)
    end
    newVals = zeros(1,endEpoch+back);
    shitsignal(highIndices(1)-back:highIndices(1)+endEpoch-1)=newVals;
    highIndices=find(shitsignal>STDtimes);
    if isempty(highIndices)
        break
    end
end

