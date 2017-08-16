

% what happens when EMG is 1 ----------------------------------------------
FullFCUbinned = binnedIsoHC;
newEMGs=zeros(length(binnedIsoHC.timeframe),4);
EMGones=ones(length(binnedIsoHC.timeframe),1);
newEMGs(1:end,1)=EMGones;
FullFCUbinned.emgdatabin=newEMGs;
[Pred_cursor_struct] = predictSignals_predMIMO3(E2F_normal, FullFCUbinned);
CursorPreds=Pred_cursor_struct.preddatabin;
%   8.2509   -2.9366

FullFCRbinned = binnedIsoHC;
newEMGs=zeros(length(binnedIsoHC.timeframe),4);
EMGones=ones(length(binnedIsoHC.timeframe),1);
newEMGs(1:end,2)=EMGones;
FullFCRbinned.emgdatabin=newEMGs;
[Pred_cursor_struct] = predictSignals_predMIMO3(E2F_normal, FullFCRbinned);
CursorPreds=Pred_cursor_struct.preddatabin;
% 2.0730   12.9141

FullECUbinned = binnedIsoHC;
newEMGs=zeros(length(binnedIsoHC.timeframe),4);
EMGones=ones(length(binnedIsoHC.timeframe),1);
newEMGs(1:end,3)=EMGones;
FullECUbinned.emgdatabin=newEMGs;
[Pred_cursor_struct] = predictSignals_predMIMO3(E2F_normal, FullECUbinned);
CursorPreds=Pred_cursor_struct.preddatabin;
%   -10.5507  -11.5596


FullECRbinned = binnedIsoHC;
newEMGs=zeros(length(binnedIsoHC.timeframe),4);
EMGones=ones(length(binnedIsoHC.timeframe),1);
newEMGs(1:end,4)=EMGones;
FullECRbinned.emgdatabin=newEMGs;
[Pred_cursor_struct] = predictSignals_predMIMO3(E2F_normal, FullECRbinned);
CursorPreds=Pred_cursor_struct.preddatabin;
% -8.9567    6.0613


% What happens when neuron is 1
FullNeuron1binned = binnedIsoHC;
newSpikes=zeros(length(binnedIsoHC.timeframe),length(binnedIsoHC.spikeratedata(1,:)));
SpikeMax=160*ones(length(binnedIsoHC.timeframe),1);
newSpikes(1:end,1)=SpikeMax;
FullNeuron1binned.spikeratedata=newSpikes;
[EMGs, Force] = ApplyCascadeDecoders(FullNeuron1binned, N2E, E2F_normal);
figure; plot(Force)
[EMGs, Force] = ApplyCascadeDecoders(FullNeuron1binned, N2E, E2F_reflected);
Force(1,:)
EMGs(1,:)




