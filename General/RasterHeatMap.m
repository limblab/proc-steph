% RasterHeatMap


figure
neuronsubset=binnedData.spikeratedata(start:stop,:)';
 neuronsubset = neuronsubset./(max(max(neuronsubset)));
imagesc(neuronsubset);
