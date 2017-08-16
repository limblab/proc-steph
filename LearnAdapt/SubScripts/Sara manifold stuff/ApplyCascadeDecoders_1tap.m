function [EMGpreds, CursorPreds, recordedEMG, recordedPos] = ApplyCascadeDecoders_1tap(binnedData,N2E,E2F)


[Pred_EMG_struct] = predictSignals(N2E, binnedData);
EMGpreds=Pred_EMG_struct.preddatabin;

% Calculate how many taps
NumberOfTaps=1

% Apply E2F to predicted EMGs to get Cursor Position (force) predictions
%recordedEMG=binnedData.emgdatabin(NumberOfTaps:end,:);
recordedEMG=binnedData.emgdatabin;
% Have to deal with the offset! (remove last 9 bins of time and spike data)
binnedData.timeframe=binnedData.timeframe(1:end-(NumberOfTaps-1));
%binnedData.cursorposbin=binnedData.cursorposbin(1:end-(NumberOfTaps-1),:);
binnedData.spikeratedata=binnedData.spikeratedata(1:end-(NumberOfTaps-1),:);
binnedData.emgdatabin=EMGpreds; % replace real EMGs with predicted EMGs
[Pred_cursor_struct] = predictSignals_predMIMO3(E2F, binnedData);
CursorPreds=Pred_cursor_struct.preddatabin;
NumberOfTaps_E2F=E2F.fillen/E2F.binsize;
%recordedPos=binnedData.cursorposbin(NumberOfTaps_E2F:end,:);
recordedPos=binnedData.cursorposbin;

end