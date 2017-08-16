function reducedBinnedData = ReduceBinnedToFourWristMuscles(binnedData)

FCUind = strmatch('FCU',binnedData.emgguide(1,:)); FCUind = FCUind(1);
FCRind = strmatch('FCR',binnedData.emgguide(1,:)); FCRind = FCRind(1);
ECUind = strmatch('ECU',binnedData.emgguide(1,:)); ECUind = ECUind(1);
ECRind = strmatch('ECR',binnedData.emgguide(1,:)); ECRind = ECRind(1);
emg_vector = [FCUind FCRind ECUind ECRind];
reducedBinnedData = binnedData;
reducedBinnedData.emgdatabin = binnedData.emgdatabin(:,emg_vector);
reducedBinnedData.emgguide = binnedData.emgguide(emg_vector);

end