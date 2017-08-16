function [H] = quickHybridDecoder(HybridFinal)

Y = HybridFinal.emgdatabin;
X = HybridFinal.spikeratedata;

% This flag tells you if you are in a stretch of iso or wm data
flag = HybridFinal.taskflag;

% Do a weighted mean subtraction of the inputs and outputs before scaling
% them. The weights for the weighted mean subtraction come from calculating
% the var ratios between the EMGs (output) two signals of interest
% Movement
%WeightedMovementMuscleMean = (Y(12001:24000,:).*repmat(HybridFinal.scale(:,1)',12000,1))/(sum(HybridFinal.scale(:,1)));
%WeightedMovementNeuralMean = (X(12001:24000,:).*repmat(HybridFinal.scale(:,1)',12000,1))/(sum(HybridFinal.scale(:,1)));


%WeightedSpringMuscleMean = (Y(24001:36000,:).*repmat(HybridFinal.scale(:,2)',12000,1))/(sum(HybridFinal.scale(:,2)));%


for i = 1:length(HybridFinal.emgdatabin(1,:))
    % Scale is a ratio dictated in the makeHybrid script
    scale = HybridFinal.scale(i,1);
    scale_vec=(flag+(1-flag)*scale).^2;
    scale_vec(24000:36000)=(flag(24000:36000)+(1-flag(24000:36000))*HybridFinal.scale(i,2)).^2;
    
    scaled_X = repmat(scale_vec,1,size(X,2)).*X;
    scaled_Y = repmat(scale_vec,1,size(Y,2)).*Y;
    
    Hnew=filMIMO3(scaled_X,scaled_Y,10,1,1); % Now using filMIMO3 cause it doesn't detrend
    H(:,i) = Hnew(:,i);
end
 