%samp freq 3051.76
% each data point is 1/SF apart
figure;plot(rawtwitch(:,1))
% 4 pulses times 13 stim points (stimVals) * 600 =31200 | 32 is the number
% of EMG channels
% each emg snippet is 600 points. 600*(1/sf) gives you time
% stim vals tells you what the PW or PA was
% can take an average of the 600 points for each of the four twitches, and then do the peak to peak of the average
% natalie took the peak to peak for each of the four, and took an average of the 4 peak to peak values

handles.EMGnames
