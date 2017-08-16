function [File1, File2] = SameNeuronsAcrossBinnedDataFiles(File1,File2)

badUnits = checkUnitGuides_sn(File1.neuronIDs,File2.neuronIDs);
newIDs = setdiff(File1.neuronIDs, badUnits, 'rows');
if ~(isempty(badUnits))
    File1.spikeguide = []; File2.spikeguide = [];
    for i = 1:length(badUnits(:,1))
        % Find index of neuronIDs
        badUnitInd = find(File1.neuronIDs(:,1) == badUnits(i,1) & File1.neuronIDs(:,2) == badUnits(i,2));
        File1.spikeratedata(:,badUnitInd) = [];
        File1.neuronIDs(badUnitInd,:)=[]; % Update neuronIDs for file 1
         
        badUnitInd = find(File2.neuronIDs(:,1) == badUnits(i,1) & File2.neuronIDs(:,2) == badUnits(i,2));
        File2.spikeratedata(:,badUnitInd) = [];
        File2.neuronIDs(badUnitInd,:)=[]; % Update neuronIDs for file 2
    end
    
end