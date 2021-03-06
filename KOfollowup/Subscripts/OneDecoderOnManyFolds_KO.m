function [R2, varargout] = OneDecoderOnManyFolds_KO(filter,binnedData,foldlength,varargin)

%       R2                  : returns a (numFold,numSignals) array of R2 values 
%
%       filter              : decoder
%       binnedData          : data structure to build model from
%       foldlength          : fold length in seconds
%       varargin            : [Adapt Smooth];
%       varargout = {filter, vaf, mse, PredData, ActSignalsTrunk};

numPredSigs = size(char(filter.outnames),1);
binsize = filter.binsize;
numlags = round(filter.fillen/binsize);
numpts  = size(binnedData.timeframe,1);
numNeur = size(filter.neuronIDs,1);

if nargin > 3
    Adapt = varargin{1};
    % sliding window of input R2 every Adapt.NeurWindow bins
    numCorrSteps   = floor(numpts/Adapt.NcorrWindow);
    NR2 = NaN(numCorrSteps,numNeur);
    NPred = zeros(Adapt.NcorrWindow,numNeur);
    
    if nargin > 4
        Smooth = varargin{2};
    else
        Smooth = false;
    end
else
    Adapt.Enable = false;
    Smooth = false;
end

if mod(round(foldlength*1000), round(binsize*1000)) %all this rounding because of floating point errors
    disp('specified fold length must be a multiple of the data bin size');
    disp('operation aborted');
    return;
else
    %convert foldlenght from seconds to bins
    foldlength = round(foldlength/binsize);
end



       

% Make outputs predictions:
if isfield(filter, 'PC')
    numPCs = size(filter.PC,2);
    [PredData, Hnew] = predictSignals(filter,binnedData,Smooth,Adapt,numPCs);
else
    [PredData, Hnew] = predictSignals(filter,binnedData,Smooth,Adapt);
end



duration = size(binnedData.timeframe,1)-numlags+1;
nfold = floor(duration/foldlength);

R2 = zeros(nfold,numPredSigs);
vaf= zeros(nfold,1);
mse= zeros(nfold,numPredSigs);

%% match predicted and actual data wrt to timeframes and outputs

% idx = false(size(binnedData.timeframe));
% for i = 1:length(PredData.timeframe)
%     idx = idx | binnedData.timeframe == PredData.timeframe(i);
% end

ActSignalsTrunk = zeros(numpts-numlags+1,numPredSigs);

for i=1    %:numPredSigs  <- removed this. this doesnt need to be a for loop
    if isfield(binnedData,'emgdatabin')
        if ~isempty(binnedData.emgdatabin) 
            if all(strcmp(nonzeros(char(binnedData.emgguide(:,1))),nonzeros(char(PredData.outnames(:,1))))) 
                ActSignalsTrunk(:,i:i+size(binnedData.emgdatabin,2)-1) = binnedData.emgdatabin(numlags:end,:);
            end
        end
    end
    if isfield(binnedData,'forcedatabin')
        if ~isempty(binnedData.forcedatabin)
            if all(strcmp(nonzeros(char(binnedData.forcelabels(:,1))),nonzeros(char(PredData.outnames(:,1)))))
                ActSignalsTrunk(:,i:i+size(binnedData.forcedatabin,2)-1) = binnedData.forcedatabin(numlags:end,:);
            end
        end
    end
    if isfield(binnedData,'cursorposbin')
        if ~isempty(binnedData.cursorposbin)
            if all(strcmp(nonzeros(char(binnedData.cursorposlabels(:,1))),nonzeros(char(PredData.outnames(:,1)))))
                ActSignalsTrunk(:,i:i+size(binnedData.cursorposbin,2)-1) = binnedData.cursorposbin(numlags:end,:);
            end
        end
    end

    if isfield(binnedData,'velocbin')
        if ~isempty(binnedData.velocbin)
            if all(strcmp(nonzeros(char(binnedData.veloclabels(:,1))),nonzeros(char(PredData.outnames(:,1)))))
                ActSignalsTrunk(:,i:i+size(binnedData.velocbin,2)-1) = binnedData.velocbin(numlags:end,:);
            end
        end
    end
end

%% Calculate R2, vaf and mse for every fold, skip remaining time
for i=1:nfold
    
    %move the test block from beginning of file up to the end
    DataStart = (i-1)*foldlength+1;
    DataEnd   = DataStart + foldlength - 1;
    Act       = ActSignalsTrunk(DataStart:DataEnd,:);
    Pred      = PredData.preddatabin(DataStart:DataEnd,:);
    
    % Calculate prediction accuracy
    R2(i,:)   = CalculateR2(Act,Pred)';
     mse(i,:)  = mean((Pred-Act).^2);
    % Calculate multivariate VAF
    for ind=1:length(Pred)
        PredNorm(ind,1) = norm(Pred(ind,:));
        ActNorm(ind,1) = norm(Act(ind,:));
    end
        vaf(i)  = 1 - sum( (PredNorm-ActNorm).^2 ) ./ sum( (ActNorm - repmat(mean(ActNorm),size(ActNorm,1),1)).^2 );
        IndividualEMGVAFsForEachFold(i,:)  = 1 - sum( (Pred-Act).^2 ) ./ sum( (Act - repmat(mean(Act),size(Act,1),1)).^2 );
        

end



varargout = {filter, PredData, vaf, mse, ActSignalsTrunk IndividualEMGVAFsForEachFold};
   