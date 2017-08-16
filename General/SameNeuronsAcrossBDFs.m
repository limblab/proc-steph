function [file1, file2] = SameNeuronsAcrossBDFs(file1,file2)

allUnits1=[];allUnits2=[];
for ind=1:length(file1.units)
    allUnits1 = cat(1,allUnits1,file1.units(ind).id);
end
for ind=1:length(file2.units)
    allUnits2 = cat(1,allUnits2,file2.units(ind).id);
end

 % Find the units that are in File1 but not in File2 and remove
[~, UnitIndex1] = setdiff(allUnits1,allUnits2);
file1.units(UnitIndex1) = [];
% Update unit list for the first file
allUnits1=[];
for ind=1:length(file1.units)
    allUnits1 = cat(1,allUnits1,file1.units(ind).id);
end

% Find the units that are in File2 but not in File1 and remove
[~, UnitIndex2] = setdiff(allUnits2,allUnits1); 
file2.units(UnitIndex2) = [];

end

