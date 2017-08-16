%Fish_WirelessRecordingCageAndLab_July182016
% This script takes a section of the cage data (file 002) where Fish was
% mostly picking up treats from the holes in the front of the cage and
% makes within mfxval predictions. I also make a decoder from these data
% and apply it to data we collected in the cage (isometric, picking up
% treats, and tube)

% Info about the cage files
% 001: Did the bimanual task with him. He did it in spurts..I vaguely
% remember around 7, 20, 24 minutes him doing the task.
% 002: Picked up treats from me through the holes at the front of the cage.

% load nev file into matlab
%nevData = openNEVLimblab('Z:\data\Fish_12H2\Cerebus Data\Cage Data\07182016\Fish_WirelessM1andEMGincage_07182016_002.nev','read');



load('C:\Users\LimbLabSteph\Documents\GitHub\proc-steph\FES\Standard2WirelessUtahChannelTransform.mat')
for ind=1:size(Standard2WirelessUtahTransform,1)
    newUnits(ind,:)=out_struct.units(:,Standard2WirelessUtahTransform.Wireless(ind));
end

% Load 002 file of binned cage data from July 18, 2016
load('Z:\data\Fish_12H2\BinnedData\InCage\07-18-2016\Fish_WirelessM1andEMGincage_07182016_002.mat')
% Only take the data from 4 to 14 minutes (10 minutes total. He was mostly
% picking up treats from holes in the front of the cage from me during this
% time)
BinnedCageTreats = cutBinnedDataFile_CageData(binnedData, 1, 4800); %Gets rid of the first 4 minutes
BinnedCageTreats = cutBinnedDataFile_CageData(BinnedCageTreats, 12000, length(BinnedCageTreats.emgdatabin)); % Gets rid of everything after 10 minutes (after 14 minutes of the original)


cutfile=cutBinnedDataFile_CageData(binnedData, 1, 3900);
cutfile=cutBinnedDataFile_CageData(cutfile, 15000, length(cutfile.emgdatabin));
%

% Load Standard 2 Wireless Transform
load('C:\Users\LimbLabSteph\Documents\GitHub\proc-steph\FES\Standard2WirelessUtahChannelTransform.mat')
for ind=1:size(Standard2WirelessUtahTransform,1)
    newNeurons(1:length(BinnedCageTreats.spikeratedata),ind)=BinnedCageTreats.spikeratedata(:,Standard2WirelessUtahTransform.Wireless(ind));
end
% Replace Cage Neurons with the Standard Wired Neuron Configuration
BinnedCageTreats.spikeratedata=newNeurons;

% Notes:
% In lab tube decoder makes okay across predictions to treats (2nd order)
% 	R2  	vaf  	mse
% FCRr	0.311	0.275	839.86
% ECRl	0.473	0.471	1147.14
% FCU2	0.028	-0.070	953.82
% FDPu	0.028	-5.747	8924.00
% FDPr	0.191	0.128	203.65
% FDS2	0.203	0.137	683.59
% PL	0.324	0.319	187.42
% PT	0.319	0.301	442.64
% SUP	0.655	0.654	102.14
% APB	0.396	0.276	6111.38
% FPB	0.409	0.327	771.38
% EDC12	0.484	0.448	2495.44
% EPL	0.702	0.698	394.07
% ECUu	0.464	0.445	1865.32

% In lab tube decoder makes lousy across predictions to lab isometric
% R2  	vaf  	mse
% FCRr	0.085	0.056	938.55
% ECRl	0.026	-0.022	2111.08
% FCU2	0.014	-0.168	991.65
% FDPu	0.010	-9.637	8880.18
% FDPr	0.097	-0.486	201.16
% FDS2	0.131	0.126	1414.04
% PL	0.061	-0.073	338.77
% PT	0.015	-0.164	128.72
% SUP	0.284	0.252	163.52
% APB	0.007	-0.084	1449.93
% FPB	0.000	-0.640	149.75
% EDC12	0.065	-0.059	15492.33
% EPL	0.396	0.135	2723.92
% ECUu	0.025	-0.205	2374.70
% unknown1	0.003	-0.280	7.47
% unknown2	0.004	-0.367	5.94
% Averages:	0.076	-0.726	2335.73



% Decoder made from all 001 cage decoder makes lousy predictions of 002
% cage data
% 	R2  	vaf  	mse
% FCRr	0.154	-0.720	4348.62
% ECRl	0.163	-0.941	6001.56
% FCU2	0.164	-2.216	11417.88
% FDPu	0.187	0.024	1299.07
% FDPr	0.093	-0.031	497.50
% FDS2	0.104	-1.910	4252.06
% PL	0.113	-2.405	3604.50
% PT	0.067	-0.199	537.27
% SUP	0.194	0.092	356.68
% APB	0.308	0.302	2491.00
% FPB	0.279	0.276	501.09
% EDC12	0.331	0.322	3570.35
% EPL	0.246	0.231	698.68
% ECUu	0.085	-5.365	13150.83

% All 002 cage data mfxval
% 	R2  	vaf  	mse
% FCRr	0.331	0.329	1706.25
% ECRl	0.346	0.344	2039.85
% FCU2	0.513	0.512	1734.06
% FDPu	0.257	0.257	993.83
% FDPr	0.110	0.100	435.37
% FDS2	0.323	0.320	999.52
% PL	0.376	0.375	665.12
% PT	0.180	0.168	374.95
% SUP	0.278	0.276	286.00
% APB	0.321	0.319	2431.23
% FPB	0.311	0.308	479.65
% EDC12	0.491	0.489	2688.37
% EPL	0.333	0.331	610.21
% ECUu	0.418	0.414	1216.29

% Decoder made from all 002 cage data makes okay predictions of some 001 EMGs
% (2nd order)
%         R2  	vaf  	mse
% FCRr	0.263	0.250	1521.31
% ECRl	0.334	0.326	1733.60
% FCU2	0.507	0.478	1821.74
% FDPu	0.121	-0.018	2032.80
% FDPr	0.087	-0.011	798.14
% FDS2	0.205	0.113	1449.74
% PL    0.333	0.315	738.46
% PT    0.040	-0.047	453.17
% SUP   0.208	0.185	430.54
% APB   0.310	0.278	1683.84
% FPB   0.200	0.176	520.87
% EDC12	0.283	0.129	2351.43
% EPL   0.276	0.270	757.12
% ECUu	0.404	0.403	1166.04



