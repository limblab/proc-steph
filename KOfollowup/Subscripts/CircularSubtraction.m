function dPD = CircularSubtraction(value1, value2)

for ind=1:length(value1)
    dPD(ind,1) = mod(value1(ind)-value2(ind),360);
    if dPD(ind,1) > 180
        dPD(ind,1)=mod(value2(ind)-value1(ind),360);
    else
        dPD(ind,1) = -1*dPD(ind,1);
    end
end



% for a=1:length(value1)
% if (360-value1) <=180
%     distanceFrom360 = 360-value1;
% end
% if (value2-0) <=180
%     distanceFrom0 = value2-0;
% end
%    difference= distanceFrom360+distanceFrom0;
% end