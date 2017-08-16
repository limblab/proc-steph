%Jango_ComputeBinarySuccessSignificance_FirstLastDay

NumOfSamples=80;

% Day one rotated
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_080415_binnedDec_rot.mat')
[BinarySuccess, BinaryTargets] = BinaryPercentSuccess(binnedRotatedBC);
Points=BinarySuccess(1:NumOfSamples);
SuccessPoints1=(length(find(Points==1)))/length(Points);

clearvars -except SuccessPoints1 NumOfSamples

% Last day rotated
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_092915_binnedDec_rot.mat')
[BinarySuccess, BinaryTargets] = BinaryPercentSuccess(binnedRotatedBC);
Points=BinarySuccess(1:NumOfSamples);
SuccessPoints2=(length(find(Points==1)))/length(Points);

AllSuccessPoints =[SuccessPoints1 SuccessPoints2];
[pval_rot] = getCHIpValue(AllSuccessPoints,NumOfSamples)

clearvars -except NumOfSamples

% Day one reflected
NumOfSamples=40;
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_073115_binnedDec_ref.mat')
[BinarySuccess, BinaryTargets] = BinaryPercentSuccess(binnedReflectedBC);
Points=BinarySuccess(1:NumOfSamples);
SuccessPoints1=(length(find(Points==1)))/length(Points);

clearvars -except SuccessPoints1 NumOfSamples

% Last day rotated
load('C:\Stephanie\Data\LearnAdapt\Jango\BinnedAndDecoders\LongPert_Jango_092815_binnedDec_ref.mat')
[BinarySuccess, BinaryTargets] = BinaryPercentSuccess(binnedReflectedBC);
Points=BinarySuccess(1:NumOfSamples);
SuccessPoints2=(length(find(Points==1)))/length(Points);

AllSuccessPoints =[SuccessPoints1 SuccessPoints2];
[pval_ref] = getCHIpValue(AllSuccessPoints,NumOfSamples)

