%Kevin_ComputeBinarySuccessSignificance_FirstLastDay

NumOfSamples=40;

% Day one rotated
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\ShorPert_Kevin_040315_binnedDec_rot.mat')
[BinarySuccess, BinaryTargets] = BinaryPercentSuccess(binnedRotated1);
Points=BinarySuccess(1:NumOfSamples);
SuccessPoints1=(length(find(Points==1)))/length(Points);

clearvars -except SuccessPoints1 NumOfSamples

% Last day rotated
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_061315_binnedDec_rot.mat')
[BinarySuccess, BinaryTargets] = BinaryPercentSuccess(binnedRotatedBC);
Points=BinarySuccess(1:NumOfSamples);
SuccessPoints2=(length(find(Points==1)))/length(Points);

AllSuccessPoints =[SuccessPoints1 SuccessPoints2];
[pval_rot] = getCHIpValue(AllSuccessPoints,NumOfSamples)

clearvars -except NumOfSamples

% Day one reflected
NumOfSamples=40;
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\ShorPert_Kevin_040215_binnedDec_ref.mat')
[BinarySuccess, BinaryTargets] = BinaryPercentSuccess(binnedReflected1);
Points=BinarySuccess(1:NumOfSamples);
SuccessPoints1=(length(find(Points==1)))/length(Points);

clearvars -except SuccessPoints1 NumOfSamples

% Last day rotated
load('C:\Stephanie\Data\LearnAdapt\Kevin\BinnedAndDecoders\LongPert_Kevin_062515_binnedDec_ref.mat')
[BinarySuccess, BinaryTargets] = BinaryPercentSuccess(binnedReflectedBC);
Points=BinarySuccess(1:NumOfSamples);
SuccessPoints2=(length(find(Points==1)))/length(Points);

AllSuccessPoints =[SuccessPoints1 SuccessPoints2];
[pval_ref] = getCHIpValue(AllSuccessPoints,NumOfSamples)

