function [ConfidenceBoundWidth PDsWithin25CB] = KO_FindConfidenceBounds(bootstrappedPDs);

processedPD = nan(length(bootstrappedPDs(:,1)),1000);
ConfidenceBoundWidth = nan(length(bootstrappedPDs(:,1)),1);
for PDindex=1:length(bootstrappedPDs(:,1)) 
    processedPD(PDindex,1:1000)=bootstrappedPDs(PDindex,:)-median(bootstrappedPDs(PDindex,:));
    for a=1:length(processedPD(PDindex,:))
        if processedPD(PDindex,a)<=-180;
            processedPD(PDindex,a)=processedPD(PDindex,a)+360;
        end
    end
    for a=1:length(processedPD(PDindex,:))
        if processedPD(PDindex,a)>=180;
            processedPD(PDindex,a)=processedPD(PDindex,a)-360;
        end
    end
        processedPD(PDindex,:)=sort(processedPD(PDindex,:));
    % Subtract value at index 26 from value at index 974 (gettng rid of top
    % and bottom 2.5% of 1000)
    ConfidenceBoundWidth(PDindex)=processedPD(PDindex,974)-processedPD(PDindex,26);
end

PDsWithin25CB = find(ConfidenceBoundWidth<=25&ConfidenceBoundWidth>=-25&ConfidenceBoundWidth~=0);

    