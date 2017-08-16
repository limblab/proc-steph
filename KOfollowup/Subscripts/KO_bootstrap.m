function BootstrappedTrialNumbers = KO_bootstrap(trialtable)
% 1000 resamples according to the Oby and Stevenson papers

% Get an array of trial number
numTrials = length(trialtable(:,1));
% Generate a list of random numbers between 1 and number of trials 
%(repeats allowed)
BootstrappedTrialNumbers=ceil(rand(numTrials,1)*numTrials); % random number

end