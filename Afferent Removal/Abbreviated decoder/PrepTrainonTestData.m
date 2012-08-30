%PrepTrainonTestData
% For BDF struct

tic

%Run the code on the bdf data to get your trial table
trialtable = wf_trial_table(out_struct);
trialtable(66,:) = [];
trialtable(116,:) = [];


%Instead of cursor position, use the center of the outer target as the
%position for each individual trial
% for a = 1:length(trialtable)
% for b = 1:length(out_struct.pos)
%     if out_struct.pos(b, 1) >= trialtable(a,7) && out_struct.pos(b, 1) <= trialtable(a,8)
%         xCenter = (trialtable(a,4)-trialtable(a,2))/2;
%         yCenter = (trialtable(a,5)-trialtable(a,3))/2;         
%         out_struct.pos(b,2) = xCenter;
%         out_struct.pos(b,3) = yCenter;
%     end
% end
% end

newPos = zeros(length(out_struct.pos),3);
fullind = [];
% Get rid of everything except the data 1 second before the trial ends
for a = 1:length(trialtable) 
    ind = find(out_struct.pos(:,1) >= (trialtable(a,8)-1) & out_struct.pos(:,1) <= trialtable(a,8));
    fullind = cat(1,fullind, ind);
        xCenter = (trialtable(a,4)+trialtable(a,2))/2;
        yCenter = (trialtable(a,5)+trialtable(a,3))/2;
        newPos(ind,2) = xCenter;
        newPos(ind,3) = yCenter;
end


emptyind = find(newPos(:,2) == 0 & newPos(:,3) == 0);
newPos(emptyind,:) = [];
newPos(:,1) = 0:0.001:(0.001*length(newPos)-0.001);

%Badind = 1:1:length(out_struct.pos); Badind(fullind) = [];


%Pare down neural data
NumOfNeurons = length(out_struct.units);
FullNeurind = []; BadNeurind = []; Neurind = [];
for N = 1:length(out_struct.units)
    for a = 1:length(trialtable)
        Neurind = find(out_struct.units(1,N).ts  >= (trialtable(a,8)-1) & out_struct.units(1,N).ts  <= trialtable(a,8));
        FullNeurind = cat(1, FullNeurind, Neurind);
    end
    BadNeurind = 1:1:length(out_struct.units(1,N).ts); BadNeurind(FullNeurind) = [];
    out_struct.units(1,N).ts(BadNeurind) = [];
    BadNeurind = []; FullNeurind = [];
end

out_struct.pos = newPos;


toc
